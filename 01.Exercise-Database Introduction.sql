--Problem 1------------------------------------------------------------------
CREATE DATABASE Minions


--Problem 2------------------------------------------------------------------
CREATE TABLE Minions
(
  Id INT NOT NULL PRIMARY KEY,
  [Name] VARCHAR(30) ,
  Age INT ,
)

CREATE TABLE Towns
(
  Id INT NOT NULL PRIMARY KEY,
  [Name] VARCHAR(30),
)


--Problem 3------------------------------------------------------------------
ALTER TABLE Minions
ADD TownId INT

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)


--Problem 4------------------------------------------------------------------
INSERT INTO Towns (Id , [Name] ) VALUES 
(1 , 'Sofia'),
(2 , 'Plovdiv'),
(3 , 'Varna')

INSERT INTO Minions (Id , [Name] , Age , TownId) VALUES 
(1 , 'Kevin' , 22 , 1 ),
(2 , 'Bob' , 15 , 3 ),
(3 , 'Steward' , NULL , 2 )


--Problem 5------------------------------------------------------------------
TRUNCATE TABLE Minions


--Problem 6------------------------------------------------------------------
DROP TABLE Minions	
DROP TABLE Towns	


--Problem 7------------------------------------------------------------------
CREATE TABLE People 
(
   Id INT NOT NULL PRIMARY KEY IDENTITY,
   [Name] NVARCHAR(200) NOT NULL , 
   Picture IMAGE,
   Height DECIMAL (5,2),
   [Weight] DECIMAL(5,2),
   Gender CHAR(1) NOT NULL , 
   Birthdate DATE NOT NULL,
   Biography NVARCHAR(MAX)
)

INSERT INTO People ([Name],Picture, Height,[Weight],Gender,Birthdate, Biography) VALUES 
    ( 'Ivan', NULL, 180,75,'m', '1990/12/20', NULL),
	( 'Sanya', NULL, 165, 50,'f','1988/05/12', 'Teacher'),
	( 'Biser', NULL ,172 , 72, 'm', '1985/06/30', 'Recruiter'),
	( 'Stamen', NULL, 175, 80,'m','1980/01/25', 'Teacher'),
	( 'Sisa', NULL, 170, 62, 'f', '1992/03/01','Student')


--Problem 8------------------------------------------------------------------
CREATE TABLE Users 
(
   Id BIGINT NOT NULL PRIMARY KEY IDENTITY,
   Username VARCHAR(30) NOT NULL UNIQUE,
   [Password] VARCHAR(26) NOT NULL,
   ProfilePicture VARBINARY(MAX) 
   CHECK(DATALENGTH(ProfilePicture)<=900*1024),
   LastLoginTime DATETIME2,
   IsDeleted BIT NOT NULL
)

INSERT INTO Users ( Username , [Password] , ProfilePicture, LastLoginTime , IsDeleted) VALUES 
    ('stiv.31','somepass',NULL, '05.19.2020',0),
	('stiv.32','somepass',NULL, '05.18.2020',1),
	('stiv.33','somepass',NULL, '01.09.2020',0),
	('stiv.34','somepass',NULL, '03.24.2020',1),
    ('stiv.35','somepass',NULL, '08.02.2020',0)


--Problem 9------------------------------------------------------------------
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC0785A93F9E

ALTER TABLE Users
ADD CONSTRAINT PK_Users_CompositeIdUsername PRIMARY KEY (ID,UserName);


--Problem 10------------------------------------------------------------------ 
ALTER TABLE Users
ADD CONSTRAINT CHK_Users_PasswordLength
CHECK(LEN([Password]) >=5)


--Problem 11------------------------------------------------------------------
ALTER TABLE Users
ADD CONSTRAINT DF_Users_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime


--Problem 12------------------------------------------------------------------
ALTER TABLE Users
DROP CONSTRAINT [PK_Users_CompositeIdUsername]

ALTER TABLE Users
ADD CONSTRAINT PK_Users_Id
PRIMARY KEY(Id)

ALTER TABLE Users
ADD CONSTRAINT CK_Users_UsernameLength
CHECK(LEN(Username)>=3)


--Problem 13------------------------------------------------------------------
CREATE DATABASE Movies

CREATE TABLE Directors
(
 Id INT PRIMARY KEY IDENTITY,
 DirectorName NVARCHAR(50) NOT NULL,
 Notes NVARCHAR(MAX)
)

CREATE TABLE Genres
(
 Id INT PRIMARY KEY IDENTITY,
 GenreName NVARCHAR(20) NOT NULL,
 Notes NVARCHAR(MAX) 
)

CREATE TABLE Categories
(
 Id INT PRIMARY KEY IDENTITY,
 CategoryName NVARCHAR(30),
 Notes NVARCHAR(MAX)
)

CREATE TABLE Movies
(
 Id INT PRIMARY KEY IDENTITY,
 Title NVARCHAR(50) NOT NULL,
 DirectorId INT FOREIGN KEY REFERENCES Directors(Id),
 CopyrightYear DATETIME2 NOT NULL , 
 [Length] TIME NOT NULL,
 GenreId INT FOREIGN KEY REFERENCES Genres(Id),
 CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
 Rating DECIMAL(2, 1),
 Notes NVARCHAR(MAX)
)

INSERT INTO Directors(DirectorName,Notes) VALUES
 ('Frank Darabont' , NULL),
 ('Francis Ford Coppola', NULL),
 ('Steven Spielberg', NULL),
 ('Peter Jackson', NULL),
 ('Quentin Tarantino', NULL)

INSERT INTO Genres(GenreName, Notes) VALUES
 ('Crime', NULL),
 ('Action', NULL),
 ('Biography', NULL),
 ('Crime&Drama', NULL),
 ('Drama', NULL)

INSERT INTO Categories(CategoryName,Notes) VALUES
 ('Best Picture', NULL),
 ('Best Actor in a Leading Role', NULL),
 ('Best Music', NULL),
 ('Best Director', NULL),
 ('Best Film Editing', NULL)

INSERT INTO Movies(Title, DirectorId,CopyrightYear,
[Length],GenreId, CategoryId, Rating, Notes) VALUES
 ('The Shawshank Redemption',1,'1994','02:11',5,4,9.2,NULL),
 ('The Godfather',2,'1972','02:55',1,5,9.2, NULL),
 ('Schindlers List',3,'1993','03:15',3,1,8.9, NULL),
 ('The Lord of the Rings',4,'2003','03:21',4,2,8.9, NULL),
 ('Pulp Fiction',5,'1994','02:34',2,3,8.9, NULL)


--Problem 14------------------------------------------------------------------
CREATE DATABASE CarRental

USE CarRental

CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(50) NOT NULL,
	DailyRate DECIMAL(4,2),
	WeeklyRate DECIMAL(4,2),
	MonthlyRate DECIMAL(4,2),
	WeekendRate DECIMAL(4,2)
)

CREATE TABLE Cars
(
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber NVARCHAR(10) NOT NULL,
	Manufacturer NVARCHAR(20) NOT NULL,
	Model NVARCHAR(20) NOT NULL,
	CarYear DATETIME2 NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
	Doors INT ,
	Picture VARBINARY(MAX),
	Condition NVARCHAR(20),
	Available BIT NOT NULL
)

CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(15) NOT NULL,
	LastName NVARCHAR(15) NOT NULL,
	Title NVARCHAR(15) ,
	Notes NVARCHAR(100) 
)

CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY,
	DriverLicenceNumber NVARCHAR(20) NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(50),
	City NVARCHAR(15) NOT NULL,
	ZIPCode INT NOT NULL,
	Notes NVARCHAR(100)
)

CREATE TABLE RentalOrders
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
	CarId INT FOREIGN KEY REFERENCES Cars(Id),
	TankLevel INT NOT NULL,
	KilometrageStart INT NOT NULL,
	KilometrageEnd INT NOT NULL,
	TotalKilometrage AS KilometrageEnd-KilometrageStart,
	StartDate DATETIME2 NOT NULL,
	EndDate DATETIME2 NOT NULL,
	TotalDays AS DATEDIFF(DAY,StartDate,EndDate),
	RateApplied DECIMAL(5,2) ,
	TaxRate DECIMAL(7,2) NOT NULL,
	OrderStatus NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(200) 
)

INSERT INTO Categories(CategoryName,DailyRate,WeeklyRate,MonthlyRate,WeekendRate) VALUES
	('SUV', 25.30,15.20,13.50,40.00),
	('SEDAN', 12.30,15.20,13.50,10.00),
	('SPORT', 21.20,13.00,16.00,15.00)
		
INSERT INTO Cars(PlateNumber, Manufacturer, Model,CarYear,CategoryId,Doors,Picture, Condition,Available) VALUES
	('1','BMW', 'X5', '2018', 1, 5,NULL, 'NEW',0),
	('2','AUDI', 'A5', '2018', 2, 5,NULL, 'NEW',0),
	('3','AUDI', 'R8', '2019', 3, 5,NULL, 'NEW',0)

INSERT INTO Employees(FirstName,LastName,Title,Notes) VALUES
	('IVAN','CHAPKANOV','MOSS', NULL),
	('STOQN','PETROV','BOSS', NULL),
	('PARVAN','SEMOV','BARBADOS', NULL)

INSERT INTO Customers(DriverLicenceNumber,FullName,[Address],City,ZIPCode,Notes) VALUES
	('3166','STAMAT HRISTOV', NULL,'SOFIA',1300,NULL),
	('4528','STEFAN HRISTOV', NULL,'VARNA',9000,NULL),
	('2189','VILI HRISTOV', NULL,'PLEVEN',5800,NULL)

INSERT INTO RentalOrders(EmployeeId,CustomerId,CarId,TankLevel,KilometrageStart,KilometrageEnd,
StartDate,EndDate,RateApplied,TaxRate,OrderStatus,Notes) VALUES
	(1,1,1,5,20,40,'2020-05-16','2020-05-20',NULL,65.00,'COMPLETE', NULL),
	(2,2,2,5,20,50,'2020-05-16','2020-05-20',NULL,65.00,'COMPLETE', NULL),
	(3,3,3,5,30,100,'2020-05-16','2020-05-20',NULL,65.00,'COMPLETE', NULL)


--Problem 15------------------------------------------------------------------
CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Employees 
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(15) NOT NULL,
	LastName NVARCHAR(15) NOT NULL, 
	Title NVARCHAR(20) NOT NULL,
	Notes NVARCHAR(200) 
)

INSERT INTO Employees (FirstName, LastName, Title, Notes) VALUES
	('IVAN', 'KOSEV', 'RECEPTIONIST',NULL),
	('VANYA', 'STAMATOVA', 'MANAGER',NULL),
	('SANDRA','MAKSIMOVA', 'MAID', NULL)

CREATE TABLE Customers
(
	AccountNumber NVARCHAR(15) PRIMARY KEY ,
	FirstName NVARCHAR(15) NOT NULL, 
	LastName NVARCHAR(15) NOT NULL,
	PhoneNumber NVARCHAR(15) NOT NULL, 
	EmergencyName NVARCHAR(50) NOT NULL, 
	EmergencyNumber NVARCHAR(15) NOT NULL,
	Notes NVARCHAR(200)
)

INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber, 
EmergencyName, EmergencyNumber,Notes) VALUES
	('1','SIMO','ANDONOV','8851264','1','123', NULL),
	('2','SIMO','ANDONOV','8851264','1','123', NULL),
	('3','SIMO','ANDONOV','8851264','1','123', NULL)


CREATE TABLE RoomStatus
(
	RoomStatus NVARCHAR(20) PRIMARY KEY, 
	Notes NVARCHAR(100)
)

INSERT INTO RoomStatus (RoomStatus, Notes) VALUES
	('FREE AND CLEAN', NULL),
	('FREE, NOT CLEAN', NULL),
	('OCCUPIED', NULL)

CREATE TABLE RoomTypes
(
	RoomType NVARCHAR(15) PRIMARY KEY,
	Notes NVARCHAR(100) 
)

INSERT INTO RoomTypes (RoomType, Notes) VALUES
	('FANCY',NULL),
	('FAMILLY', NULL),
	('SINGLE', NULL)

CREATE TABLE BedTypes
(
	BedType NVARCHAR(10) PRIMARY KEY,
	Notes NVARCHAR(100) 
)

INSERT INTO BedTypes (BedType, Notes) VALUES
	('ONEPERSON', NULL),
	('TWOPERSONS', NULL),
	('KINGBED', NULL)

CREATE TABLE Rooms 
(
	RoomNumber INT PRIMARY KEY IDENTITY, 
	RoomType NVARCHAR(15) FOREIGN KEY REFERENCES 
	RoomTypes(RoomType), 
	BedType NVARCHAR(10) FOREIGN KEY REFERENCES 
	BedTypes(BedType), 
	Rate DECIMAL(4,2), 
	RoomStatus NVARCHAR(20) FOREIGN KEY REFERENCES
	RoomStatus(RoomStatus), 
	Notes NVARCHAR(200)
)

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus, Notes)VALUES
	('FANCY','KINGBED', 85,'OCCUPIED',NULL),
	('FAMILLY','TWOPERSONS', 65,'FREE, NOT CLEAN',NULL),
	('SINGLE','ONEPERSON', 35,'FREE AND CLEAN',NULL)

CREATE TABLE Payments
(
	Id INT PRIMARY KEY IDENTITY, 
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
	PaymentDate DATETIME2 NOT NULL, 
	AccountNumber NVARCHAR(15) FOREIGN KEY REFERENCES 
	Customers(AccountNumber), 
	FirstDateOccupied DATETIME2 NOT NULL, 
	LastDateOccupied DATETIME2 NOT NULL,
	TotalDays AS DATEDIFF(DAY,FirstDateOccupied, LastDateOccupied),
	AmountCharged DECIMAL(6,2) NOT NULL,
	TaxRate DECIMAL(4,2) NOT NULL,
	TaxAmount AS AmountCharged*TaxRate, 
	PaymentTotal DECIMAL(6,2) NOT NULL, 
	Notes NVARCHAR(200)
)

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber,FirstDateOccupied,
LastDateOccupied,AmountCharged, TaxRate,PaymentTotal, Notes) VALUES
	('1','2020-05-20','1','2020-05-20','2020-05-25',220,20,260,NULL),
	('2','2020-05-20','2','2020-05-20','2020-05-25',220,20,260,NULL),
	('3','2020-05-20','3','2020-05-20','2020-05-25',220,20,260,NULL)

CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY IDENTITY, 
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
	DateOccupied DATETIME2 , 
	AccountNumber NVARCHAR(15) FOREIGN KEY REFERENCES 
	Customers(AccountNumber), 
	RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber), 
	RateApplied DECIMAL(4,2), 
	PhoneCharge DECIMAL(5,2),
	Notes NVARCHAR(200)
)

INSERT INTO Occupancies (EmployeeId, DateOccupied,AccountNumber, 
RoomNumber, RateApplied, PhoneCharge,Notes) VALUES
	(1,'2020-05-20','1',1,25.5, 30, NULL),
	(2,'2020-05-20','2',2,25.5, 30, NULL),
	(3,'2020-05-20','3',3,25.5, 30, NULL)


--Problem 16------------------------------------------------------------------
CREATE DATABASE SoftUni

USE SoftUni

CREATE TABLE Towns 
(
	Id INT PRIMARY KEY IDENTITY, 
	Name NVARCHAR(20) NOT NULL
)

CREATE TABLE Addresses
(
	Id INT PRIMARY KEY IDENTITY, 
	AddressText NVARCHAR(100) NOT NULL, 
	TownId INT NOT NULL

	CONSTRAINT FK_Addresses_TownId FOREIGN KEY (TownId) REFERENCES Towns (Id)
)

CREATE TABLE Departments
(
	Id INT PRIMARY KEY IDENTITY, 
	Name NVARCHAR(50) NOT NULL
)

CREATE TABLE Employees
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(20) NOT NULL,
	MiddleName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	JobTitle NVARCHAR(20) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments (Id),
	HireDate DATE NOT NULL,
	Salary DECIMAL(7, 2) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses (Id)
)


--Problem 17------------------------------------------------------------------
BACKUP DATABASE SoftUni1
TO DISK = 'F:\Downloads\Softuni-backup.bak'

USE master

DROP DATABASE SoftUni1

RESTORE DATABASE SoftUni1
FROM DISK = 'F:\Downloads\Softuni-backup.bak'


--Problem 18------------------------------------------------------------------
USE SoftUni

INSERT INTO Towns([Name]) VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')


INSERT INTO Departments([Name]) VALUES
	('Engineering'),
	('Sales'),
	('Marketing'), 
	('Software Development'),
	('Quality Assurance')

INSERT INTO Employees(FirstName,MiddleName,LastName,
JobTitle,DepartmentId,HireDate,Salary) VALUES
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer',4,'02/01/2013',3500.00),
	('Petar','Petrov', 'Petrov', 'Senior Engineer',1, '03/02/2004', 4000.00),
	('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '08/28/2016', 525.25),
	('Georgi', 'Teziev', 'Ivanov', 'CEO',2, '12/09/2007', 3000.00),
	('Peter', 'Pan', 'Pan', 'Intern', 3, '08/28/2016', 599.88)


--Problem 19------------------------------------------------------------------
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees


--Problem 20------------------------------------------------------------------
SELECT * FROM Towns
ORDER BY [Name] ASC

SELECT * FROM Departments
ORDER BY [Name] ASC

SELECT * FROM Employees
ORDER BY Salary DESC


--Problem 21------------------------------------------------------------------
SELECT [Name] FROM Towns
ORDER BY [Name] ASC

SELECT [Name] FROM Departments
ORDER BY [Name] ASC

SELECT FirstName,LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC


--Problem 22------------------------------------------------------------------
UPDATE Employees
SET Salary +=Salary*0.1

SELECT Salary FROM Employees


--Problem 23------------------------------------------------------------------
USE Hotel

UPDATE Payments
SET TaxRate-=TaxRate*0.03

SELECT TaxRate FROM Payments


--Problem 24------------------------------------------------------------------
USE Hotel

TRUNCATE TABLE Occupancies
