# DML (Lab10.pdf)

### ZADANIE 1

Do tabeli Studenci dołącz informację o sobie. Wypełnij wszystkie pola.

```sql
INSERT INTO studenci (`id-student`, `nazwisko`, `imie`, `data-ur`, `miejsce`, `PESEL`, `kod-poczta`, `miasto`, `ulica`, `numer`, `tel`, `fax`, `e-mail`, `nr-dyplomu`, `data-dyplomu`)
VALUES (1002002, 'Mushka', 'Borys', '1999-09-18', 'Lublin', 99091883739, 20618, 'Lublin', 'Nadbystrzycka', 44, 815341148, '', 'mushka.borys99@gmail.com', '', '')

-- UPDATE `studenci` SET `data-ur` = '1999-08-18' WHERE `studenci`.`id-student` = '1002002';
```

### ZADANIE 2

Do tabeli Egzaminy dodaj informację o dwóch zdawanych przez siebie egzaminach w Instytucie Informatyki.

```sql
INSERT INTO egzaminy (`nr-egz`, `id-student`, `id-przedmiot`, `id-wykladowca`, `data`, `id-osrodek`, `zdal`)
VALUES (NULL, '01002002', '9 - Sieci rozległe', '0009-0009', '2002-3-15', '1 - Instytut Informatyki PL', 1);

INSERT INTO egzaminy (`nr-egz`, `id-student`, `id-przedmiot`, `id-wykladowca`, `data`, `id-osrodek`, `zdal`)
VALUES (NULL, 1002002, 8, 0011, '2002-3-23', 1, 1);
5,10 id przedmiotu
```

### ZADANIE 3

Do tabeli Przedmioty dodaj – przy pomocy jednego zapytania – dane o trzech przedmiotach:

Multimedia, Grafika 3D, Dydaktyka Informatyki.

```sql
INSERT INTO `przedmioty` (`nazwa-p`) 
VALUES 
("Multimedia"), 
("Grafika 3D"),
("Dydaktyka Informatyki")
```

### ZADANIE 4

Wstawić do tabeli Wykladowcy dane o nowym wykladowcy. Dane do wstawienia są następujące:

identyfikator – 0070, nazwisko – Bond, imię – James, miasto – Londyn.

```sql
INSERT INTO wykladowcy(`id-wykladowcy`, `nazwisko`, `imie`, miasto) 
VALUES ("0070", "Bond", "James", "London")
```

### ZADANIE 5

W tabeli Wykladowcy zmodyfikować dane o wykładowcy, który ma nazwisko Bond, wstawiając do kolumny E_mail wartość bond@gmail.com a do kolumny Telefon wartość 777777777.

```sql
UPDATE wykladowcy SET telefon="777777777" WHERE `id-wykladowcy` = "0070"
```

### ZADANIE 6

Zastąp dane egzaminu o identyfikatorze 1 danymi najpóźniej zdawanego egzaminu.

```sql
update egzaminy e, (
    select * from egzaminy
    where data=(
        select max(data)
        from egzaminy
    )
    limit 1
) a
set e.zdal=a.zdal,
    e.`id-przedmiot`=a.`id-przedmiot`,
    e.data=a.data,
    e.`id-student`=a.`id-student`,
    `e`.`id-osrodek` = a.`id-osrodek`,
    e.zdal = a.zdal
where e.`nr-egz`=1
```

### ZADANIE 7

Zaktualizuj pole Fax w tabeli Wykladowcy tak, aby wszyscy wykładowcy, którzy nie mieszkają w Lublinie mieli ten sam numer faksu – 22112222.

```sql
UPDATE wykladowcy w
SET w.fax = "22112222"
WHERE w.miasto != "Lublin"
```

### ZADANIE 8

W tabeli Egzaminy zaktualizuj dane egzaminów, które odbyły się po 1 maja 1998 i były zdawane w Katedrze Energetyki i Elektrochemii, przypisując je do Instytutu Informatyki.

```sql
UPDATE egzaminy e, (
    SELECT `id-osrodek`  FROM osrodki
    WHERE `nazwa-o` = "Katedra Energetyki i Elektrochemii" LIMIT 1
) AS Energia, (
        SELECT `id-osrodek`  FROM osrodki
        WHERE `nazwa-o` = "Instytut Informatyki PL" LIMIT 1
        ) AS Informatyka
SET `e`.`id-osrodek` = Informatyka.`id-osrodek`
WHERE e.data > "1998-06-01" AND 
    e.`id-osrodek` = Energia.`id-osrodek`
```

### ZADANIE 9

W tabeli Egzaminy zmodyfikować informacje o wykładowcach, którzy przeprowadzili egzaminy w ośrodku o nazwie 'Centrum Informatyczne PL' . Zastąpić identyfikator wykładowcy, przypisanego do egzaminów przeprowadzonych w ośrodku o tej nazwie, identyfikatorem 0004.

```sql
UPDATE egzaminy e, (
    SELECT `id-wykladowcy`FROM wykladowcy 
    INNER JOIN egzaminy ON `egzaminy`.`id-wykladowca` = `wykladowcy`.`id-wykladowcy`
    INNER JOIN osrodki ON `osrodki`.`id-osrodek` = `egzaminy`.`id-osrodek`
    WHERE `osrodki`.`nazwa-o` = "Centrum Informatyczne PL"
) AS x
SET `e`.`id-wykladowca` = "0004"
WHERE e.`id-wykladowca` = x.`id-wykladowcy`
```

### ZADANIE 10

Studentom, którzy w poprzednim zadaniu uzyskali dyplom, zaktualizuj pole data-dyplomu na wartość odpowiadającą dzisiejszej dacie.

```sql
UPDATE egzaminy e, (
    SELECT `id-wykladowcy`, egzaminy.`id-student`FROM wykladowcy
    INNER JOIN egzaminy ON egzaminy.`id-wykladowca` = wykladowcy.`id-wykladowcy`
    INNER JOIN osrodki ON `osrodki`.`id-osrodek` = `egzaminy`.`id-osrodek`
    WHERE `osrodki`.`nazwa-o` = "Centrum Informatyczne PL"
) AS x
SET `e`.`data` = NOW()
WHERE e.`id-student` = x.`id-student` 
    AND `e`.`id-wykladowca` = x.`id-wykladowcy`
    AND e.zdal = 1
```

### ZADANIE 11

W phpMyAdmin do tabeli Studenci dodaj kolumnę do przechowania numeru indeksu. Napisz zapytanie, które wszystkim studentom, którzy zdali przynajmniej jeden egzamin w Instytucie Informatyki, przypisze numer dyplomu do pola przechowującego numer indeksu.

```sql
ALTER TABLE studenci
ADD COLUMN numerIndeksu varchar(15) DEFAULT 'brak';

// Przypisanie jakiejs wartosci ma�o istotne
UPDATE studenci
SET `nr-dyplomu` = "100"

UPDATE studenci s, (
    SELECT `id-student`, `nr-dyplomu` FROM studenci
    WHERE `id-student` = ANY(
        SELECT `id-student` FROM egzaminy 
        INNER JOIN osrodki  ON `osrodki`.`id-osrodek` = `egzaminy`.`id-osrodek`
        WHERE egzaminy.zdal = 1
            AND `osrodki`.`nazwa-o` = "Instytut Informatyki PL"
        GROUP BY `id-student`
    )
) x
SET numerIndeksu = x.`nr-dyplomu`
WHERE `s`.`id-student` = x.`id-student`
```

### ZADANIE 12

Wstaw dane studenta, który zdał najwięcej egzaminów, do tabeli Wykładowcy.

```sql
-- zmieniłem id-wykladowcy varchar(4) na varchar(8) aby moc sobie zapisac id-studentow

INSERT INTO wykladowcy(`id-wykladowcy`, nazwisko, imie, `kod-poczta`, miasto, ulica, numer, telefon, fax, `e-mail`)
SELECT `studenci`.`id-student`, nazwisko, imie, `kod-poczta`, miasto, ulica,  numer, tel, fax, `e-mail` FROM studenci
JOIN egzaminy ON `egzaminy`.`id-student` = `studenci`.`id-student`
WHERE egzaminy.zdal = 1 
GROUP BY egzaminy.`id-student`
HAVING COUNT(`egzaminy`.`zdal`) = (
    SELECT COUNT(`egzaminy`.zdal) AS liczba FROM egzaminy
    WHERE zdal = 1
    GROUP BY `id-student`
    ORDER BY liczba DESC 
    LIMIT 1
)
```

### ZADANIE 13

Utwórz w phpMyAdmin pustą tabelę o nazwie ‘Kopia_przedmioty’ o strukturze tabeli przedmioty. Skopiuj do niej przedmioty o identyfikatorach poniżej wartości 10.

```sql
CREATE TABLE Kopia_przedmioty(
    `id-przedmiot` tinyint(3),
    `nazwa-p`  varchar(40),
    `opis` varchar(200)
);

INSERT INTO kopia_przedmioty
SELECT * FROM przedmioty
WHERE `id-przedmiot` < 10
```

### ZADANIE 14

Jako datę urodzin wykładowcy nazwiskiem Bond ustaw datę pierwszego przeprowadzonego
egzaminu.

```sql
UPDATE tabela
SET kol1 = (SELECT koli FROM tabela2)
[ WHERE warunek ]

-- Nie ma takiej kolumny jak dataUrodzin wiec dodaje ja
ALTER TABLE wykladowcy
ADD COLUMN dataUrodzin date

UPDATE wykladowcy w, (
    SELECT MIN(data) as pierwszy FROM egzaminy
) AS xxx
SET w.dataUrodzin = xxx.pierwszy
WHERE `w`.`nazwisko` = "Bond"
```
