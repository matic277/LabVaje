create database TestDB
go
use TestDB
go

create table Zaposleni(
	id int,
	ime varchar(50),
	nadrejeniID int
)

insert into Zaposleni values (1, 'Ales', NULL)
insert into Zaposleni values (2, 'Janez', 1)
insert into Zaposleni values (3, 'Petra', 1)