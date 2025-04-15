--Just trying to see the data
SELECT * FROM INFORMATION_SCHEMA.TABLES 
SELECT * FROM Teacher
SELECT * FROM GradeDetails
SELECT * FROM Grade
SELECT * FROM Student
--Calculate the count of all grades per Teacher in the system
SELECT 
    TeacherID,
    COUNT(*) AS NumberOfGrades 
FROM 
    Grade
GROUP BY 
    TeacherID 
ORDER BY 
    NumberOfGrades DESC;
--Calculate the count of all grades per Teacher in the system for first 100
--Students (ID < 100)
SELECT 
    TeacherID,
    COUNT(*) AS NumberOfGrades 
FROM 
    Grade
WHERE
     StudentID < 100
GROUP BY 
    TeacherID 
ORDER BY 
    NumberOfGrades DESC;
--Find the Maximal Grade, and the Average Grade per Student on all grades in
--the system
SELECT 
    StudentID,
    MAX(Grade) AS HighestGrade,
    AVG(Grade) AS AverageGrade
FROM 
    Grade 
GROUP BY 
    StudentID
ORDER BY 
    StudentID;
--Calculate the count of all grades per Teacher in the system and filter only
--grade count greater then 200
SELECT 
    TeacherID,
    COUNT(*) AS GradeCount
FROM 
    Grade
GROUP BY 
    TeacherID
HAVING 
    COUNT(*) > 200
ORDER BY 
    GradeCount DESC;
--Find the Grade Count, Maximal Grade, and the Average Grade per Student on
--all grades in the system. Filter only records where Maximal Grade is equal to
--Average Grade

SELECT 
    s.ID AS StudentID,
    s.FirstName AS StudentName,
    s.LastName AS StudentLName,
    g_stats.GradeCount,
    g_stats.MaximalGrade,
    g_stats.AverageGrade
FROM 
    Student s
JOIN (
    -- Your original grade statistics query as a subquery
    SELECT 
        StudentID,
        COUNT(*) AS GradeCount,
        MAX(Grade) AS MaximalGrade,
        AVG(Grade) AS AverageGrade
    FROM 
        Grade
    GROUP BY 
        StudentID
    HAVING 
        MAX(Grade) = AVG(Grade)
) g_stats ON s.ID = g_stats.StudentID
ORDER BY 
    s.LastName, s.FirstName;
     

--Create new view (vv_StudentGrades) that will List all StudentIds and count of
--Grades per student

--Change the view to show Student First and Last Names instead of StudentID
--List all rows from view ordered by biggest Grade Count