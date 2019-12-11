# z Lab05.pdf

### ZADANIE 1
Wyświetl wszystkie informacje o studentach.
```sql
SELECT * FROM `studenci`
```

### ZADANIE 2
Wyświetl numer indeksu studenta o nazwisku Biegaj.
```sql
SELECT `id-student` FROM `studenci` WHERE `nazwisko` LIKE 'Biegaj'
```

### ZADANIE 3
Wyświetl dane studentów (nazwisko, imię) o nazwiskach rozpoczynających się literą „B”.
```sql
SELECT `imie`, `nazwisko` FROM `studenci` WHERE `nazwisko` LIKE 'B%'
```

### ZADANIE 4
Wyświetlić podstawowe dane (id-osrodek, nazwa-o, kod-poczta, miasto) o ośrodkach. Posortować wyświetlane dane wg miasta (rosnąco) oraz nazwy (malejąco).

```sql
SELECT `osrodki`.`id-osrodek`, `nazwa-o`, `kod-poczta`, miasto FROM osrodki ORDER BY miasto ASC;

SELECT `osrodki`.`id-osrodek`, `nazwa-o`, `kod-poczta`, miasto FROM osrodki ORDER BY `nazwa-o` DESC;
```

### ZADANIE 5
W jakich miastach mieszkają studenci? Podać nazwę miasta oraz kod pocztowy. Posortować otrzymany rezultat wg nazwy miasta.

```sql
SELECT DISTINCT miasto, `kod-poczta`
FROM studenci 
ORDER BY miasto;
```

### ZADANIE 6
Którzy studenci zdawali egzamin w ośrodkach o identyfikatorze 1 oraz 3 w okresie od 01 stycznia 2000 do 31 grudnia 2000? Dla każdego ośrodka z osobna podać identyfikator studenta, który zdawał egzamin w danym ośrodku oraz datę przeprowadzonego egzaminu. Uporządkować wyświetlane dane wg identyfikatora ośrodka, identyfikatora studenta oraz daty egzaminu.

```sql
SELECT `id-student` , `data`
FROM egzaminy
where (`id-osrodek`=1 OR `id-osrodek`=3) and
data BETWEEN '2000-01-01' and '2000-12-31'
ORDER BY `id-osrodek` AND `id-student` AND `data`;
```

### ZADANIE 7
Wyświetl wszystkie informacje o egzaminach zdawanych przez studenta o nazwisku Sobich.

```sql
SELECT *
FROM egzaminy e
    INNER JOIN studenci s on s.`id-student`=e.`id-student`
where s.nazwisko='Sobich'
```

### ZADANIE 8
Wyświetl daty egzaminów zdanych przez studentkę o nazwisku Klecha.

```sql
SELECT data
FROM egzaminy e
    INNER JOIN studenci s on s.`id-student`=e.`id-student`
where s.nazwisko='Klecha' and zdal=1
```

### ZADANIE 9
Wyświetl w kolejności malejącej daty egzaminów przeprowadzonych przez wykładowcę o nazwisku Laskowski.

```sql
SELECT data
FROM egzaminy e 
WHERE e.`id-wykladowca` = (
    SELECT `id-wykladowcy`
    FROM wykladowcy w
    WHERE w.nazwisko = 'Laskowski')
ORDER BY e.data DESC;
```

### ZADANIE 10
Wyświetl datę ostatniego egzaminu przeprowadzonego przez wykładowcę o nazwisku Miłosz. Nie używaj funkcji agregujących.

```sql
SELECT MAX(eg.data) AS data
FROM egzaminy AS eg, wykladowcy AS wy
WHERE eg.`id-wykladowca`=wy.`id-wykladowcy` AND wy.nazwisko='Miłosz'

select `id-student`, `id-przedmiot`
from egzaminy
where data = (
    select min(data)
    from egzaminy
)

select `id-student`, `id-przedmiot`
from egzaminy
where data in(
    select data from egzaminy
    where `id-student` ='0000061'
)
and `id-student`<>'0000061'

```

### ZADANIE 11
Którzy studenci (wyświetl nazwisko i imię) zdali egzamin u egzaminatora o nazwisku Miłosz?

```sql
SELECT DISTINCT st.nazwisko, st.imie
FROM studenci AS st, egzaminy AS eg, wykladowcy AS wy
WHERE eg.`id-wykladowca`=wy.`id-wykladowcy` 
	AND wy.nazwisko='Miłosz' 
    AND (`eg`.`id-student`=`st`.`id-student` AND eg.zdal=1)
```

### ZADANIE 12
Którzy egzaminatorzy mają nazwiska zaczynające się na literę M oraz są z miasta o nazwie Lublin? Podać ich identyfikator, imię i nazwisko. Uporządkować wyświetlane informacje wg nazwiska i imienia egzaminatora.

```sql
SELECT wy.`id-wykladowcy`, wy.imie, wy.nazwisko
FROM wykladowcy AS wy
WHERE wy.nazwisko LIKE 'M%' 
    AND wy.miasto='Lublin'
ORDER BY wy.nazwisko, wy.imie
```

### ZADANIE 13
W których ośrodkach przeprowadzono egzaminy z przedmiotu o nazwie Bazy danych oraz Arkusze kalkulacyjne? W odpowiedzi uwzględnić te ośrodki, w których odbył się egzamin przynajmniej z jednego podanego przedmiotu. Dla każdego przedmiotu, opisanego przez jego nazwę, podać identyfikator oraz nazwę ośrodka. Rezultat uporządkować wg nazwy przedmiotu i identyfikatora ośrodka.

```sql
SELECT DISTINCT `os`.`id-osrodek`, `os`.`nazwa-o`
FROM osrodki AS os, przedmioty AS pr, egzaminy AS eg

WHERE eg.`id-przedmiot`=(
        SELECT DISTINCT przedmioty.`id-przedmiot` 
        FROM przedmioty 
        WHERE przedmioty.`nazwa-p`='Bazy danych'
        )
    OR eg.`id-przedmiot`=(
        SELECT DISTINCT przedmioty.`id-przedmiot` 
        FROM przedmioty 
        WHERE przedmioty.`nazwa-p`='Arkusze kalkulacyjne'
        )

ORDER BY pr.`nazwa-p`, os.`id-osrodek`
```

---

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

---

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

### ZADANIE 4

Wstawić do tabeli Wykladowcy dane o nowym wykladowcy. Dane do wstawienia są następujące:
identyfikator – 0070, nazwisko – Bond, imię – James, miasto – Londyn.

```sql

```

### ZADANIE 5

W tabeli Wykladowcy zmodyfikować dane o wykładowcy, który ma nazwisko Bond, wstawiając do
kolumny E_mail wartość bond@gmail.com a do kolumny Telefon wartość 777777777.

```sql
UPDATE tabela
SET kol1 = wart1, kol2 = wart2,..., koln = wartn
[ WHERE warunek ]
```

### ZADANIE 6

Zastąp dane egzaminu o identyfikatorze 1 danymi najpóźniej zdawanego egzaminu.

```sql
UPDATE tabela
SET (kol1, kol2) = (SELECT koli, kolj FROM tabela2)
[ WHERE warunek ]
```

### ZADANIE 7

Zaktualizuj pole Fax w tabeli Wykladowcy tak, aby wszyscy wykładowcy, którzy nie mieszkają w
Lublinie mieli ten sam numer faksu – 22112222.

### ZADANIE 8

W tabeli Egzaminy zaktualizuj dane egzaminów, które odbyły się po 1 maja 1998 i były zdawane w
Katedrze Energetyki i Elektrochemii, przypisując je do Instytutu Informatyki.

### ZADANIE 9

W tabeli Egzaminy zmodyfikować informacje o wykładowcach, którzy przeprowadzili egzaminy w
ośrodku o nazwie 'Centrum Informatyczne PL' . Zastąpić identyfikator wykładowcy, przypisanego do
egzaminów przeprowadzonych w ośrodku o tej nazwie, identyfikatorem 0004.

### ZADANIE 10

Studentom, którzy w poprzednim zadaniu uzyskali dyplom, zaktualizuj pole data-dyplomu na wartość
odpowiadającą dzisiejszej dacie.

### ZADANIE 11

W phpMyAdmin do tabeli Studenci dodaj kolumnę do przechowania numeru indeksu. Napisz
zapytanie, które wszystkim studentom, którzy zdali przynajmniej jeden egzamin w Instytucie
Informatyki, przypisze numer dyplomu do pola przechowującego numer indeksu.

### ZADANIE 12

Wstaw dane studenta, który zdał najwięcej egzaminów, do tabeli Wykładowcy.

### ZADANIE 13

Utwórz w phpMyAdmin pustą tabelę o nazwie ‘Kopia_przedmioty’ o strukturze tabeli przedmioty.
Skopiuj do niej przedmioty o identyfikatorach poniżej wartości 10.

### ZADANIE 14

Jako datę urodzin wykładowcy nazwiskiem Bond ustaw datę pierwszego przeprowadzonego
egzaminu.

```sql
UPDATE tabela
SET kol1 = (SELECT koli FROM tabela2)
[ WHERE warunek ]
```
---

# DML.pdf

Najpierw chcę:

```sql
delete from egzaminy e
where `id-przedmiot`=1 and `id-osrodek`=1
and `id-wykladowca`='0004'
```

Ale teraz chciałbym usunąć po nazwie ośrodka:
1. Nie mogę zrobić

```sql
delete from egzaminy e
inner join osrodki o on e.`id-osrodek`=o.`id-osrodek`
where `id-przedmiot`=1 and `nazwa-o`='Instytut Informatyki PL'
and `id-wykladowca`='0004'
```

2. Nie działa składnia oracle

```sql
delete from egzaminy
 where `nr-egz` in (
 select `nr-egz`
 from egzaminy e
inner join osrodki o on e.`id-osrodek`=o.`id-osrodek`
 where e.`id-przedmiot`=1 and
o.`nazwa-o`='Instytut Informatyki PL' and
e.`id-wykladowca`='0004'
 )
```

3. Działa za to:

```sql
delete from egzaminy
where `nr-egz` in (
 select al.`nr-egz`
 from (
 select `nr-egz`
 from egzaminy e
 inner join osrodki o on e.`id-osrodek`=o.`id-osrodek`
 where e.`id-przedmiot`=1 and
 o.`nazwa-o`='Instytut Informatyki PL' and
 e.`id-wykladowca`='0004'
 ) as al
 )
```

4. Kolejny sposób, to:

```sql
delete e from egzaminy e
inner join osrodki o on e.`id-osrodek`=o.`id-osrodek`
where e.`id-przedmiot`=1 and
o.`nazwa-o`='Instytut Informatyki PL' and
e.`id-wykladowca`='0004'
---------------
```

### UPDATE bez podzapytania

```sql
update egzaminy e
inner join osrodki o on e.`id-osrodek`=o.`id-osrodek`
set e.zdal=1
where e.`id-przedmiot`=1 and
o.`nazwa-o`='Instytut Informatyki PL' and
e.`id-wykladowca`='0004'
-----------------------------------
```

### UPDATE MULTIPLE COLUMNS (ZAD. 6)
1. Dobre rozwiązanie

```sql
update egzaminy e, (
select *
from egzaminy
where data=(
select max(data)
from egzaminy)
limit 1) a
set e.zdal=a.zdal,
 e.`id-przedmiot`=a.`id-przedmiot`,
 e.data=a.data,
 e.`id-student`=a.`id-student`
where e.`nr-egz`=4
```

2. Inne przypadki

```sql
update egzaminy
set zdal=(select * from (
select zdal
from egzaminy
where `nr-egz`=333) asal
 )
where `nr-egz`=3
update egzaminy e, (select * from egzaminy where `nr-egz`=333) a
set e.zdal=a.zdal,
e.`id-przedmiot`=a.`id-przedmiot`,
e.data=a.data,
e.`id-student`=a.`id-student`
where e.`nr-egz`=4
```