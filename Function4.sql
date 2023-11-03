use abhishek
go
print getdate() -- Oct  6 2023  3:28PM
print eomonth(getdate()) -- 2023-10-31
print eomonth('2002-03-22') -- 2002-03-31
print eomonth('2023-02-31') --error

go

-- date datatypes
-- date, time, smalldatetime, datetime, datetime2, datetimeoffset

select datefromparts(2002, 03, 22) -- 2002-03-22
select datefromparts(1990, 9, 16) -- 1990-09-16
select datefromparts(2000, 9, 32) -- error

select timefromparts(11, 53, 45, 856, 3) -- 11:53:45.856
select timefromparts(11, 53, 45, 856, 7) -- 11:53:45.0000856
select timefromparts(11, 53, 45, 0, 0) -- 11:53:45

select smalldatetimefromparts(2023, 10, 6, 11, 53) -- 2023-10-06 11:53:00

select DATETIMEFROMPARTS(2023, 10, 6, 11, 23, 45, 456) -- 2023-10-06 11:23:45.457

select DATETIME2FROMPARTS(2023, 10, 6, 11,12, 52, 458, 4) -- 2023-10-06 11:12:52.0458

select DATETIMEOFFSETFROMPARTS(2023, 10, 6, 11, 12, 56, 587, 5, 30, 3)
-- 2023-10-06 11:12:56.587 +05:30

go

create table InternStudent
(
id int primary key identity,
firstname varchar(50),
lastname varchar(50),
)

insert into InternStudent values('Abhishek','Sutar'),('Sachin','Kalmani'),
('Shreyash','Ingale'),('Sanket','Dabade')

select id,firstname,lastname from InternStudent
select id,firstname,lastname , firstname + ' ' + lastname as fullname from InternStudent

select id,firstname,lastname , (cast(id as varchar(5)) + '.' + firstname + ' ' + lastname) as fullname from InternStudent

go

create function fnfullname()
returns varchar(100)
as
begin
     declare @fullname varchar(100)
	 select @fullname = (cast(id as varchar(50)) + '. ' + firstname + ' ' + lastname) from InternStudent
     return @fullname
end

go

--using function
select id,firstname,lastname, dbo.fnfullname() from InternStudent


alter function fnfullname(@id int, @firstname varchar(50),@lastname varchar(50))
returns varchar(100)
as
begin
     declare @fullname varchar(100)
	set @fullname = (cast(@id as varchar(50)) + '. ' + @firstname + ' ' + @lastname) 
     return  @fullname
end

select dbo.fnfullname(id,firstname,lastname) from InternStudent

alter function fnfullname(@id int, @firstname varchar(50),@lastname varchar(50))
returns varchar(100)
as
begin
     declare @fullname varchar(100)
	set @fullname = (cast(@id as varchar(50)) + '. ' + @firstname + ' ' + @lastname) 
     return upper (@fullname)
end

select id, dbo.fnfullname(id,firstname,lastname) as Fullname from InternStudent

go

alter table InternStudent add DOB date
select * from InternStudent

create function fnAge(@DOB date)
returns varchar(100)
as
begin
     declare @Today date = getdate()
	 declare @year int
set @year = datediff(year , @DOB, @Today)
return cast(@year as varchar(5)) + 'year'
end

select id,firstname,lastname,DOB,dbo.fnAge(DOB) as Age from InternStudent

































