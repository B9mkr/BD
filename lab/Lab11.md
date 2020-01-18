# DML(Lab11.pdf)

### ZADANIE 1

Z tabeli Egzaminy usunąć egzaminy przeprowadzone z przedmiotu ‘Bazy danych’ w ośrodkach o nazwie ‘Katedra Matematyki’ oraz ‘Katedra Elektroniki PL’.

```sql
DELETE e FROM egzaminy e
INNER JOIN osrodki ON `osrodki`.`id-osrodek` = e.`id-osrodek`
INNER JOIN przedmioty ON `przedmioty`.`id-przedmiot` = e.`id-przedmiot`
WHERE `przedmioty`.`nazwa-p` = "Bazy danych"
AND (
    osrodki.`nazwa-o` = "Katedra Matematyki"
    OR`osrodki`.`nazwa-o` = "Katedra Elektroniki PL" 
    )
```

### ZADANIE 2

Usuń z tabeli Ośrodki wszystkie ośrodki, w których nie zdano jeszcze żadnego egzaminu.

```sql
DELETE FROM osrodki 
WHERE `id-osrodek` IN (
    SELECT x.`id-osrodek` 
    FROM (
        SELECT o.`id-osrodek` FROM egzaminy e
        RIGHT JOIN osrodki o ON `o`.`id-osrodek` = `e`.`id-osrodek`
        WHERE e.zdal = 0 OR e.zdal IS NULL
        GROUP BY o.`id-osrodek`
    ) as x 
)
```

### ZADANIE 3

Zaktualizuj numer faxu na 815556677 tym wykładowcom, u których zdało egzamin więcej niż 3
studentów.

```sql
UPDATE wykladowcy w,
(SELECT `id-wykladowca`, COUNT(`nr-egz`) AS liczbaEgzaminow,  zdal FROM egzaminy
WHERE zdal = 1
GROUP BY `id-wykladowca`
HAVING liczbaEgzaminow > 3) AS x
SET w.fax = "815556677"
WHERE w.`id-wykladowcy` = x.`id-wykladowca`
```

### ZADANIE 4

Z tabeli Egzaminy usuń informacje o tych egzaminach, które przeprowadzał wykładowca o nazwisku
Laskowski w ośrodku innym niż Instytut Informatyki.

```sql
DELETE e FROM egzaminy e
INNER JOIN wykladowcy w ON w.`id-wykladowcy` = e.`id-wykladowca`
INNER JOIN osrodki o ON o.`id-osrodek` = `e`.`id-osrodek` 
WHERE w.nazwisko = "Laskowski" AND `o`.`nazwa-o` != "Instytut Informatyki PL"
```

### ZADANIE 5

Korzystając z polecenia CREATE AS SELECT utwórz tabelę Asy, w której umieść dane o trzech
studentach, którzy zdali najwięcej egzaminów. W nowej tabeli powinny znajdować się następujące
dane: imię i nazwisko (w jednym polu), numer indeksu oraz poprawnie nazwane pole z liczbą zdanych
egzaminów.

```sql
CREATE TABLE Asy 
AS 
SELECT CONCAT(s.imie, " ", s.nazwisko) AS student, `s`.`id-student`, COUNT(`nr-egz`) AS liczbaZdanychEgzaminow 
FROM egzaminy
INNER JOIN studenci s ON `s`.`id-student` = `egzaminy`.`id-student`
GROUP BY `id-student`
ORDER BY liczbaZdanychEgzaminow DESC
LIMIT 3
```

### ZADANIE 6

Korzystając z polecenia CREATE AS SELECT utwórz tabelę ‘LubiaSie’ zawierającą identyfikatory oraz
imiona i nazwiska tych egzaminatorów i studentów, którzy spotkali się na egzaminie więcej niż raz
(bez względu na wynik tego spotkania).

```sql
CREATE TABLE LubiaSie 
AS
SELECT `w`.`id-wykladowcy`, CONCAT( w.imie, " ", w.nazwisko) AS wykladowca, 
`s`.`id-student`, CONCAT(s.imie, " ", s.nazwisko) AS student
FROM egzaminy e
INNER JOIN wykladowcy w ON `w`.`id-wykladowcy` = `e`.`id-wykladowca`
INNER JOIN studenci s ON s.`id-student` = e.`id-student`
GROUP BY `id-student`, `id-wykladowcy`
HAVING COUNT(`nr-egz`)  > 1
ORDER BY `id-wykladowcy`, `id-student`
```

### ZADANIE 7

Z tabeli Studenci usuń informację o tych studentach, których dane znajdują się w tabeli Asy.

```sql
DELETE FROM studenci
WHERE `id-student` IN (
    SELECT x.`id-student` FROM
    (
        SELECT `id-student` FROM asy
    ) as x
    )
```

### ZADANIE 8

Z tabeli egzaminy usuń wszystkie egzaminy, które nie zostały zdane przed końcem XX wieku.

```sql
DELETE e FROM egzaminy e
WHERE zdal = 0 
AND data < "2000-01-01"
```

### ZADANIE 9

Z tabeli Wykladowcy usuń informację o tych wykładowcach, którzy przeprowadzili mniej niż 3
egzaminy.

```sql
DELETE FROM wykladowcy 
WHERE `id-wykladowcy` IN
(SELECT x.`id-wykladowcy` FROM
 (
SELECT `id-wykladowcy` FROM wykladowcy
LEFT JOIN egzaminy e ON `wykladowcy`.`id-wykladowcy`  = `e`.`id-wykladowca`
GROUP BY `id-wykladowcy`
HAVING COUNT(`nr-egz`)  < 3
ORDER BY `id-wykladowcy` DESC
) AS x
 )
```

### ZADANIE 10

Usuń studentów z tabeli Studenci mających „e” jako trzecią literę nazwiska.

```sql
DELETE s FROM studenci s
WHERE nazwisko LIKE '__e%'
```

### ZADANIE 11

Usuń wylosowanego egzaminatora.

```sql
DELETE FROM wykladowcy
WHERE `id-wykladowcy` IN
( SELECT x.`id-wykladowcy` 
 FROM 
 (
 SELECT `id-wykladowcy` FROM wykladowcy
 ORDER BY RAND()
 LIMIT 1 
 ) AS x
 )
```

### ZADANIE 12

Korzystając z polecenia select ... into outfile ‘nazwapliku’ wyeksportuj zawartość tabeli Przedmioty.

[http://dev.mysql.com/doc/refman/5.7/en/select-into.html](http://dev.mysql.com/doc/refman/5.7/en/select-into.html)

[http://dev.mysql.com/doc/refman/5.7/en/load-data.html](http://dev.mysql.com/doc/refman/5.7/en/load-data.html)

```sql
SELECT *
INTO OUTFILE 'dowolna sciezka'
FROM przedmioty
```

### ZADANIE 13

Korzystając z mysqldump wykonaj kopię zapasową pojedynczej tabeli, a następnie całej bazy danych.

[http://dev.mysql.com/doc/refman/5.7/en/mysqldump.html](http://dev.mysql.com/doc/refman/5.7/en/mysqldump.html)

```sql
```

### ZADANIE 14

Korzystając z mysql zaimportuj kopię zapasową z zadania 13 do nowej bazy danych.
http://dev.mysql.com/doc/refman/5.7/en/mysql.html

```sql
```