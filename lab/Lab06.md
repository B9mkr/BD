## DQL – SELECT + INNER/OUTER JOIN (Lab06.pdf)

### ZADANIE 1

Ile egzaminów przeprowadzono w Instytucie Informatyki?

```sql
SELECT COUNT(eg.`id-osrodek`) AS 'ile egzaminow przeprowadzono'
FROM osrodki AS os, egzaminy AS eg
WHERE eg.`id-osrodek`=(
    SELECT DISTINCT osrodki.`id-osrodek` 
    FROM osrodki 
    WHERE osrodki.`nazwa-o`='Instytut Informatyki PL')
```

### ZADANIE 2

Ile egzaminów zdano w Instytucie Informatyki?

```sql
SELECT COUNT(*) AS 'Ilość egzaminów znanych w Instytuczie Informatyki'
FROM egzaminy e
INNER JOIN osrodki o
ON e.`id-osrodek`= o.`id-osrodek`
WHERE o.`nazwa-o`='Instytut Informatyki PL'
AND e.zdal=1;
```

### ZADANIE 3

Ile egzaminów przeprowadzono w Instytucie Informatyki z poszczególnych przedmiotów? Uwzględnij tylko te przedmioty, z których odbyły się egzaminy. Podaj nazwę ośrodka, nazwę przedmiotu oraz liczbę egzaminów.

My:

```sql
SELECT o.`nazwa-o`, p.`nazwa-p`, COUNT(*)
FROM egzaminy e
JOIN osrodki o  ON e.`id-osrodek` = o.`id-osrodek`
JOIN przedmioty p ON e.`id-przedmiot` = p.`id-przedmiot`
WHERE o.`nazwa-o`='Instytut Informatyki PL'
AND e.data <= CURDATE()
GROUP BY p.`nazwa-p`
```

```sql
Select `nazwa-o`,`nazwa-p`,COUNT(*) 
FROM egzaminy e
LEFT JOIN przedmioty p
ON `p`.`id-przedmiot`=`e`.`id-przedmiot`
INNER JOIN osrodki o
ON `e`.`id-osrodek` = o.`id-osrodek`
WHERE `o`.`nazwa-o` = 'Instytut Informatyki PL' AND `e`.`zdal` = 1
GROUP BY p.`nazwa-p`
```

### ZADANIE 4

Ile egzaminów przeprowadzono z poszczególnych przedmiotów? Weź pod uwagę wszystkie przedmioty (tzn. wszystkie przedmioty z tabeli ‘przedmioty’). Napisz 2 wersje zapytania – z RIGHT JOIN i LEFT JOIN.

```sql
SELECT p.`nazwa-p`, COUNT(*)
FROM przedmioty p
LEFT JOIN egzaminy e ON e.`id-przedmiot` = p.`id-przedmiot`
GROUP BY p.`nazwa-p`
```

### ZADANIE 5

Wyświetl datę pierwszego i ostatniego egzaminu każdego ze studentów. Uwzględnij tylko tych studentów, którzy zdawali egzaminy.

```sql
SELECT max(e.data), min(e.data)
FROM studenci s
INNER JOIN egzaminy e ON e.`id-student` = s.`id-student`
AND e.zdal = 1
GROUP BY e.`id-student`
```

### ZADANIE 6

Ile egzaminów zdawał każdy student u poszczególnych wykładowców? Weź pod uwagę tylko tych studentów i wykładowców, którzy spotkali się przynajmniej raz na egzaminie.

```sql
SELECT s.`id-student`, COUNT(*)
FROM studenci s
INNER JOIN egzaminy e ON e.`id-student` = s.`id-student`
INNER JOIN wykladowcy w ON e.`id-wykladowca` = w.`id-wykladowcy`
WHERE e.zdal = 1
GROUP BY e.`id-student`
```

### ZADANIE 7

Ilu egzaminów nie zdał każdy ze studentów?

-
```sql
SELECT s.`id-student`, COUNT(*)
FROM studenci s
INNER JOIN egzaminy e ON e.`id-student` = s.`id-student`
WHERE e.zdal = 0
GROUP BY e.`id-student`
```

### ZADANIE 8

Policz studentów, którzy nie podali numeru telefonu.

### ZADANIE 9

Wyświetl datę pierwszego i ostatniego przeprowadzonego egzaminu. Nadaj im etykiety odpowiednio ‘pierwszy egzamin’ oraz ‘ostatni egzamin’.

### ZADANIE 10

Wyświetl informację o tych studentach, którzy jeszcze nie mieli przyjemności zdawać żadnego egzaminu. Użyj NOT IN oraz podzapytania.

### ZADANIE 11

Wyświetl informację o tych studentach, którzy jeszcze nie mieli przyjemności zdawać żadnego egzaminu. Nie używaj NOT IN.

### ZADANIE 12

Ile egzaminów przeprowadzono w poszczególnych ośrodkach z poszczególnych przedmiotów przez poszczególnych wykładowców? Uwzględnij wszystkie ośrodki. Wyświetl nazwę ośrodka, nazwę przedmiotu, nazwisko i imię wykładowcy oraz liczbę egzaminów. 

http://weblogs.sqlteam.com/jeffs/archive/2007/10/11/mixing-inner-outer-joins-sql.aspx
http://stackoverflow.com/questions/473607/sql-server-combining-outer-and-inner-joins

### ZADANIE 13

Wyświetl w jednym wierszu liczbę przeprowadzonych egzaminów, najmniejszy i największy numer egzaminu.

### ZADANIE 14

Dla każdego przedmiotu (wyświetlić nazwę) podaj liczbę przeprowadzonych egzaminów, a także daty pierwszego i ostatniego egzaminu