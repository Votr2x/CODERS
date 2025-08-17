--------------
--1) FROM
--2) WHERE
--3) GROUP BY
--4) HAVING
--5) SELECT 
--6) ORDER BY
--------------

-- CONCAT_WS(SEPARATOR, COL_NAME, COL_NAME....)
SELECT BusinessEntityID,CONCAT_WS(' ', FirstName, MiddleName, LastName) AS FullName
FROM Person.Person;

-- CONCAT(COL_NAME, SEPARATOR, COL_NAME, SEPARATOR....)
SELECT BusinessEntityID,CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS FullName
FROM Person.Person;

-- DISCTINCT(UNIQUE VALUES)
SELECT DISTINCT MaritalStatus
FROM HumanResources.Employee;

-- * Return full table and multiplication
SELECT *, OrderQty * CAST(UnitPrice AS INT) AS TotalSum
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty BETWEEN 100 AND 175
-- BETWEEN doesn't count 175

-- Starting with A
SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE 'A%';

-- Ending with son
SELECT FirstName, LastName
FROM Person.Person
WHERE LastName LIKE '%son';

-- Position of A in the word
SELECT FirstName,CHARINDEX('a', FirstName) AS PositionOfA
FROM Person.Person;

-- ORDER BY ASC, DESC
SELECT BusinessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY HireDate ASC;

-- GROUP BY COL_NAME
SELECT JobTitle, COUNT(*) AS EmployeeCount
FROM HumanResources.Employee
GROUP BY JobTitle;

-- HAVING is used mostly with GROUP BY
SELECT JobTitle, COUNT(*) AS EmployeeCount
FROM HumanResources.Employee
GROUP BY JobTitle
HAVING COUNT(*) > 5;

-- Subquery
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (
    SELECT BusinessEntityID
    FROM HumanResources.Employee
    WHERE JobTitle = 'Sales Representative'
);

-- Rate that is more than ANY Rate of 15 employee 
SELECT BusinessEntityID, Rate
FROM HumanResources.EmployeePayHistory
WHERE Rate > ANY (
    SELECT Rate 
    FROM HumanResources.EmployeePayHistory
    WHERE BusinessEntityID = 15
);

-- Rate that is more than ALL Rate of 15 employee 
SELECT BusinessEntityID, Rate
FROM HumanResources.EmployeePayHistory
WHERE Rate > ALL (
    SELECT Rate 
    FROM HumanResources.EmployeePayHistory
    WHERE BusinessEntityID = 15
);

-- IN
SELECT JobTitle
FROM HumanResources.Employee
WHERE JobTitle IN ('Design Engineer','Senior Tool Designer')

-- EXISTS
SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee e
WHERE EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader s
    WHERE s.SalesPersonID = e.BusinessEntityID
);

-- NOT EXISTS
SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee e
WHERE NOT EXISTS (
    SELECT 0
    FROM Sales.SalesOrderHeader s
    WHERE s.SalesPersonID = e.BusinessEntityID
);

-- JOINS

-- INNER JOIN returns rows where there is a match in both tables.
SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    so.SalesOrderID
FROM Sales.Customer AS c
JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader AS so
    ON c.CustomerID = so.CustomerID;

-- LEFT JOIN returns all rows from the left table + matching rows from the right table (null if no match).
SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    so.SalesOrderID
FROM Sales.Customer AS c
JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.SalesOrderHeader AS so
    ON c.CustomerID = so.CustomerID;

-- RIGHT JOIN is opposite of LEFT JOIN — returns all rows from the right table, matches from the left.
SELECT 
    so.SalesOrderID,
    c.CustomerID,
    p.FirstName,
    p.LastName
FROM Sales.SalesOrderHeader AS so
RIGHT JOIN Sales.Customer AS c
    ON so.CustomerID = c.CustomerID
RIGHT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID;

-- FULL OUTER JOIN returns all rows from both tables — matches when possible, NULL otherwise.
SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    so.SalesOrderID
FROM Sales.Customer AS c
FULL OUTER JOIN Sales.SalesOrderHeader AS so
    ON c.CustomerID = so.CustomerID
LEFT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID;

-- CROSS JOIN returns every row from one table with every row from another table — “all combinations”.
SELECT TOP 3 p.Name, so.Description
FROM Production.Product AS p
CROSS JOIN Sales.SpecialOffer AS so;

-- EXCEPT returns rows from the first query that are not in the second query.
SELECT City
FROM Person.Address a
JOIN Sales.Customer c ON a.AddressID = c.CustomerID
EXCEPT
SELECT City
FROM Person.Address a
JOIN HumanResources.Employee e ON a.AddressID = e.BusinessEntityID;
 
-- UNION combines results from two queries.
SELECT City
FROM Person.Address a
JOIN Sales.Customer c ON a.AddressID = c.CustomerID
UNION
SELECT City
FROM Person.Address a
JOIN HumanResources.Employee e ON a.AddressID = e.BusinessEntityID;

-- UNION ALL is same as UNION, but keeps duplicates.
SELECT City
FROM Person.Address a
JOIN Sales.Customer c ON a.AddressID = c.CustomerID
UNION ALL
SELECT City
FROM Person.Address a
JOIN HumanResources.Employee e ON a.AddressID = e.BusinessEntityID;

-- INTERSECT returns only rows that appear in both queries.
SELECT City
FROM Person.Address a
JOIN Sales.Customer c ON a.AddressID = c.CustomerID
INTERSECT
SELECT City
FROM Person.Address a
JOIN HumanResources.Employee e ON a.AddressID = e.BusinessEntityID;