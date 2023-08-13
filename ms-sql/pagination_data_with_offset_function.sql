/*
--Template
SELECT *
FROM table
ORDER BY columnname
OFFSET (@PageNum - 1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY
*/
--Sample with AdventureWork database
DECLARE @PageNum int = 1 --change value here to access to page number
DECLARE @PageSize int = 4 --change value here for number of records per page

SELECT *
FROM AdventureWorks2014.HumanResources.Employee
ORDER BY BusinessEntityID
OFFSET (@pageNum - 1) * @pageSize ROWS
FETCH NEXT @pageSize ROWS ONLY
