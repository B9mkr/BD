# DML(Lab11.pdf)

### ZADANIE 1

Z tabeli Egzaminy usunąć egzaminy przeprowadzone z przedmiotu ‘Bazy danych’ w ośrodkach o nazwie ‘Katedra Matematyki’ oraz ‘Katedra Elektroniki PL’.

```sql
select * from egzaminy e, osrodki

```

### ZADANIE 2

Usuń z tabeli Ośrodki wszystkie ośrodki, w których nie zdano jeszcze żadnego egzaminu.

```sql
```

### ZADANIE 3

Zaktualizuj numer faxu na 815556677 tym wykładowcom, u których zdało egzamin więcej niż 3
studentów.

```sql
```

### ZADANIE 4

Z tabeli Egzaminy usuń informacje o tych egzaminach, które przeprowadzał wykładowca o nazwisku
Laskowski w ośrodku innym niż Instytut Informatyki.

```sql
```

### ZADANIE 5

Korzystając z polecenia CREATE AS SELECT utwórz tabelę Asy, w której umieść dane o trzech
studentach, którzy zdali najwięcej egzaminów. W nowej tabeli powinny znajdować się następujące
dane: imię i nazwisko (w jednym polu), numer indeksu oraz poprawnie nazwane pole z liczbą zdanych
egzaminów.

```sql
```

### ZADANIE 6

Korzystając z polecenia CREATE AS SELECT utwórz tabelę ‘LubiaSie’ zawierającą identyfikatory oraz
imiona i nazwiska tych egzaminatorów i studentów, którzy spotkali się na egzaminie więcej niż raz
(bez względu na wynik tego spotkania).

```sql
```

### ZADANIE 7

Z tabeli Studenci usuń informację o tych studentach, których dane znajdują się w tabeli Asy.

```sql
```

### ZADANIE 8

Z tabeli egzaminy usuń wszystkie egzaminy, które nie zostały zdane przed końcem XX wieku.

```sql
```

### ZADANIE 9

Z tabeli Wykladowcy usuń informację o tych wykładowcach, którzy przeprowadzili mniej niż 3
egzaminy.

```sql
```

### ZADANIE 10

Usuń studentów z tabeli Studenci mających „e” jako trzecią literę nazwiska.

```sql
```

### ZADANIE 11

Usuń wylosowanego egzaminatora.

```sql
```

### ZADANIE 12

Korzystając z polecenia select ... into outfile ‘nazwapliku’ wyeksportuj zawartość tabeli Przedmioty.
http://dev.mysql.com/doc/refman/5.7/en/select-into.html
http://dev.mysql.com/doc/refman/5.7/en/load-data.html

```sql
```

### ZADANIE 13

Korzystając z mysqldump wykonaj kopię zapasową pojedynczej tabeli, a następnie całej bazy danych.
http://dev.mysql.com/doc/refman/5.7/en/mysqldump.html

```sql
```

### ZADANIE 14

Korzystając z mysql zaimportuj kopię zapasową z zadania 13 do nowej bazy danych.
http://dev.mysql.com/doc/refman/5.7/en/mysql.html

```sql
```