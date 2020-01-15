## DQL – Podzapytania bez i z grupowaniem(Lab08.pdf)

```sql
-- zad6
select `id-student`, `id-przedmiot`
from egzaminy
where data > (
    	SELECT max(data)
    from egzaminy 
    where `id-przedmiot`=1
    )
    GROUP BY `id-przedmiot`

-- zad9a(limit)
select `id-wykladowca`,count(*)
from egzaminy
GROUP BY `id-wykladowca` 
ORDER BY 2 DESC
limit 1
-- rownum domumentacja w oraclu

-- zad9b
select `id-wykladowca`, count(*)
from egzaminy
GROUP BY `id-wykladowca` 
having count(*)=(
    SELECT MAX(count(*))
    from egzaminy
    group by `id-wykladowca`
    )

-- zad9c
select `id-wykladowca`, count(*)
from egzaminy
GROUP BY `id-wykladowca` 
having count(*)=(
    SELECT MAX(w.liczba)
    from 
    	(select COUNT(*) liczba
         from egzaminy group by `id-wykladowca`) w
    )

-- zad4
select `id-wykladowca`, data, `id-osrodek`
from egzaminy
where data in(
    select max(data)
    from egzaminy 
	group by `id-wykladowca`
	)
	order by `data`

-- zad?a
select `id-wykladowca`, data, `id-osrodek`
from egzaminy
where (`id-wykladowca`, data) in (SELECT `id-wykladowca`, max(data)
FROM egzaminy
group by `id-wykladowca`)
ORDER by data

-- zad?b
select `id-wykladowca`, data, `id-osrodek`
from egzaminy e
where data in (
    SELECT MAX(data)
    FROM egzaminy
    WHERE `id-wykladowca`=`e`.`id-wykladowca`
    )
    ORDER by data

```

## G1 b

### ZADANIE 1

Wyświetl datę ostatniego egzaminu przeprowadzonego w ośrodku o nazwie "CKMP".

```sql
SELECT MAX(data) 
FROM egzaminy e
WHERE e.`id-osrodek` = (
    SELECT `id-osrodek` 
    FROM osrodki 
    WHERE `nazwa-o` = 'Instytut informatyki PL')
```

### ZADANIE 2

Wyszukaj egzaminy, gdzie w polu 'zdal' wprowadzono wartość null. Wyświetl datę, nazwisko i imię studenta, numer egzaminu. Posortuj malejąco po dacie.

```sql
SELECT e.data, s.nazwisko, s.imie 
FROM egzaminy e
INNER JOIN studenci s ON s.`id-student` = e.`id-student`
WHERE e.zdal = 0
ORDER BY data DESC
```

### ZADANIE 3

Wyświetl liczbę egzaminów przeprowadzonhych przez wykładowcę o nazwisku 'Szymczyk'.

```sql
SELECT count(e.`nr-egz`) 
FROM egzaminy e
INNER JOIN wykladowcy w ON w.`id-wykladowcy` = e.`id-wykladowca`
WHERE w.`nazwisko` = 'Kęsik'
GROUP BY w.`nazwisko`
```

### ZADANIE 4

Wyświetl, ilu wykładowców przeprowadzało egzaminy z przedmiotu 'Bazy danych'?

```sql
SELECT COUNT(DISTINCT w.`id-wykladowcy`) 
FROM egzaminy e
INNER JOIN wykladowcy w ON e.`id-wykladowca` = w.`id-wykladowcy`
INNER JOIN przedmioty p ON p.`id-przedmiot` = e.`id-przedmiot`
GROUP BY p.`nazwa-p`
HAVING p.`nazwa-p` = 'Bazy danych'
```

### ZADANIE 5

Wyświetl nazwiska i imiona studentów, którzy jeszcze nie zdawali egzaminu.

```sql
SELECT s.imie, s.nazwisko, e.zdal
FROM studenci s
LEFT JOIN egzaminy e ON e.`id-student` = s.`id-student`
WHERE e.`id-student` IS NULL
```

### ZADANIE 6

Wyświetl nazwiska i imiona wykładowców z Lublina, którzy prowadzili egzaminy tylko z 4 przedmiotów.

```sql
SELECT `id-wykladowcy`, COUNT(*) 
FROM (
	SELECT DISTINCT w.`id-wykladowcy`, w.nazwisko, e.`id-przedmiot` 
    FROM egzaminy e
	INNER JOIN wykladowcy w ON e.`id-wykladowca` = w.`id-wykladowcy`) AS e
GROUP BY `id-wykladowcy`
HAVING COUNT(*) = 4;
```

### ZADANIE 7

Wyświetl nazwiska i indentyfikatory wykładowców, którzy przeprowadzili więcej egzaminów niż egzaminator o identyfikatorze 4.

```sql
SELECT w.nazwisko, e.`id-wykladowcy`, count(*) 
FROM wykladowcy w
INNER JOIN egzaminy e ON e.`id-wykladowca` = w.`id-wykladowcy`
GROUP BY e.`id-wykladowcy`
HAVING count(*) > (
    SELECT count(*) 
    FROM egzaminy 
    WHERE `id-wykladowca` = '0004');



SELECT w.nazwisko, w.`id-wykladowcy`, count(*) 
FROM (
    SELECT w.`id-wykladowca`
    FROM wykladowcy w
    JOIN egzaminy e ON e.`id-wykladowca` = w.`id-wykladowcy`
    WHERE COUNT(e.`nr-egz`) > 
    COUNT(SELECT *
    		FROM egzaminy e
    		WHERE e.`id-wykladowca` = '0004')
    GROUP BY e.`id-wykladowcy`
) w
GROUP BY e.`id-wykladowcy`



```

## G2 c

### ZADANIE 1

Wyszukaj dane o niezdanych egzaminach studentów, których nazwiska rozpoczynają się literą 'S'. Wyświetl nazwę przedmiotu, datę egzaminu, a także nazwisko i imię egzaminatora. Posortuj malejąco względem nazwy przedmiotu.

### ZADANIE 2

Wyświetl datę pierwszego egzaminu z przedmotu 'Bazy danych'. Nadaj etykeitę 'Pierwszy-egzamin'.

### ZADANIE 3

Wyszukaj ośrodek, w którym przeprowadzono najminiej egzaminów. Wyświetl tylko nazwę ośrodka.

### ZADANIE 4

Wyświetl dane o egzaminach, które odbyły się po ostatnim egzaminie z przedmiotu o indeftyfikatorze 1.

### ZADANIE 5

Ile egzaminów przeprowadzono w poszczególnych ośrodkach? Wyświetl nazwę ośrodka i liczbę egzaminów. Weź pod uwagę wszystkie ośrodki (tzn. wszystkie ośrodki z tabeli 'osrodki').

### ZADANIE 6

Wyświetl nazwiska i imiona studentów, którzy nie zdali 4 egzaminów.

### ZADANIE 7

Wyświetl datę ostatniego egzaminu przeprowadzonego przez Marka Miłósza.

---

### Lab7.txt

```sql
Zad1
SELECT `studenci`.`nazwisko`, `studenci`.`imie`, `przedmioty`.`nazwa-p` FROM egzaminy
INNER JOIN `studenci` USING(`id-student`)
INNER JOIn `przedmioty` USING(`id-przedmiot`)
where `egzaminy`.`data` = 
(SELECT MIN(`egzaminy`.`data`) FROM egzaminy)

Zad2
SELECT * FROM studenci
WHERE miasto =
(SELECT miasto FROM studenci 
 WHERE `studenci`.`PESEL` = "77071951281")

Zad3
SELECT * FROM studenci
INNER JOIN `egzaminy` ON `egzaminy`.`id-student` =`studenci`.`id-student`
WHERE egzaminy.`data` IN
(SELECT `egzaminy`.`data` FROM egzaminy
 WHERE `id-student` = "0000061")
AND (`studenci`.`id-student` != "0000061")

Zad4
SELECT `wykladowcy`.`nazwisko`, `wykladowcy`.`imie`, `osrodki`.`nazwa-o`, data FROM egzaminy
INNER JOIN `osrodki` On `osrodki`.`id-osrodek` = `egzaminy`.`id-osrodek`
INNER JOIN `wykladowcy` ON `wykladowcy`.`id-wykladowcy` = `egzaminy`.`id-wykladowca`
WHERE `egzaminy`.`data` IN
(SELECT MAX(`egzaminy`.`data`) FROM egzaminy
INNER JOIN `wykladowcy` ON `wykladowcy`.`id-wykladowcy` = `egzaminy`.`id-wykladowca`
GROUP BY `wykladowcy`.`id-wykladowcy`)
ORDER BY `egzaminy`.`data`

Zad5
a)
SELECT * FROM egzaminy
WHERE egzaminy.data >
(SELECT MAX(data) FROm egzaminy
 INNER JOIN przedmioty ON `przedmioty`.`id-przedmiot` = `egzaminy`.`id-przedmiot`
 WHERE `przedmioty`.`id-przedmiot` = 1)

b)
SELECT * FROM egzaminy
WHERE egzaminy.data > ALL
(SELECT MAX(data) FROm egzaminy
 INNER JOIN przedmioty ON `przedmioty`.`id-przedmiot` = `egzaminy`.`id-przedmiot`
 WHERE `przedmioty`.`id-przedmiot` = 1)

Zad6
SELECT * FROM egzaminy
WHERE egzaminy.data >
(SELECT MAX(data) FROm egzaminy
 INNER JOIN przedmioty ON `przedmioty`.`id-przedmiot` = `egzaminy`.`id-przedmiot`
 WHERE `przedmioty`.`id-przedmiot` = 1)

Zad7
SELECT `przedmioty`.`nazwa-p` from egzaminy
INNER JOIN `przedmioty` oN `przedmioty`.`id-przedmiot` = `egzaminy`.`id-przedmiot`
WHERE `egzaminy`.`data` < 
(SELECT MIN(data) FROM egzaminy
 INNER JOIN przedmioty ON `przedmioty`.`id-przedmiot` = `egzaminy`.`id-przedmiot`
 WHERE `przedmioty`.`nazwa-p` = "Bazy danych")
 GROUP BY `nazwa-p`
 ORDER BY `egzaminy`.`id-przedmiot`

Zad8
SELECT `osrodki`.`nazwa-o` FROM egzaminy
INNER JOIN `osrodki` ON `osrodki`.`id-osrodek` = `egzaminy`.`id-osrodek`
WHERE egzaminy.data <
(SELECT MIN(data) FROm egzaminy
 INNER JOIN osrodki ON `osrodki`.`id-osrodek` = `egzaminy`.`id-osrodek`
 WHERE `osrodki`.`id-osrodek` = 11)
 GROUP BY `egzaminy`.`id-osrodek`

Zad9
SELECT *, COUNT(`id-wykladowcy`) AS ileEgzaminow from wykladowcy
INNER JOIN `egzaminy` ON `wykladowcy`.`id-wykladowcy` = `egzaminy`.`id-wykladowca`
GROUP BY `id-wykladowcy`
ORDER BY ileEgzaminow DESC
LIMIT 1

SELECT `wykladowcy`.`id-wykladowcy`, `wykladowcy`.`nazwisko`, wykladowcy.imie, COUNT(`nr-egz`) AS ileEgzaminow FROM egzaminy
INNER JOIN `wykladowcy` ON wykladowcy.`id-wykladowcy` = `egzaminy`.`id-wykladowca`
GROUP BY `id-wykladowcy`
ORDER BY ileEgzaminow DESC
LIMIT 1

Zad10
SELECT `przedmioty`.`nazwa-p`, COUNT(`nr-egz`) AS ileEgzaminow from egzaminy
INNER JOIN przedmioty ON `przedmioty`.`id-przedmiot` = `egzaminy`.`id-przedmiot`
GROUP BY `egzaminy`.`id-przedmiot`
HAVING ileEgzaminow > 
(SELECT COUNT(`nr-egz`) FROM egzaminy
INNER JOIN przedmioty ON `przedmioty`.`id-przedmiot` =  `egzaminy`.`id-przedmiot`
WHERE `nazwa-p` = "Bazy danych")
ORDER BY egzaminy.`id-przedmiot`

Zad11


Zad12
```