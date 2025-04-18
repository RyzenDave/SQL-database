CREATE DATABASE SEDCACADEMYDB
GO
USE SEDCACADEMYDB
GO 

CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    EnrollmentDate DATE DEFAULT GETDATE()
);

CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    HireDate DATE DEFAULT GETDATE()
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    CourseName NVARCHAR(100) NOT NULL,
    TeacherID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
);

CREATE TABLE AchievementTypes (
    AchievementTypeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500)
);

CREATE TABLE Grades (
    GradeID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    Grade DECIMAL(5,2) CHECK (Grade BETWEEN 0 AND 100),
    DateRecorded DATE DEFAULT GETDATE()
);

CREATE TABLE GradeDetails (
    GradeDetailID INT PRIMARY KEY IDENTITY(1,1),
    GradeID INT FOREIGN KEY REFERENCES Grades(GradeID),
    AchievementTypeID INT FOREIGN KEY REFERENCES AchievementTypes(AchievementTypeID),
    Points DECIMAL(5,2) NOT NULL,
    Notes NVARCHAR(500)
);

