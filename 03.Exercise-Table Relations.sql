--Problem 1------------------------------------------------------------------
--One-To-One-Relationship

CREATE TABLE Passports 
(
  PassportID INT PRIMARY KEY IDENTITY(101, 1) ,
  PassportNumber NVARCHAR(20) NOT NULL
)

CREATE TABLE Persons 
(
  PersonID INT PRIMARY KEY IDENTITY ,
  FirstName NVARCHAR(20) NOT NULL,
  Salary DECIMAL(7,2) NOT NULL,
  PassportID INT UNIQUE FOREIGN KEY REFERENCES Passports(PassportID)
)

INSERT INTO Passports VALUES
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2')

INSERT INTO Persons VALUES
('Roberto' , 43300 , 102),
('Tom' , 56100 , 103),
('ZE657QP2' , 60200 , 101)



--Problem 2------------------------------------------------------------------
--One-To-Many-Relationship

CREATE TABLE Manufacturers 
(
  ManufacturerID INT PRIMARY KEY IDENTITY,
  [Name] NVARCHAR(20) NOT NULL,
  EstablishedOn DATE NOT NULL
)

CREATE TABLE Models 
(
  ModelID INT PRIMARY KEY IDENTITY(101,1),
  [Name] NVARCHAR(20) NOT NULL,
  ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)


INSERT INTO Manufacturers VALUES 
('BMW' , '07/03/1916'),
('Tesla' , '01/01/2003'),
('Lada' , '01/05/1966')

INSERT INTO Models VALUES 
('X1' , 1),
('i6' , 1),
('Model S' , 2),
('Model X' , 2),
('Model 3' , 2),
('Nova' , 3)



--Problem 3------------------------------------------------------------------
--Many-To-Many-Relationship

CREATE TABLE Students
(
 StudentID INT PRIMARY KEY IDENTITY,
 [Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE Exams
(
 ExamID INT PRIMARY KEY IDENTITY(101,1),
 [Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE StudentsExams
(
 StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
 ExamID INT FOREIGN KEY REFERENCES Exams(ExamID)
 CONSTRAINT PK_Students_Exams PRIMARY KEY (StudentID,ExamID)
)

INSERT INTO Students VALUES 
('Mila'),
('Toni'),
('Ron')

INSERT INTO Exams VALUES 
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT INTO StudentsExams VALUES 
(1 , 101),
(1 , 102),
(2 , 101),
(3 , 103),
(2 , 102),
(2 , 103)



--Problem 4------------------------------------------------------------------
--Self-Referencing-Relationship

CREATE TABLE Teachers 
(
 TeacherID INT PRIMARY KEY IDENTITY(101,1),
 [Name] NVARCHAR(30) NOT NULL , 
 ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers VALUES 
('John' , NULL),
('Maya' , 106),
('Silvia' , 106),
('Ted' , 105),
('Mark' , 101),
('Greta' , 101)



--Problem 5------------------------------------------------------------------

CREATE TABLE Cities
(
 CityID INT PRIMARY KEY,
 [Name] VARCHAR(50)
)

CREATE TABLE Customers
(
 CustomerID INT PRIMARY KEY,
 [Name] VARCHAR(50) , 
 Birthday DATE, 
 CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
 OrderID INT PRIMARY KEY,
 CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes
(
 ItemTypeID INT PRIMARY KEY,
 [Name] VARCHAR(50)
)

CREATE TABLE Items
(
 ItemID INT PRIMARY KEY,
 [Name] VARCHAR(50) , 
 ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems
(
 OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
 ItemID INT FOREIGN KEY REFERENCES Items(ItemID)

 CONSTRAINT PK_OrderID_ItemID PRIMARY KEY(OrderID,ItemID)
)



--Problem 6------------------------------------------------------------------
CREATE TABLE Majors
(
 MajorID INT PRIMARY KEY,
 [Name] VARCHAR(50)
)

CREATE TABLE Students
(
 StudentID INT PRIMARY KEY,
 StudentNumber INT , 
 StudentName VARCHAR(50) , 
 MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Payments
(
 PaymentID INT PRIMARY KEY,
 PaymentDate DATETIME, 
 PaymentAmount DECIMAL(7,2),
 StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)

CREATE TABLE Subjects
(
 SubjectID INT PRIMARY KEY,
 SubjectName VARCHAR(50)
)

CREATE TABLE Agenda
(
 StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
 SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID)

 CONSTRAINT PK_Students_Items PRIMARY KEY(StudentID,SubjectID)
)

--Problem 9------------------------------------------------------------------
USE Geography

SELECT MountainRange,PeakName,Elevation
FROM Mountains AS m
JOIN Peaks AS p ON m.Id = p.MountainId
WHERE MountainRange LIKE 'Rila'
ORDER BY Elevation DESC


