
create database [SedcAcademy]

create table Student(
	Id int identity(1,1),
	FirstName nvarchar(100),
	LastName nvarchar(100),
	DateOfBirth date,
	EnrolledDate date,
	Gender nchar(1),
	NationalIdNumber bigint,
	StudentCardNumber bigint,
)

create table Teacher(
	Id int identity(1,1),
	FirstName nvarchar(100),
	LastName nvarchar(100),
	DateOfBirth date,
	AcademicRank int,
	HireDate date,
)

create table Grade (
	Id int identity(1,1),
	StudentId int,
	CourselId int,
	TeacherId int,
	Grade int,
	Comment nvarchar(100),
	CreatedDate date,
)

create table Course (
	Id int identity(1,1),
	Name nvarchar(100),
	Credit int,
	AcademicYear int,
	Semestar int,
)

create table GradeDetails(
	Id int identity(1,1),
	GradeId int,
	AchivementTypeId int,
	AchivementPoints int,
	AchivementMaxPoints int,
	AchivementDate date,
)

create table AchievementType(
	Id int identity(1,1),
	Name nvarchar(100),
	Description nvarchar(100),
	ParticipationRate int,
)