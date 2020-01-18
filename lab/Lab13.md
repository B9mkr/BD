# DDL(Lab13.pdf)

Add CASCADE to the end of a DISABLE/DROP CONSTRAINT clause to disable any integrity constraints that depend on the specified integrity constraint.

You must use CASCADE when you disable/drop a primary key or unique constraint that is part of a foreign key constraint.

### ZADANIE 1

Utworzyć tabelę Uczelnie poprzez wykonanie poniższego zapytania:

```sql
CREATE TABLE Uczelnie (
    ID_UCZELNIA NUMBER(5),
    NAZWA_U VARCHAR2(30),
    MIASTO VARCHAR2(15),
    LICZBA_STUDENTOW NUMBER(5)
);

CREATE TABLE Uczelnie (
    Id_Uczelnia int,
    NazwaU varchar(30),
    Miasto varchar(30),
    LiczbaStudentow int
);

```

### ZADANIE 2

W tabeli Uczelnie zmodyfikować definicję kolumny ‘liczba_studentow’ tak, aby dla każdego nowego rekordu przyjmowała wartość równą 3.

```sql
ALTER TABLE Uczelnie
MODIFY COLUMN LiczbaStudentow int  NOT NULL DEFAULT 3
```

### ZADANIE 3

W tabeli Uczelnie usunąć kolumnę Miasto.

```sql
ALTER TABLE Uczelnie
DROP COLUMN Miasto
```

### ZADANIE 4

W tabeli Uczelnie na polu ‘id_uczelnia’ utworzyć klucz podstawowy.

```sql
ALTER TABLE Uczelnie
ADD PRIMARY KEY (Id_Uczelnia)
```

### ZADANIE 5

Utworzyć powiązanie (klucz obcy) pomiędzy tabelą Uczelnie i Egzaminatorzy.

```sql
ALTER TABLE Uczelnie
ADD COLUMN IdWykladowca varchar(4) NOT NULL,
ADD CONSTRAINT FKIdWykladowca FOREIGN KEY(IdWykladowca) REFERENCES wykladowcy(`id-wykladowcy`)
```

### ZADANIE 6

W tabeli ‘Egzaminatorzy’ dodać kolumnę o nazwie ‘Pensja’, która będzie przechowywać ilość pieniędzy zarobionych na wszystkich egzaminach. Domyślnie jest to kwota 15,50 zł.

```sql
ALTER TABLE wykladowcy
ADD COLUMN Pensja DOUBLE DEFAULT '15.50'
```

### ZADANIE 7

Zmień nazwę tabeli ‘Uczelnie’ na ‘Szkoly_wyzsze’.

```sql
RENAME TABLE Uczelnie TO Szkoly_Wyzsze
```

### ZADANIE 8

W tabeli ‘Szkoly_wyzsze’ zmień nazwę kolumny ‘nazwa_u’ na ‘nazwa’.

```sql
ALTER TABLE Szkoly_wyzsze
CHANGE nazwa_u nazwa varchar(30) NOT NULL
```

### ZADANIE 9

Usuń klucz obcy z tabeli ‘Egzaminatorzy’.

```sql
Informacje o constraints
select *
from information_schema.key_column_usage
where constraint_schema = 'YOUR_DB'

ALTER TABLE egzaminy
DROP FOREIGN KEY `egzaminy_ibfk_3`;
```

### ZADANIE 10

Usuń klucz podstawowy z tabeli ‘egzaminatorzy’.

```sql
ALTER TABLE wykladowcy
DROP PRIMARY KEY;
```

### ZADANIE 11

Usuń tabelę ‘Osrodki’.

```sql
ALTER TABLE egzaminy
DROP FOREIGN KEY `egzaminy_ibfk_4`;
GO
DROP TABLE Osrodki;
```

### ZADANIE 12

Utwórz tabelę na podstawie zapytania. Tabela ma zawierać studentów bez wpisanego numeru PESEL.

```sql
CREATE TABLE studenciBezPesela
AS
SELECT * FROM studenci
WHERE PESEL = " "
```

### ZADANIE 13

Utwórz tabelę na podstawie zapytania. Tabela ma zawierać tylko identyfikator przedmiotu oraz jego nazwę.

```sql
CREATE TABLE inPrzedmioty
AS
SELECT `id-przedmiot`, `nazwa-p` FROM przedmioty
```

### ZADANIE 14

Utwórz tabelę na podstawie zapytania. Tabela ma mieć kolumny o nazwach ‘Nr_osr’ oraz ‘Nazwa_osr’ i zawierać identyfikatory oraz nazwy ośrodków mieszczących się w Lublinie.

```sql
CREATE TABLE nnOsrodki
AS
SELECT `id-osrodek` AS Nr_osr, `nazwa-o` AS Nazwa_o FROM osrodki
WHERE miasto = "Lublin"
```