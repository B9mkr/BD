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
```

### ZADANIE 2

W tabeli Uczelnie zmodyfikować definicję kolumny ‘liczba_studentow’ tak, aby dla każdego nowego rekordu przyjmowała wartość równą 3.

### ZADANIE 3

W tabeli Uczelnie usunąć kolumnę Miasto.

### ZADANIE 4

W tabeli Uczelnie na polu ‘id_uczelnia’ utworzyć klucz podstawowy.

### ZADANIE 5

Utworzyć powiązanie (klucz obcy) pomiędzy tabelą Uczelnie i Egzaminatorzy.

### ZADANIE 6

W tabeli ‘Egzaminatorzy’ dodać kolumnę o nazwie ‘Pensja’, która będzie przechowywać ilość pieniędzy zarobionych na wszystkich egzaminach. Domyślnie jest to kwota 15,50 zł.

### ZADANIE 7

Zmień nazwę tabeli ‘Uczelnie’ na ‘Szkoly_wyzsze’.

### ZADANIE 8

W tabeli ‘Szkoly_wyzsze’ zmień nazwę kolumny ‘nazwa_u’ na ‘nazwa’.

### ZADANIE 9

Usuń klucz obcy z tabeli ‘Egzaminatorzy’.

### ZADANIE 10

Usuń klucz podstawowy z tabeli ‘egzaminatorzy’.

### ZADANIE 11

Usuń tabelę ‘Osrodki’.

### ZADANIE 12

Utwórz tabelę na podstawie zapytania. Tabela ma zawierać studentów bez wpisanego numeru PESEL.

### ZADANIE 13

Utwórz tabelę na podstawie zapytania. Tabela ma zawierać tylko identyfikator przedmiotu oraz jego nazwę.

### ZADANIE 14

Utwórz tabelę na podstawie zapytania. Tabela ma mieć kolumny o nazwach ‘Nr_osr’ oraz ‘Nazwa_osr’ i zawierać identyfikatory oraz nazwy ośrodków mieszczących się w Lublinie.