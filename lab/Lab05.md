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