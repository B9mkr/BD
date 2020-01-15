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