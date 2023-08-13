/*
--Reference
https://www.youtube.com/watch?v=7GpyHedM4pw ==> Simple Recursion in SQL
https://www.youtube.com/watch?v=N3ChrpDRcXY ==> How does a recursive CTE work
*/

USE AdventureWorksDW2014
GO

SELECT EmployeeKey
    , ParentEmployeeKey
    , FirstName
    , MiddleName
    , LastName
    , Title
    , DepartmentName
FROM AdventureWorksDW2014.dbo.DimEmployee
WHERE DepartmentName like 'Marketing%'
ORDER BY EmployeeKey

----Recursive query to get the employee hierarchy
WITH ReportingLine (EmployeeKey, ManagerKey, FirstName, MiddleName, LastName, Title, DepartmentName, [Level]) AS
    (
        SELECT EmployeeKey
            , ParentEmployeeKey as ManagerKey
            , FirstName
            , MiddleName
            , LastName
            , Title
            , DepartmentName
            , 0 as [Level]
        FROM AdventureWorksDW2014.dbo.DimEmployee
        WHERE ParentEmployeeKey IS NULL --Get the highest level, may be CEO
        ---Recursive to get all below level until to the end
        UNION ALL
        SELECT A.EmployeeKey
            , A.ParentEmployeeKey AS ManagerKey
            , A.FirstName
            , A.MiddleName
            , A.LastName
            , A.Title
            , A.DepartmentName
            , B.[Level] + 1 as [Level]
        FROM AdventureWorksDW2014.dbo.DimEmployee A
            INNER JOIN ReportingLine B ON A.ParentEmployeeKey = B.EmployeeKey
    )
SELECT *
FROM ReportingLine
WHERE DepartmentName like 'Marketing%' OR [Level] = 0
ORDER BY [Level]
