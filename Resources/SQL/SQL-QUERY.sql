
---------------------Introduction--------
--1) FROM
--2) WHERE
--3) GROUP BY
--4) HAVING
--5) SELECT 
--6) ORDER BY
-------------------------------------------

SELECT *
FROM HumanResources.Employee;

SELECT *, NationalIDNumber, MaritalStatus
FROM HumanResources.Employee;

SELECT NationalIDNumber + '_' + MaritalStatus  AS N'Cədvəl adı'
FROM HumanResources.Employee;

SELECT CONCAT_WS('_',NationalIDNumber, BirthDate, MaritalStatus) AS 'Concat Column'
FROM HumanResources.Employee;

SELECT CONCAT(NationalIDNumber,'_',BirthDate,'->',MaritalStatus) AS Concat_Column
FROM HumanResources.Employee;

SELECT DISTINCT MaritalStatus
FROM HumanResources.Employee;

SELECT DISTINCT MaritalStatus,Gender
FROM HumanResources.Employee;

SELECT *, OrderQty * UnitPrice  AS TOTAL_SUM 
FROM Purchasing.PurchaseOrderDetail
WHERE TOTAL_SUM >200 

SELECT *, OrderQty * UnitPrice  AS TOTAL_SUM 
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty * UnitPrice >200 

SELECT *, OrderQty * CAST(UnitPrice AS FLOAT) AS TOTAL_SUM 
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty * CAST(UnitPrice AS FLOAT)>200

SELECT *, OrderQty * CAST(UnitPrice AS INT) AS TOTAL_SUM
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty BETWEEN 100 AND 175

SELECT *
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty>100 AND ProductID<700

SELECT *
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty=100 OR OrderQty=550

SELECT *, OrderQty * UnitPrice AS TOTAL_SUM 
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty * UnitPrice>200 
	AND (OrderQty * UnitPrice>700 
	     OR OrderQty * UnitPrice<500)

SELECT *, OrderQty * UnitPrice AS TOTAL_SUM 
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty * UnitPrice>200 
	AND OrderQty * UnitPrice>700 
	OR OrderQty * UnitPrice<500

SELECT *
FROM Purchasing.PurchaseOrderDetail
WHERE ((OrderQty IN(100,550,500,175) OR StockedQty IN(550,468)) 
		AND ProductID<900) AND UnitPrice NOT BETWEEN 15 AND 20

SELECT *
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty NOT IN (500,550)

SELECT *
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty!=500 AND OrderQty<>550

SELECT *
FROM Purchasing.PurchaseOrderDetail
WHERE NOT (OrderQty<>500 AND OrderQty<>550) --IN(500,550)

SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '_E%'  

SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '__A%'

SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '%B%'

SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '%or'or JobTitle LIKE '%er'

SELECT *
FROM HumanResources.Employee
WHERE CHARINDEX('A', JobTitle) !=0;

SELECT CHARINDEX('A', JobTitle) indexChar,JobTitle
FROM HumanResources.Employee

SELECT JobTitle
FROM HumanResources.Employee
WHERE  CHARINDEX('a', JobTitle, CHARINDEX('a', JobTitle) + 1) > 0  
  AND CHARINDEX('a', JobTitle, CHARINDEX('a', JobTitle, CHARINDEX('a', JobTitle)+ 1) + 1) = 0;

SELECT *
FROM HumanResources.Employee
WHERE JobTitle NOT LIKE '_E%'

SELECT *
FROM HumanResources.Employee
WHERE jobtitle IN ('Design Engineer','Senior Tool Designer')


SELECT * 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA ='HumanResources'

---------------------------Order BY, Group BY------------------
SELECT BusinessEntityID,NationalIDNumber,LoginID,BirthDate
FROM HumanResources.Employee
WHERE JobTitle LIKE '_E%'
ORDER BY BirthDate DESC

SELECT TOP(2) BusinessEntityID,NationalIDNumber,LoginID,BirthDate , 5 as NUM
FROM HumanResources.Employee
WHERE JobTitle LIKE '_E%'
ORDER BY BirthDate 

SELECT BusinessEntityID,NationalIDNumber,LoginID,BirthDate
FROM HumanResources.Employee
WHERE JobTitle LIKE '_E%'
ORDER BY 4 DESC

SELECT BusinessEntityID,NationalIDNumber,LoginID,JobTitle, BirthDate
FROM HumanResources.Employee
WHERE JobTitle LIKE '_E%'
ORDER BY JobTitle, BirthDate DESC

SELECT AVG(DISTINCT UnitPrice) AS AVG_PRICE
FROM Purchasing.PurchaseOrderDetail

SELECT AVG(UnitPrice) AS AVG_PRICE
FROM Purchasing.PurchaseOrderDetail

SELECT COUNT(DISTINCT UnitPrice) AS CNT_PRICE
FROM Purchasing.PurchaseOrderDetail

SELECT COUNT(UnitPrice) AS CNT_PRICE
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IS NOT NULL

SELECT COUNT(UnitPrice) AS CNT_PRICE
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IS NULL

----
SELECT *
FROM HumanResources.Employee
WHERE OrganizationLevel IS NULL

SELECT COUNT(OrganizationLevel) AS Cnt
FROM HumanResources.Employee
WHERE OrganizationLevel IS NULL

SELECT COUNT(*) AS Cnt
FROM HumanResources.Employee
WHERE OrganizationLevel IS NULL
---

SELECT SUM(DISTINCT UnitPrice)
FROM Purchasing.PurchaseOrderDetail

SELECT SUM(UnitPrice)
FROM Purchasing.PurchaseOrderDetail

SELECT DueDate,
	   SUM(UnitPrice)  AS SUM_UnitPrice, 
	   COUNT(OrderQty) AS Count_OrderQty
FROM Purchasing.PurchaseOrderDetail
GROUP BY DueDate
ORDER BY DueDate DESC

SELECT YEAR(DueDate) AS Year_DueDate,
	MONTH(DueDate) AS Year_DueMonth, 
	SUM(UnitPrice) AS SUM_UnitPrice,
	COUNT(OrderQty) AS CNT_OrderQty,
	COUNT(DISTINCT OrderQty) AS CNT_DIST_OrderQty,
	COUNT(DueDate) AS CNT_DueDate
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice>40
GROUP BY YEAR(DueDate), MONTH(DueDate)
HAVING YEAR(DueDate) IN (2013,2014)
ORDER BY YEAR(DueDate) DESC, MONTH(DueDate) DESC

SELECT *
FROM Purchasing.PurchaseOrderDetail
ORDER BY DueDate DESC

SELECT OrganizationLevel, COUNT(*) AS Cnt
FROM HumanResources.Employee
GROUP BY OrganizationLevel
ORDER BY OrganizationLevel

SELECT OrganizationLevel, COUNT(OrganizationLevel) AS Cnt
FROM HumanResources.Employee
GROUP BY OrganizationLevel
ORDER BY OrganizationLevel

-----------------------Subquery-------------
SELECT *,
	 (SELECT AVG(UnitPrice) FROM Sales.SalesOrderDetail) AS AVG_UnitPrice --inline views(inner query)
	 --,(SELECT AVG(TotalDue) FROM Sales.SalesOrderHeader)
FROM Sales.SalesOrderDetail

SELECT *,
		(SELECT AVG(UnitPrice) 
			FROM Sales.SalesOrderDetail) AS AVG_UnitPrice
FROM Sales.SalesOrderDetail
WHERE SalesOrderID > 50000 AND UnitPrice > (SELECT AVG(UnitPrice) --nested subqueries
				  FROM Sales.SalesOrderDetail)

SELECT *,
		(SELECT AVG(UnitPrice) 
			FROM Sales.SalesOrderDetail) AS AVG_UnitPrice
FROM Sales.SalesOrderDetail
WHERE UnitPrice = (SELECT AVG(UnitPrice) --nested subqueries
				  FROM Sales.SalesOrderDetail)

SELECT * 
FROM Production.Product
WHERE ProductID IN (SELECT ProductID 
						FROM Sales.SalesOrderDetail
						WHERE UnitPrice>(SELECT AVG(UnitPrice) 
										  FROM Sales.SalesOrderDetail))
SELECT Name,
		(SELECT COUNT(ProductID) 
			FROM Sales.SalesOrderDetail sls 
			WHERE sls.ProductID=prd.ProductID) AS Cnt
	FROM Production.Product AS prd
	ORDER BY 2 DESC;

--ANY
--SOME
--ALL
  ---
SELECT Name,ListPrice
FROM production.product
WHERE ListPrice = ANY (
        SELECT AVG (ListPrice) avg_list_price
        FROM production.product
		GROUP BY Color)
ORDER BY ListPrice;
---Ekvivalent-----
SELECT Name,ListPrice
FROM production.product
WHERE ListPrice IN (
        SELECT AVG (ListPrice) avg_list_price
        FROM production.product
		GROUP BY Color)
ORDER BY ListPrice;

SELECT Name,ListPrice
FROM production.product
WHERE ListPrice > ANY (
        SELECT AVG (ListPrice) avg_list_price
        FROM production.product
		GROUP BY Color)
ORDER BY ListPrice;
---Ekvivalent-----
SELECT Name,ListPrice
FROM production.product
WHERE ListPrice >(
        SELECT MIN(avg_list_price)
		FROM (
         SELECT AVG (ListPrice) avg_list_price
         FROM production.product
		 GROUP BY Color)t
		 )
ORDER BY ListPrice;

SELECT Name,ListPrice
FROM production.product
WHERE ListPrice < ANY (
        SELECT AVG (ListPrice) avg_list_price
        FROM production.product
		GROUP BY Color)
ORDER BY ListPrice;
---Ekvivalent-----
SELECT Name,ListPrice
FROM production.product
WHERE ListPrice <(
        SELECT MAX(avg_list_price)
		FROM (
         SELECT AVG (ListPrice) avg_list_price
         FROM production.product
		 GROUP BY Color)t
		 )
ORDER BY ListPrice;
---------------------------------
SELECT Name,ListPrice
FROM production.product
WHERE ListPrice = ALL (
        SELECT AVG (ListPrice) avg_list_price
        FROM production.product
		GROUP BY Color
		)
ORDER BY ListPrice;

SELECT Name,ListPrice
FROM production.product
WHERE ListPrice > ALL (
        SELECT AVG (ListPrice) avg_list_price
        FROM production.product
		GROUP BY Color)
ORDER BY ListPrice;
------Ekvivalent
SELECT Name,ListPrice
FROM production.product
WHERE ListPrice >  (
        SELECT MAX(avg_list_price)
		FROM (
         SELECT AVG (ListPrice) avg_list_price
         FROM production.product
		 GROUP BY Color)t
		)
ORDER BY ListPrice;

SELECT Name,ListPrice
FROM production.product
WHERE ListPrice < ALL (
        SELECT AVG (ListPrice) avg_list_price
        FROM production.product
		GROUP BY Color)
ORDER BY ListPrice;
------Ekvivalent
SELECT Name,ListPrice
FROM production.product
WHERE ListPrice <  (
        SELECT MIN(avg_list_price)
		FROM (
         SELECT AVG (ListPrice) avg_list_price
         FROM production.product
		 GROUP BY Color
		 )t
		)
ORDER BY ListPrice;

SELECT Name,ListPrice
FROM production.product
WHERE ListPrice <> ALL (
        SELECT AVG (ListPrice) avg_list_price
        FROM production.product
		GROUP BY Color)
ORDER BY ListPrice;
------Ekvivalent
SELECT Name,ListPrice
FROM production.product
WHERE ListPrice NOT IN  (
         SELECT AVG (ListPrice) avg_list_price
         FROM production.product
		 GROUP BY Color)
ORDER BY ListPrice;

--price = ANY (1,2) => price = 1 or price = 2 , in (1,2)
--price > ANY (1,2) => price > 1
--price < ANY (1,2) => price < 2
--price <> ANY (1,2) => price <> 1 or price <> 2, not in (1,2)

--price = ALL (1,2) => price=1 and price=2
--price > ALL (1,2) => price > 2
--price < ALL (1,2) => price < 1
--price <> ALL (1,2) => price NOT in (1,2)

SELECT * 
FROM Production.Product p
WHERE EXISTS (SELECT ProductID 
			  FROM Sales.SalesOrderDetail s
			  WHERE p.ProductID=s.ProductID 
				AND s.UnitPrice>(SELECT AVG(UnitPrice) 
								FROM Sales.SalesOrderDetail))

SELECT * 
FROM Production.Product AS p
WHERE EXISTS (SELECT 1 
			  FROM Sales.SalesOrderDetail AS s
			  WHERE s.ProductID=p.ProductID 
				AND s.UnitPrice>(SELECT AVG(UnitPrice) 
								FROM Sales.SalesOrderDetail))

SELECT * 
FROM Production.Product AS p
WHERE NOT EXISTS (SELECT 0 
					FROM Sales.SalesOrderDetail AS s
					WHERE s.ProductID=p.ProductID 
					AND s.UnitPrice>(SELECT AVG(UnitPrice) 
								FROM Sales.SalesOrderDetail))

---------------------JOINS----------------------
--SELF
--CROSS JOIN(Cartesian) 
--INNER JOIN
--OUTER JOIN 
  --Left
  --Right
  --Full

SELECT *
FROM Production.Product

SELECT p1.ProductID AS p1_ID,
	   p1.Name AS p1_Name,
	   p2.ProductID AS p_2ID, 
	   p2.Name AS p2_Name,
	   p1.SafetyStockLevel AS p1_Stock_level,
	   p2.SafetyStockLevel AS p2_Stock_level
FROM Production.Product p1, Production.Product p2
WHERE p1.ProductID < p2.ProductID 
  AND p1.SafetyStockLevel<>p2.SafetyStockLevel
  AND (p1.Name = 'Adjustable Race' OR p2.Name = 'Adjustable Race')
  --AND p1.SafetyStockLevel=p2.SafetyStockLevel

SELECT p.Name,pc.Name
FROM Production.Product p
CROSS JOIN Production.ProductCategory pc
ORDER BY p.Name

--(r11,r12) * (r21,r22) = ((r11-r21),(r11-r22),(r12-r21),(r12-r22))

--n*m
  --(x1,x2,x3) (y1,y2,y3) => 
  --     ((x1,y1),(x2,y1),(x3,y1),
	 --  (x1,y2),(x2,y2),(x3,y2),
	 --  (x1,y3),(x2,y3),(x3,y3))

--SELECT p1.ProductID,p2.ProductID,p1.Name AS p1Name,p2.Name AS p2Name,p1.SafetyStockLevel,p2.SafetyStockLevel
--FROM Production.Product p1 
--JOIN Production.Product p2 ON p1.ProductID <> p2.ProductID 
--  AND p1.SafetyStockLevel<>p2.SafetyStockLevel 
--WHERE (p1.ProductID < p2.ProductID) 
--	  AND (p1.Name = 'Adjustable Race' OR p2.Name = 'Adjustable Race')

SELECT SlsOrdHdr.*, SlsOrdDtl.ProductID , Prd.Color
FROM Sales.SalesOrderHeader SlsOrdHdr
INNER JOIN Sales.SalesOrderDetail AS SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
JOIN Production.Product Prd
     ON Prd.ProductID = SlsOrdDtl.ProductID
WHERE Prd.Color='Black'

 --1) JOIN => data
 --2) JOIN => data
 --3) WHERE => output

SELECT SlsOrdHdr.*,SlsOrdDtl.ProductID, Prd.Color
FROM Sales.SalesOrderHeader SlsOrdHdr
JOIN Sales.SalesOrderDetail SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
JOIN Production.Product Prd
     ON Prd.ProductID = SlsOrdDtl.ProductID 
		AND Prd.Color='Black'

 --1) JOIN =>data
 --2) JOIN (WHERE )=> output

SELECT TOP(5) Prd.Color, count(SlsOrdHdr.SalesOrderID) AS Cnt
FROM Sales.SalesOrderHeader SlsOrdHdr
JOIN Sales.SalesOrderDetail SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
JOIN Production.Product Prd
     ON Prd.ProductID = SlsOrdDtl.ProductID
--WHERE prd.Color IS NOT NULL
GROUP BY Prd.Color
HAVING Prd.Color IS NOT NULL
ORDER BY Cnt DESC

SELECT TOP(10) prdcatsub.Name, Prd.Color, count(SlsOrdHdr.SalesOrderID) AS Cnt
FROM Sales.SalesOrderHeader SlsOrdHdr
JOIN Sales.SalesOrderDetail SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
JOIN Production.Product Prd
     ON Prd.ProductID = SlsOrdDtl.ProductID
JOIN Production.ProductSubcategory prdcatsub
	ON prdcatsub.ProductSubcategoryID = Prd.ProductSubcategoryID
JOIN Production.ProductCategory prdcat 
	ON prdcat.ProductCategoryID = prdcatsub.ProductCategoryID
WHERE prdcat.ProductCategoryID = 1
GROUP BY prdcatsub.Name,Prd.Color
HAVING Prd.Color IS NOT NULL
ORDER BY Cnt DESC

---Sales.SalesOrderHeader => Sales.SalesOrderDetail => Production.Product

SELECT *
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE SlsOrdDtl.SalesOrderDetailID IS NULL

SELECT *
FROM Sales.SalesOrderHeader SlsOrdHdr
RIGHT JOIN Sales.SalesOrderDetail SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
RIGHT JOIN Production.Product Prd
     ON Prd.ProductID = SlsOrdDtl.ProductID
WHERE SlsOrdDtl.SalesOrderDetailID IS NULL

SELECT *
FROM Sales.SalesOrderHeader SlsOrdHdr
FULL JOIN Sales.SalesOrderDetail SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
FULL JOIN Production.Product Prd
     ON Prd.ProductID = SlsOrdDtl.ProductID
WHERE SlsOrdDtl.SalesOrderDetailID IS NULL

SELECT *
FROM Sales.SalesOrderHeader SlsOrdHdr
JOIN Sales.SalesOrderDetail SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
RIGHT JOIN Production.Product Prd
     ON Prd.ProductID = SlsOrdDtl.ProductID
WHERE SlsOrdDtl.SalesOrderDetailID IS NULL

SELECT SlsOrdHdr.*,SlsOrdDtl.ProductID , Prd.Color
FROM Sales.SalesOrderHeader SlsOrdHdr
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
RIGHT JOIN Production.Product Prd
     ON Prd.Color='Black' AND Prd.ProductID = SlsOrdDtl.ProductID
--WHERE Prd.Color = 'Black' AND SlsOrdDtl.ProductID IS NOT NULL

SELECT SlsOrdHdr.*,SlsOrdDtl.ProductID, Prd.Color
FROM Sales.SalesOrderHeader SlsOrdHdr
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
RIGHT JOIN Production.Product Prd
     ON Prd.ProductID = SlsOrdDtl.ProductID 
WHERE Prd.Color='Black'

SELECT DISTINCT Prd.Color
FROM Production.Product Prd

---SET OPERATORS

--EXCEPT
--UNION
--UNION ALL
--INTERSECT

--EXCEPT

SELECT *
FROM HumanResources.Employee

EXCEPT

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender = 'F'

SELECT prd.ProductID,prd.Name,prd.color AS prd_color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID --AND Prd.Color='Black'
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID

EXCEPT

SELECT prd.ProductID,prd.Name,prd.color 
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Black' OR Prd.Color IS NULL
------

SELECT prd.ProductID,prd.Name,prd.color 
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Black' OR Prd.Color IS NULL

EXCEPT

SELECT prd.ProductID,prd.Name,prd.color AS prd_color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID


--UNION

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender IN ('F', 'M')

UNION

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender = 'F'



SELECT prd.ProductID,prd.Name,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

UNION

SELECT prd.ProductID,prd.Name,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY Color DESC

SELECT *
FROM (
	SELECT prd.ProductID,prd.Name,prd.color , 'Baki' AS Source
	FROM Production.Product Prd
	LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
		 ON Prd.ProductID = SlsOrdDtl.ProductID 
	LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
		 ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
	WHERE Prd.Color IN ('Black','Silver')

	UNION

	SELECT prd.ProductID,prd.Name,prd.color, 'Shamaxi' AS Source
	FROM Production.Product Prd
	LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
		 ON Prd.ProductID = SlsOrdDtl.ProductID
	LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
		 ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
	WHERE Prd.Color='Silver'
	--ORDER BY Color DESC
) t

--UNION ALL

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender IN ('F', 'M')

UNION ALL

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender = 'F'


SELECT prd.ProductID,prd.Name, prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

UNION ALL

SELECT prd.ProductID,prd.Name,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY ProductID DESC

SELECT DISTINCT prd.ProductID,prd.Name, prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

UNION ALL

SELECT DISTINCT prd.ProductID,prd.Name,prd.color as color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY ProductID DESC

SELECT DISTINCT prd.ProductID,prd.Name, 'Unknown' AS color
--,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

UNION ALL

SELECT DISTINCT prd.ProductID,prd.Name,prd.color AS color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY ProductID DESC

SELECT DISTINCT prd.ProductID,prd.Name, 5 AS color
--,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

UNION ALL

SELECT DISTINCT prd.ProductID,prd.Name,prd.color AS color1
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY ProductID DESC

SELECT DISTINCT prd.ProductID,prd.Name,Prd.Color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

UNION ALL

SELECT DISTINCT prd.ProductID,prd.Name,'Unknown' AS color
--prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY ProductID DESC

--INTERSECT

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender IN ('F', 'M')

INTERSECT

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND Gender = 'F'
ORDER BY BusinessEntityID

--
SELECT prd.ProductID,prd.Name, prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

INTERSECT

SELECT prd.ProductID,prd.Name,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY Color DESC

SELECT DISTINCT prd.ProductID,prd.Name, prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Silver')

INTERSECT

SELECT DISTINCT prd.ProductID,prd.Name,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')
ORDER BY Color DESC

SELECT prd.ProductID,prd.Weight AS Name, prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

INTERSECT

SELECT prd.ProductID,prd.Name,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY Color DESC

SELECT prd.ProductID, prd.ProductNumber AS Name, prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID 
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color IN ('Black','Silver')

INTERSECT

SELECT prd.ProductID,prd.Name,prd.color
FROM Production.Product Prd
LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
     ON Prd.ProductID = SlsOrdDtl.ProductID
LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
     ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
WHERE Prd.Color='Silver'
ORDER BY Color DESC

----------Windows Function----------
--COUNT(),SUM() ....OVER (PARTITION BY ... ORDER BY ...)

--Aggregate Window Functions
--SUM(), MAX(), MIN(), AVG(), COUNT()
--Ranking Window Functions
--RANK(), DENSE_RANK(), ROW_NUMBER(), NTILE()
--Value Window Functions
--LAG(), LEAD(), FIRST_VALUE(), LAST_VALUE()

SELECT SalesPersonID,YEAR(OrderDate) AS YD,MONTH(OrderDate) AS MN,ROUND(SubTotal,0) AS Round_SubTotal,
	   SUM(SubTotal) OVER (PARTITION BY SalesPersonID,YEAR(OrderDate) 
							ORDER BY SalesPersonID DESC) AS SubTotalSUM_BYDATE,
       SUM(SubTotal) OVER (PARTITION BY SalesPersonID 
							ORDER BY SalesPersonID DESC) AS SubTotalSUM,
	   SUM(SubTotal) OVER () AS TotalSubTotalSUM,
	   COUNT(SalesPersonID) OVER (PARTITION BY SalesPersonID,YEAR(OrderDate)  
							ORDER BY SalesPersonID DESC) AS SubTotalCount_BYDATE,
	   COUNT(SalesPersonID) OVER (PARTITION BY SalesPersonID 
							ORDER BY SalesPersonID DESC) AS SubTotalCount,
	   AVG(SubTotal) OVER (PARTITION BY SalesPersonID 
							ORDER BY SalesPersonID DESC) AS SubTotalAVG,
	   MIN(SubTotal) OVER (PARTITION BY SalesPersonID) AS SubTotalMIN,
	   MAX(SubTotal) OVER (PARTITION BY SalesPersonID 
							ORDER BY SalesPersonID DESC) AS SubTotalMAX,
	   ROW_NUMBER() OVER (PARTITION BY SalesPersonID,YEAR(OrderDate) ORDER BY ROUND(Subtotal,0)) AS RNM,
	   RANK()       OVER (PARTITION BY SalesPersonID,YEAR(OrderDate) ORDER BY ROUND(Subtotal,0)) AS RNK,
	   DENSE_RANK() OVER (PARTITION BY SalesPersonID,YEAR(OrderDate) ORDER BY ROUND(Subtotal,0)) AS D_RNK,
	   NTILE(10)    OVER (PARTITION BY SalesPersonID,YEAR(OrderDate) ORDER BY ROUND(Subtotal,0)) AS NTILE_
FROM Sales.SalesOrderHeader SlsOrdHdr
--WHERE SalesPersonID = 290 AND YEAR(OrderDate)=2012
ORDER BY SalesPersonID DESC;

With SalesPersonINFO AS (
SELECT
    s.[BusinessEntityID]
    ,p.[Title]
    ,p.[FirstName]
    ,p.[MiddleName]
    ,p.[LastName]
    ,p.[Suffix]
    ,e.[JobTitle]
    ,pp.[PhoneNumber]
	,pnt.[Name] AS [PhoneNumberType]
    ,ea.[EmailAddress]
    ,a.[AddressLine1]
    ,a.[AddressLine2]
    ,a.[City]
    ,[StateProvinceName] = sp.[Name]
    ,a.[PostalCode]
    ,cr.[Name] AS [CountryRegionName]
    ,st.[Name] AS [TerritoryName]
    ,st.[Group] AS [TerritoryGroup] 
    ,s.[SalesQuota]
    ,s.[SalesYTD]
    ,s.[SalesLastYear]
FROM [Sales].[SalesPerson] s
    INNER JOIN [HumanResources].[Employee] e 
    ON e.[BusinessEntityID] = s.[BusinessEntityID]
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = s.[BusinessEntityID]
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = s.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    LEFT OUTER JOIN [Sales].[SalesTerritory] st 
    ON st.[TerritoryID] = s.[TerritoryID]
	LEFT OUTER JOIN [Person].[EmailAddress] ea
	ON ea.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PersonPhone] pp
	ON pp.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
	ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID]
)
SELECT SlsOrdHdr.*,SlsOrdDtl.ProductID,spi.*,
	   CASE WHEN TotalDue>50000 THEN 'High'
	        WHEN TotalDue=50000 THEN 'Average'
	        ELSE 'LOW' 
	   END AS ExpencesType,
       COUNT(spi.BusinessEntityID) OVER () AS TotalSalesPersonCNT,
	   COUNT(SlsOrdHdr.SalesOrderID) OVER (PARTITION BY YEAR(OrderDate)) AS SalesOrderCNT,
	   CASE WHEN PhoneNumberType='Cell' THEN 1 ELSE 0 END AS Cell_Type,
	   SUM(CASE WHEN PhoneNumberType='Cell' THEN 1 ELSE 0 END) OVER () AS PhoneNumberTypeCellCnt
	  --(SELECT COUNT(spi.BusinessEntityID) OVER () FROM SalesPersonINFO ) AS SalesPersonCNTbyType
		FROM Sales.SalesOrderHeader SlsOrdHdr
			JOIN Sales.SalesOrderDetail SlsOrdDtl
			ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
			JOIN SalesPersonINFO spi
			ON spi.[BusinessEntityID]=SlsOrdHdr.SalesPersonID;


--Types of Window Frames:

--UNBOUNDED PRECEDING
--Syntax: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--Description: The frame starts at the first row of the partition and ends at the current row.

--UNBOUNDED FOLLOWING
--Syntax: ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
--Description: The frame starts at the current row and ends at the last row of the partition.

--CURRENT ROW
--Syntax: ROWS BETWEEN CURRENT ROW AND CURRENT ROW
--Description: The frame includes only the current row.

--n PRECEDING
--Syntax: ROWS BETWEEN n PRECEDING AND CURRENT ROW
--Description: The frame starts n rows before the current row and ends at the current row.

--n FOLLOWING
--Syntax: ROWS BETWEEN CURRENT ROW AND n FOLLOWING
--Description: The frame starts at the current row and ends n rows after the current row.

--BETWEEN n PRECEDING AND n FOLLOWING
--Syntax: ROWS BETWEEN n PRECEDING AND n FOLLOWING
--Description: The frame starts n rows before the current row and ends n rows after the current row.

SELECT *,
	   LAG(TotalSum) OVER (PARTITION BY SalesPersonID ORDER BY SalesPersonID,YD) AS SalesLag,
	   LEAD(TotalSum) OVER (PARTITION BY SalesPersonID ORDER BY SalesPersonID,YD) AS SalesLead,
	   FIRST_VALUE(TotalSum) OVER (PARTITION BY SalesPersonID ORDER BY SalesPersonID) AS SalesFIRST_VALUE,
	   LAST_VALUE(TotalSum) OVER (PARTITION BY SalesPersonID ORDER BY SalesPersonID) AS SalesLAST_VALUE,
	   SUM(TotalSum) OVER (PARTITION BY SalesPersonID ORDER BY YD ROWS 
							BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeTotalSum
FROM(
	SELECT DISTINCT SalesPersonID,
	    YEAR(OrderDate) AS 'YD',
		COUNT(TotalDue) OVER (PARTITION BY SalesPersonID ,YEAR(OrderDate)) AS TotalCnt,
		AVG(TotalDue) OVER (PARTITION BY SalesPersonID ,YEAR(OrderDate)) AS AvgPerY,
		SUM(TotalDue) OVER (PARTITION BY SalesPersonID ,YEAR(OrderDate)) AS TotalSum
	FROM AdventureWorks.Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
) t




-------Practise------

SELECT TOP 1 SalesPersonID,
	   --YEAR(OrderDate) AS YD,
	   --MONTH(OrderDate) AS MN,
	   --ROUND(SubTotal,0) AS Round_SubTotal,
	   MIN(SubTotal) OVER (PARTITION BY SalesPersonID) AS SubTotalMIN,
	   MAX(SubTotal) OVER (PARTITION BY SalesPersonID
	                 ORDER BY SalesPersonID DESC) AS SubTotalMAX 
FROM Sales.SalesOrderHeader SlsOrdHdr
ORDER BY SubTotalMAX DESC;

SELECT TOP 1 SalesPersonID,
	   --YEAR(OrderDate) AS YD,
	   --MONTH(OrderDate) AS MN,
	   --ROUND(SubTotal,0) AS Round_SubTotal,
	   MIN(SubTotal) OVER (PARTITION BY SalesPersonID) AS SubTotalMIN,
	   MAX(SubTotal) OVER (PARTITION BY SalesPersonID
	                 ORDER BY SalesPersonID DESC) AS SubTotalMAX 
FROM Sales.SalesOrderHeader SlsOrdHdr
ORDER BY SubTotalMIN;

----
SELECT 
    MIN(SalesPersonID) AS SalesPersonID_MIN,
    MIN(SubTotalMIN) AS SubTotalMIN_MIN,
    MAX(SalesPersonID) AS SalesPersonID_MAX,
    MAX(SubTotalMAX) AS SubTotalMAX_MAX
FROM (
    SELECT 
        SalesPersonID,
        MIN(SubTotal) AS SubTotalMIN,
        MAX(SubTotal) AS SubTotalMAX
    FROM Sales.SalesOrderHeader
    GROUP BY SalesPersonID
) AS t;

----
SELECT DISTINCT 
	   MIN(SalesPersonID_MIN) OVER () AS SalesPersonID_MIN,
	   MIN(SubTotalMIN_MIN) OVER () AS SubTotalMIN_MIN,
	   MAX(SalesPersonID_MAX) OVER () AS SalesPersonID_MAX,
	   MAX(SubTotalMAX_MAX) OVER () AS SubTotalMIN_MAX
FROM(
	SELECT DISTINCT
		   CASE WHEN SubTotalMIN = MIN(SubTotalMIN) OVER () THEN SalesPersonID END AS SalesPersonID_MIN,
		   MIN(SubTotalMIN) OVER () AS SubTotalMIN_MIN,
		   CASE WHEN SubTotalMAX = MAX(SubTotalMAX) OVER () THEN SalesPersonID END AS SalesPersonID_MAX,
		   MAX(SubTotalMAX) OVER () AS SubTotalMAX_MAX
	FROM(
		SELECT DISTINCT SalesPersonID,
			   MIN(SubTotal) OVER (PARTITION BY SalesPersonID) AS SubTotalMIN,
			   MAX(SubTotal) OVER (PARTITION BY SalesPersonID
							 ORDER BY SalesPersonID DESC) AS SubTotalMAX 
		FROM Sales.SalesOrderHeader SlsOrdHdr
	) AS t
) tt

-----
WITH Subtotals AS (
    SELECT DISTINCT
        SalesPersonID,
		SubTotal,
        MIN(SubTotal) OVER () AS SubTotalMIN,
        MAX(SubTotal) OVER () AS SubTotalMAX
    FROM Sales.SalesOrderHeader
),
MinSalesPerson AS (
    SELECT DISTINCT
        SalesPersonID AS SalesPersonID_MIN
    FROM Subtotals
    WHERE SubTotal = SubTotalMIN
),
MaxSalesPerson AS (
    SELECT DISTINCT
        SalesPersonID AS SalesPersonID_MAX
    FROM Subtotals
    WHERE SubTotal = SubTotalMAX
)
SELECT
    MIN(MinSalesPerson.SalesPersonID_MIN) AS SalesPersonID_MIN,
    MIN(Subtotals.SubTotalMIN) AS SubTotalMIN_MIN,
    MIN(MaxSalesPerson.SalesPersonID_MAX) AS SalesPersonID_MAX,
    MIN(Subtotals.SubTotalMAX) AS SubTotalMAX_MAX
FROM 
    Subtotals,
    MinSalesPerson,
    MaxSalesPerson;

SELECT 'sa';

-----
WITH Subtotals AS (
    SELECT 
        SalesPersonID,
        SubTotal,
        MIN(SubTotal) OVER () AS SubTotalMIN,
        MAX(SubTotal) OVER () AS SubTotalMAX
    FROM Sales.SalesOrderHeader
),
MinSalesPerson AS (
    SELECT DISTINCT
        SalesPersonID AS SalesPersonID_MIN
    FROM Subtotals
    WHERE SubTotal = SubTotalMIN
),
MaxSalesPerson AS (
    SELECT DISTINCT
        SalesPersonID AS SalesPersonID_MAX
    FROM Subtotals
    WHERE SubTotal = SubTotalMAX
)
SELECT 
    (SELECT MIN(SalesPersonID_MIN) FROM MinSalesPerson) AS SalesPersonID_MIN,
    (SELECT MIN(SubTotalMIN) FROM Subtotals) AS SubTotalMIN_MIN,
    (SELECT MIN(SalesPersonID_MAX) FROM MaxSalesPerson) AS SalesPersonID_MAX,
    (SELECT MIN(SubTotalMAX) FROM Subtotals) AS SubTotalMAX_MAX;


-- 17 IYUL

-- TASK 1: Person.Person cədvəlindəki bütün sətirləri seçin və yalnız FirstName və LastName sütunlarını göstərin.

SELECT FirstName, LastName
FROM Person.Person;

-- TASK 2: Production.Product cədvəlindən yalnız Name və ProductNumber sütunlarını seçin və ilk 10 nəticəni göstərin.

SELECT TOP 10 Name, ProductNumber
FROM Production.Product;

-- TASK 3: Sales.SalesOrderDetail cədvəlindən UnitPrice və OrderQty sütunlarını seçin, amma nəticələri təkrarlanmayan şəkildə göstərin.

SELECT DISTINCT UnitPrice, OrderQty
FROM Sales.SalesOrderDetail;

-- TASK 4: Person.Address cədvəlindəki bütün sətirləri seçin, lakin yalnız AddressLine1, City və PostalCode sütunlarını göstərin.

SELECT AddressLine1, City, PostalCode
FROM Person.Address;

-- TASK 5: Sales.SalesPerson cədvəlindən TerritoryID və Bonus sütunlarını seçin, lakin yalnız 5 sətir göstərin.

SELECT TOP 5 TerritoryID, Bonus
FROM Sales.SalesPerson;

-- TASK 6: HumanResources.Employee cədvəlindən bütün işçilərin JobTitle sütununu göstərin, amma yalnız təkrarlanmayan nəticələri göstərin.

SELECT DISTINCT JobTitle
FROM HumanResources.Employee;

-- TASK 7: Production.ProductCategory cədvəlindən bütün kateqoriyaların adını (Name) seçin və nəticələri əlifba sırasına görə düzün.

SELECT Name
FROM Production.ProductCategory
ORDER BY Name ASC;

-- TASK 8: Sales.Customer cədvəlindən CustomerID və PersonID sütunlarını seçin, lakin yalnız PersonID null olmayan nəticələri göstərin.

SELECT CustomerID, PersonID
FROM Sales.Customer
WHERE PersonID IS NOT NULL

-- TASK 9: Production.ProductInventory cədvəlindən ProductID və Quantity sütunlarını seçin, lakin yalnız Quantity 500-dən böyük olanları göstərin.

SELECT ProductID, Quantity
FROM Production.ProductInventory
WHERE Quantity > 500;

-- TASK 10: Sales.SalesOrderHeader cədvəlindən SalesOrderID, OrderDate və TotalDue sütunlarını seçin, nəticələri OrderDate sütununa görə azalan sırada düzün.

SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC;

-- 18 IYUL

-- TASK 1: Sales.Customer cədvəlindən CustomerID və TerritoryID sütunlarını seçin, yalnız TerritoryID dəyəri 5-dən böyük olan nəticələri göstərin.

SELECT CustomerID, TerritoryID
FROM Sales.Customer
WHERE TerritoryID > 5;

-- TASK 2: Production.Product cədvəlindən Name və ListPrice sütunlarını seçin, yalnız ListPrice 100 ilə 500 arasında olan məhsulları göstərin.

SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 500;

-- TASK 3: Sales.SalesOrderHeader cədvəlindən SalesOrderID, OrderDate və TotalDue sütunlarını seçin, yalnız OrderDate 2012-ci ilin 1 yanvar tarixindən sonra olan sifarişləri göstərin.

SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
WHERE OrderDate > '2012-01-01'

-- TASK 4: Person.Address cədvəlindən AddressID, City və StateProvinceID sütunlarını seçin, yalnız City dəyəri "Seattle" və ya "New York" olanları göstərin.

SELECT AddressID, City, StateProvinceID
FROM Person.Address
WHERE City IN ('Seattle', 'New York');

-- TASK 5: HumanResources.Employee cədvəlindən BusinessEntityID və HireDate sütunlarını seçin, yalnız 2010-cu ildən sonra işə qəbul edilən işçiləri göstərin.

SELECT BusinessEntityID, HireDate
FROM HumanResources.Employee
WHERE YEAR(HireDate) > 2010;

-- TASK 6: Person.Person cədvəlindən FirstName, LastName və EmailPromotion sütunlarını seçin, yalnız EmailPromotion = 1 olan şəxsləri göstərin.

SELECT FirstName, LastName, EmailPromotion
FROM Person.Person
WHERE EmailPromotion = 1;

-- TASK 7: Production.Product cədvəlindən ProductID, Name və ListPrice sütunlarını seçin, ListPrice 0-dan böyük, lakin 1000-dən kiçik olan məhsulları göstərin.

SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice > 0 AND ListPrice < 1000;

-- TASK 8: HumanResources.Employee cədvəlindən BusinessEntityID və JobTitle sütunlarını seçin, yalnız vəzifəsi "Design Engineer" olanları göstərin.

SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer';

-- TASK 9: Person.Address cədvəlindən AddressID, City və PostalCode sütunlarını seçin, PostalCode 90 ilə başlayan ünvanları göstərin.

SELECT AddressID, City, PostalCode
FROM Person.Address
WHERE PostalCode LIKE '90%';

-- 19 IYUL

-- TASK 1: Sales cədvəlində hər bir müştərinin (CustomerID) ümumi satış miqdarını (TotalAmount) hesabla.
SELECT CustomerID, SUM(TotalDue) AS TotalSales
FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID;

-- TASK 2: Hər bir məhsulun (ProductID) neçə dəfə satıldığını (Quantity) hesablamaq və yalnız 100-dən çox satılan məhsulları göstər.
SELECT ProductID, SUM(OrderQty) AS TotalSold
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 100;


-- TASK 3: Orders cədvəlində hər bir müştərinin neçə sifariş verdiyini tap və yalnız 5-dən çox sifariş vermiş müştəriləri çıxar.
SELECT CustomerID,COUNT(SalesOrderID) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(SalesOrderID)>5

-- TASK 4: Employees cədvəlində şöbələr üzrə ortalama əmək haqqını (Salary) hesabla. Yalnız ortalama maaşı 3000-dən çox olan şöbələri göstər.

-- TASK 5: Products cədvəlində məhsulları CategoryID-yə görə qrupla və hər kateqoriyada ortalama Rating 4-dən yüksək olanları göstər.

-- TASK 6: Orders cədvəlində OrderType (məsələn: online, store, call) üzrə sifarişlərin ümumi sayını hesabla. Sadəcə 50-dən çox sifariş tipi olan növləri göstər.

-- TASK 7: Production.ProductCategory cədvəlindən bütün kateqoriyaların adını (Name) seçin və nəticələri əlifba sırasına görə düzün.
SELECT Name
FROM Production.ProductCategory
ORDER BY NAME ASC;

-- TASK 8: Sales.SalesOrderHeader cədvəlindən SalesOrderID, OrderDate və TotalDue sütunlarını seçin, nəticələri OrderDate sütununa görə azalan sırada düzün.
SELECT SalesOrderID, OrderDate , TotalDue 
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC;


--21 IYUL

-- TASK 1: Aşağıdakı cədvəldən soyadı "R" hərfi ilə başlayan şəxsləri seçmək üçün bir SQL sorğusu yazın.
-- Sorğu nəticəsində lastname və firstname sütunlarını qaytarın və nəticəni firstname sütununa görə artan,
-- lastname sütununa görə azalan sırada göstərin.

SELECT FirstName,LastName
FROM [Person].[Person]
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC, LastName DESC;



-- TASK 2: Aşağıdakı cədvəldən hər bir rəng üçün ListPrice və StandardCost-un cəmini hesablamaq üçün SQL sorğusu yazın.
-- Nəticədə rəngi (color) və ListPrice-ın cəmini qaytarın.
SELECT color,
    SUM(ListPrice) AS TotalListPrice,
    SUM(StandardCost) AS TotalStandardCost
FROM Production.Product
GROUP BY color;



-- TASK 3: -- TASK 4: Aşağıdakı cədvəldən hər bir rəng üçün məhsulların ListPrice və StandardCost-un cəmini qaytarmaq üçün SQL sorğusu yazın.
-- Məhsulun adı "Mountain" ilə başlamalı və ListPrice 0-dan böyük olmalıdır. Nəticədə rəng (Color), ListPrice-un cəmi (Total ListPrice),
-- və StandardCost-un cəmi (Total StandardCost) göstərilsin. Nəticələri rəngə (Color) görə artan sırada düzün.
SELECT color,
    SUM(ListPrice) AS TotalListPrice,
    SUM(StandardCost) AS TotalStandardCost
FROM Production.Product
WHERE Name LIKE 'Mountain%' AND ListPrice > 0
GROUP BY color
ORDER BY color ASC;



-- TASK 4: Hər bir rəng üçün (Color), ListPrice və StandardCost-un toplamını qaytarın. Yalnız ListPrice cəmi,
-- rəngin bütün məhsullarının orta StandardCost dəyərindən böyük olan rəngləri daxil edin. Nəticəni rənglərə görə artan sırada düzün.
SELECT 
    color,
    SUM(ListPrice) AS TotalListPrice,
    SUM(StandardCost) AS TotalStandardCost
FROM Production.Product
GROUP BY color
HAVING SUM(ListPrice) > AVG(StandardCost)
ORDER BY color ASC;

-- TASK 5: Production.Product cədvəlindən, SafetyStockLevel 200-dən az olan və ReorderPoint 50-dən çox olan məhsulları seçin.
-- Nəticələri SafetyStockLevel-ə görə azalan sırada düzün.
SELECT SafetyStockLevel,ReorderPoint
FROM Production.Product
WHERE SafetyStockLevel < 200 AND ReorderPoint > 50
ORDER BY SafetyStockLevel DESC;


-- TASK 6: Hər bir məhsul alt kateqoriyasından (ProductSubcategoryID) orta qiymətdən (ListPrice) daha baha olan məhsulları tapın.
-- Nəticədə aşağıdakı sütunları qaytarın:

-- ProductID
-- Name
-- ListPrice
-- ProductSubcategoryID

SELECT ProductID, Name, ListPrice, ProductSubcategoryID
FROM Production.Product P
WHERE P.ListPrice > (
	SELECT AVG(ListPrice)
	FROM Production.Product
    WHERE ProductSubcategoryID = P.ProductSubcategoryID
	)




-- TASK 7: Satış sifarişlərində (Sales.SalesOrderDetail) iştirak etməyən məhsulları tapın. Nəticədə aşağıdakı sütunları qaytarın:

-- ProductID
-- Name
-- ProductSubcategoryID

ELECT ProductID, Name, ProductSubcategoryID
FROM Production.Product P
WHERE NOT EXISTS (
	SELECT 1
	FROM Sales.SalesOrderDetail SOD
	WHERE SOD.ProductID = P.ProductID
) AND ProductSubcategoryID IS NOT NULL


-- 24 IYUL

-- TASK 1: Aşağıdakı cədvələ əsaslanaraq bir SQL sorğusu yazın ki:
-- ProductSubcategoryID = 37 olan məhsulları nəzərə alsın,
-- həmin alt kateqoriya daxilində ən ucuz (ən aşağı ListPrice dəyərinə malik) məhsulu və ya məhsulları tapıb,
-- nəticədə Name, ListPrice və LeastExpensive adında bir ləqəb (alias) ilə həmin məhsulları göstərsin.

SELECT Name, ListPrice, 'LeastExpensive' AS LeastExpensive
FROM Production.Product
WHERE ProductSubcategoryID = 37 AND ListPrice = (
        SELECT MIN(ListPrice)
        FROM Production.Product
        WHERE ProductSubcategoryID = 37
    );

-- TASK 2: Employee cədvəlində ən yüksək vacationHours dəyərinə malik işçiləri tapın.

SELECT BusinessEntityID, JobTitle, VacationHours
FROM HumanResources.Employee
WHERE VacationHours = (
    SELECT MAX(VacationHours)
    FROM HumanResources.Employee
);


-- TASK 3: Employee cədvəlində hansi işçilərin maaşı orta maaşdan yüksəkdir?

SELECT BusinessEntityID,Rate
FROM HumanResources.EmployeePayHistory
WHERE Rate > (
    SELECT AVG(Rate)
    FROM HumanResources.EmployeePayHistory
);


-- TASK 4: Bütün işçilərdən ibarət cədvəldə müəyyən bir vəzifədə (job title) olan işçilərin sayını tapin.
-- Bu say məlumatını alt sorğu ilə tapıb, əsas sorğuda istifadə edin.

SELECT JobTitle,
    (SELECT COUNT(*)
     FROM HumanResources.Employee e2
     WHERE e2.JobTitle = e1.JobTitle) AS EmployeeCount
FROM HumanResources.Employee e1
WHERE JobTitle = 'Design Engineer'
GROUP BY JobTitle;

--TASK 5: Heç bir sifarişdə iştirak etməyən məhsulları tapın və onların adını və ProductSubcategoryID-ni qaytarın. NULL dəyərləri göstərməyin.
-- Nəticədə aşağıdakı sütunları qaytarın:

-- ProductID
-- Name
-- ProductSubcategoryID

SELECT P.ProductID, P.Name, P.ProductSubcategoryID
FROM Production.Product P
WHERE P.ProductID NOT IN (
		SELECT DISTINCT ProductID
		FROM Sales.SalesOrderDetail
)
AND ProductSubcategoryID IS NOT NULL

-- TASK 6: ProductSubcategoryID-də ən yüksək qiymətə sahib olan məhsulları tapın.
-- Nəticədə ProductSubcategoryID, Name, və ListPrice sütunlarını qaytarın.

SELECT p.ProductSubcategoryID,p.Name,p.ListPrice
FROM Production.Product p
WHERE p.ListPrice= (
	SELECT MAX(pp.ListPrice)
	FROM Production.Product pp
	WHERE p.ProductSubcategoryID=pp.ProductSubcategoryID
)

-- TASK 7: Hər işçinin maaşını və həmin maaşın şirkətdəki ən aşağı maaşla olan fərqini tapın.
-- Qeyd: Minimal maaşı subquery ilə SELECT hissəsində tap.
-- Nəticə: BusinessEntityID, Rate, MinRate, Difference

SELECT e.BusinessEntityID, e.Rate, 
(
   SELECT MIN(Rate)
        FROM HumanResources.EmployeePayHistory     
) AS MinRate,
   e.Rate - (
   SELECT MIN(Rate)
   FROM HumanResources.EmployeePayHistory
 ) AS Difference
FROM HumanResources.EmployeePayHistory e;


-- 25 IYUL --

-- TASK 1: Sales.SalesOrderDetail və Production.Product cədvəllərini birləşdirərək, hər bir məhsulun (ProductID) Name,
-- OrderQty və UnitPrice sütunlarını seçin. Yalnız OrderQty dəyəri 10-dan böyük və UnitPrice 50-dən az olan məhsulları göstərin.
SELECT P.Name, S.OrderQty, S.UnitPrice
FROM Sales.SalesOrderDetail S
JOIN Production.Product P
ON S.ProductID = P.ProductID
WHERE S.OrderQty > 10 AND S.UnitPrice < 50

-- TASK 2: Person.Person və Person.EmailAddress cədvəllərini birləşdirərək, hər bir şəxsin (FirstName, LastName) və e-poçt ünvanını göstərin.
-- Yalnız FirstName "John" və ya LastName "Smith" olan şəxsləri daxil edin.

SELECT P.FirstName, P.LastName, E.EmailAddress
FROM Person.Person P
JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
WHERE P.FirstName = 'John' OR P.LastName = 'Smith';


-- TASK 3: Production.Product cədvəlindən, SafetyStockLevel 200-dən az olan və ReorderPoint 50-dən çox olan məhsulları seçin.
-- Nəticələri SafetyStockLevel-ə görə azalan sırada düzün.
SELECT ProductID, Name, SafetyStockLevel, ReorderPoint
FROM Production.Product
WHERE SafetyStockLevel < 200 AND ReorderPoint > 50
ORDER BY SafetyStockLevel DESC; 

-- TASK 4: HumanResources.Employee və Person.Person cədvəllərini birləşdirərək, işçilərin tam adını (FirstName, LastName) və
-- işə qəbul tarixini (HireDate) göstərin. Yalnız 2012-ci ildən etibarən işə qəbul edilən və JobTitle "Manager" olan işçiləri daxil edin.
SELECT P.FirstName, P.LastName, E.HireDate
FROM HumanResources.Employee E
JOIN Person.Person P
ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.HireDate > '2012-01-01' AND E.JobTitle LIKE '%Manager%'


-- TASK 5: Sales.SalesOrderHeader və Sales.SalesOrderDetail cədvəllərini birləşdirərək, hər bir sifarişin (SalesOrderID) TotalDue,
-- OrderQty və UnitPrice dəyərlərini göstərin. Yalnız TotalDue 1000-dən böyük və OrderQty 5-dən az olan sifarişləri daxil edin.
SELECT h.SalesOrderID, h.TotalDue, d.OrderQty, d.UnitPrice
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
ON h.SalesOrderID = d.SalesOrderID
WHERE h.TotalDue > 1000 AND d.OrderQty < 5;


-- TASK 6: Satış nümayəndələrinin (SalesPerson) satış etdikləri ərazilərin (TerritoryID) adlarını və SalesYTD dəyərlərini göstərin.
-- Yalnız SalesYTD dəyəri həmin əraziyə məxsus bütün nümayəndələrin orta SalesYTD-dən böyük olan nümayəndələri daxil edin.
-- Ərazilərin adlarını əlifba sırasına görə düzün.
SELECT SP.TerritoryID, ST.Name, SP.SalesYTD
FROM Sales.SalesPerson SP
JOIN Sales.SalesTerritory ST
ON SP.TerritoryID=ST.TerritoryID
WHERE SP.SalesYTD>(
	SELECT AVG(SSP.SalesYTD)
	FROM Sales.SalesPerson SSP
	WHERE SP.TerritoryID=SSP.TerritoryID
) 
ORDER BY ST.Name

 --TASK 7: Sales.SalesOrderHeader və Sales.SalesOrderDetail cədvəllərini birləşdirərək
-- hər bir sifarişin (SalesOrderID) ümumi satış məbləğini (TotalDue) və sifarişdəki məhsulların ümumi sayını (OrderQty)
-- hesablayın. Yalnız ümumi satış məbləği 10,000-dən böyük olan sifarişləri göstərin.
-- Nəticəni TotalDue-a görə azalan sırada düzün. (INNER JOIN)
SELECT SH.SalesOrderID, Sum(SH.TotalDue) TD, Sum(SD.OrderQty) OQ 
FROM Sales.SalesOrderHeader SH
JOIN Sales.SalesOrderDetail SD
ON SH.SalesOrderID=SD.SalesOrderID
Group BY SH.SalesOrderID
HAVING Sum(TotalDue)>10000
ORDER BY Sum(TotalDue) DESC

-- TASK 8: Person.Person və HumanResources.Employee cədvəllərini birləşdirərək hər bir şəxsin tam adını
-- (FirstName, LastName) və işə qəbul tarixini (HireDate) göstərin. İşçi olmayan şəxsləri də daxil edin.
-- Nəticələri işçilərin işə qəbul tarixinə görə artan sırada düzün. (LEFT JOIN)

SELECT P.FirstName,p.LastName,h.HireDate
FROM Person.Person AS p
LEFT JOIN HumanResources.Employee AS h
ON p.BusinessEntityID=h.BusinessEntityID
ORDER BY H.HireDate ;

-- TASK 9: Sales.SalesTerritory və Sales.SalesPerson cədvəllərini birləşdirərək hər bir ərazi adını (Name) və
-- əraziyə təyin edilmiş nümayəndələrin (BusinessEntityID) satış hədəf tarixçəsini (SalesQuotaHistory) göstərin.
-- Əraziyə nümayəndə təyin edilməyən əraziləri də daxil edin. Nəticələri ərazi adlarına görə əlifba sırasına görə düzün.
-- (RIGHT JOIN)

SELECT t.NAME,SP.BusinessEntityID,SP.SalesQuota
FROM  Sales.SalesTerritory t
RIGHT JOIN  Sales.SalesPerson SP
ON t.TerritoryID=SP.TerritoryID
ORDER BY t.NAME ASC

-- TASK 10: Sales.SalesPerson cədvəlindən hər bir satış nümayəndəsinin (BusinessEntityID) ərazisi (TerritoryID) üzrə satış məbləğini
-- (SalesYTD) göstərin. Nəticədə yalnız satış məbləği həmin ərazi üzrə bütün nümayəndələrin orta satış məbləğindən (AVG(SalesYTD))
-- böyük olan nümayəndələri daxil edin. Subquery istifadə edərək bu nəticəni hesablayın.
-- Nəticəni TerritoryID-ə görə artan sırada düzün.

SELECT sp.BusinessEntityID, sp.TerritoryID, sp.SalesYTD
FROM Sales.SalesPerson sp
JOIN (
	SELECT TerritoryID, AVG(SalesYTD) AS AvgSales
	FROM Sales.SalesPerson
	GROUP BY TerritoryID
) AS t
ON t.TerritoryID = sp.TerritoryID
WHERE sp.SalesYTD > t.AvgSales
ORDER BY sp.TerritoryID ASC;


-- 28 IYUL --


-- TASK 1: HumanResources.Employee cədvəlində hər bir departament üzrə ən yüksək maaş alan işçiləri tapın.
-- Nəticədə BusinessEntityID, JobTitle, DepartmentID, Rate və MaxRate sütunlarını qaytarın.
-- Yalnız Rate departament üzrə ən yüksək məbləğə bərabər olan işçiləri göstərin.
   
WITH MaxRates AS (
    SELECT edh.DepartmentID,MAX(eph.Rate) AS MaxRate
    FROM HumanResources.EmployeeDepartmentHistory edh
    JOIN HumanResources.EmployeePayHistory eph 
    ON edh.BusinessEntityID = eph.BusinessEntityID
    WHERE edh.EndDate IS NULL
    GROUP BY edh.DepartmentID
)
SELECT 
    eph.BusinessEntityID,
    e.JobTitle,
    edh.DepartmentID,
    eph.Rate,
    mr.MaxRate
FROM HumanResources.Employee e
JOIN HumanResources.EmployeeDepartmentHistory edh 
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.EmployeePayHistory eph 
    ON e.BusinessEntityID = eph.BusinessEntityID
JOIN MaxRates mr 
    ON edh.DepartmentID = mr.DepartmentID
WHERE edh.EndDate IS NULL
  AND eph.Rate = mr.MaxRate;




-- TASK 2: Hər bir departamentin işçilərinin sayını hesablayın və bütün departamentlər üzrə maksimum işçi sayı olan
-- departamenti tapın. Nəticədə DepartmentID, DepartmentName, və EmployeeCount qaytarın.
 
WITH Departmentcounts AS (
    SELECT edh.DepartmentID,d.Name AS DepartmentName,COUNT(BusinessEntityID) AS EmployeeCount
    FROM HumanResources.EmployeeDepartmentHistory edh
    JOIN HumanResources.Department d 
    ON edh.DepartmentID = d.DepartmentID
    WHERE edh.EndDate IS NULL
    GROUP BY edh.DepartmentID, d.Name
),
MaxDept AS (
    SELECT MAX(EmployeeCount) AS MaxCount
    FROM DepartmentCounts
)

SELECT 
    dc.DepartmentID,
    dc.DepartmentName,
    dc.EmployeeCount
FROM DepartmentCounts dc
JOIN MaxDept md 
    ON dc.EmployeeCount = md.MaxCount;




-- TASK 3: Satış sifarişlərində iştirak edən işçilərin siyahısını qaytarın, lakin alış sifarişlərində iştirak edənləri istisna edin.

SELECT SalesPersonID 
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
EXCEPT
SELECT EmployeeID
FROM Purchasing.PurchaseOrderHeader
WHERE EmployeeID IS NOT NULL


-- TASK 4: İki fərqli cədvəldən (SalesOrderHeader və PurchaseOrderHeader) satış sifarişlərinin və
-- alış sifarişlərinin hansı şəxs tərəfindən işlənildiyini tapın.

SELECT SalesPersonID 
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
UNION 
SELECT EmployeeID
FROM Purchasing.PurchaseOrderHeader
WHERE EmployeeID IS NOT NULL




-- TASK 5: Hər bir departamentdəki işçilərin sayını hesablayın və ən çox işçisi olan departamenti tapın. Nəticədə aşağıdakı sütunları qaytarın:

-- DepartmentID
-- DepartmentName
-- EmployeeCount


-- TASK 6: Hər bir ərazidə (TerritoryID) orta satışdan daha çox satış edən nümayəndələri tapın. Nəticədə aşağıdakı sütunları qaytarın:

-- TerritoryID
-- BusinessEntityID
-- SalesYTD

WITH TerritoryAvg AS (
    SELECT TerritoryID, AVG(SalesYTD) AS AvgSales
    FROM Sales.SalesPerson
    WHERE TerritoryID IS NOT NULL
    GROUP BY TerritoryID
)
SELECT sp.TerritoryID, sp.BusinessEntityID, sp.SalesYTD
FROM Sales.SalesPerson sp
JOIN TerritoryAvg ta ON sp.TerritoryID = ta.TerritoryID
WHERE sp.SalesYTD > ta.AvgSales;


-- TASK 7: Sales.SalesPerson cədvəlindən hər bir satış nümayəndəsinin (BusinessEntityID) ərazisi (TerritoryID) üzrə satış məbləğini
-- (SalesYTD) göstərin. Nəticədə yalnız satış məbləği həmin ərazi üzrə bütün nümayəndələrin orta satış məbləğindən (AVG(SalesYTD))
-- böyük olan nümayəndələri daxil edin. Subquery istifadə edərək bu nəticəni hesablayın.
-- Nəticəni TerritoryID-ə görə artan sırada düzün.
SELECT BusinessEntityID, TerritoryID, SalesYTD
FROM Sales.SalesPerson sp
WHERE SalesYTD > (
    SELECT AVG(SalesYTD)
    FROM Sales.SalesPerson
    WHERE TerritoryID = sp.TerritoryID
);



-- TASK 8: TASK 7-i CTE istifadə edərək yazın.

WITH AvgSales AS (
    SELECT TerritoryID, AVG(SalesYTD) AS AvgYTD
    FROM Sales.SalesPerson
    GROUP BY TerritoryID
)
SELECT sp.BusinessEntityID, sp.TerritoryID, sp.SalesYTD
FROM Sales.SalesPerson sp
JOIN AvgSales a ON sp.TerritoryID = a.TerritoryID
WHERE sp.SalesYTD > a.AvgYTD;



-- TASK 9:CTE istifadə edərək hər bir ərazi üzrə ortalama SalesYTD tap, sonra həmin ortalamadan yüksək satış edən işçiləri göstər.
-- Nəticə sütunları: TerritoryID, BusinessEntityID, SalesYTD.


-- TASK 10: Person.Person, HumanResources.Employee, HumanResources.Department, HumanResources.EmployeeDepartmentHistory
-- cədvəllərindən istifadə edərək elə bir sorğusu yazın ki, adları "P" hərfi ilə başlayan departamentlərə aid olmayan
-- bütün işçiləri tapsın.

SELECT 
    p.BusinessEntityID,
    p.FirstName,
    p.LastName,
    d.Name AS DepartmentName
FROM Person.Person p
JOIN HumanResources.Employee e
    ON p.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d
    ON edh.DepartmentID = d.DepartmentID
WHERE d.Name NOT LIKE 'P%'
  AND edh.EndDate IS NULL; -- Hal-hazırda işləyənlər



  -- 29 IYUL 

  -- TASK 1: Aşağıdakı cədvələ əsasən SQL sorğusu yazın ki, 3 və 4 arasında olan LocationID dəyərlərinə görə anbarda (inventory) olan məhsulları onların miqdarına (Quantity) əsaslanaraq sıralasın (rank etsin). 
  -- Nəticə LocationID üzrə qruplara bölünməli və Quantity sütununa görə azalan sıra ilə sıralanmalıdır.

  SELECT 
    LocationID,
    ProductID,
    Quantity,
    RANK() OVER (PARTITION BY LocationID ORDER BY Quantity DESC) AS ProductRank
FROM 
    Production.ProductInventory
WHERE 
    LocationID BETWEEN 3 AND 4
ORDER BY 
    LocationID ASC,
    Quantity DESC;

-- TASK 2: Hər ərazidə ən çox satış edən 3 nümayəndəni tapın. Nəticədə aşağıdakı sütunları qaytarın:

-- TerritoryID
-- BusinessEntityID
-- SalesYTD
-- Rank
WITH RankedSales AS (
	SELECT TerritoryID, BusinessEntityID, SalesYTD,
		RANK() OVER (PARTITION BY TerritoryID ORDER BY SalesYTD DESC) AS Rank
	FROM Sales.SalesPerson
)
SELECT TerritoryID, BusinessEntityID, SalesYTD, Rank
FROM RankedSales
WHERE Rank <= 3 
ORDER BY TerritoryID, Rank

-- TASK 3: Ən çox qazanc əldə edən 5 işçini tapın və həmin işçilərin işlədiyi departamentləri göstərin.
-- Nəticədə aşağıdakı sütunları qaytarın:

-- BusinessEntityID
-- TotalEarnings: İşçinin ümumi qazancı
-- DepartmentID

SELECT TOP 5
    eph.BusinessEntityID,
    SUM(Rate) AS TotalEarnings,
    edh.DepartmentID
FROM
   HumanResources.EmployeePayHistory eph
JOIN
     HumanResources.EmployeeDepartmentHistory edh ON eph.BusinessEntityID = edh.BusinessEntityID
WHERE
    edh.EndDate IS NULL  -- İndiki departament
GROUP BY
    eph.BusinessEntityID,
    edh.DepartmentID
ORDER BY
    TotalEarnings DESC;



	
-- TASK 4: Hər bir işçinin maaşını və həmin maaşın departament üzrə orta maaşa olan nisbətini tapın.
-- Nəticədə BusinessEntityID, Rate, AvgRate, və Ratio sütunlarını qaytarın

WITH DeptAvg AS (
    SELECT
        d.DepartmentID,
        AVG(p.Rate) AS AvgRate
    FROM
       HumanResources.EmployeeDepartmentHistory d
    JOIN
        HumanResources.EmployeePayHistory p ON d.BusinessEntityID = p.BusinessEntityID
    GROUP BY
        d.DepartmentID
)

SELECT
    d.BusinessEntityID,
    p.Rate,
    avg.AvgRate,
    CAST(p.Rate AS FLOAT) / NULLIF(avg.AvgRate, 0) AS Ratio
FROM
     HumanResources.EmployeeDepartmentHistory d
JOIN
    HumanResources.EmployeePayHistory p ON d.BusinessEntityID = p.BusinessEntityID
JOIN
    DeptAvg avg ON avg.DepartmentID = d.DepartmentID;


-- TASK 5: Hər bir məhsulun qiymətini və həmin qiymətin məhsul kateqoriyası üzrə minimum və maksimum qiymətə olan
-- nisbətini hesablayın. Nəticədə Name, ListPrice, MinPrice, MaxPrice, və PriceRatio qaytarın.

WITH CategoryPriceStats AS (
    SELECT 
        ps.ProductCategoryID,
        MIN(p.ListPrice) AS MinPrice,
        MAX(p.ListPrice) AS MaxPrice
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps 
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    GROUP BY ps.ProductCategoryID
)

SELECT 
    p.Name,
    p.ListPrice,
    cps.MinPrice,
    cps.MaxPrice,
    ROUND(
        CAST(p.ListPrice AS FLOAT) / NULLIF(cps.MaxPrice, 0), 2
    ) AS PriceRatio
FROM Production.Product p
JOIN Production.ProductSubcategory ps 
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN CategoryPriceStats cps 
    ON ps.ProductCategoryID = cps.ProductCategoryID

-- TASK 6: Elə SQL sorğusu yazın ki, hər iş vəzifəsi üzrə ən yüksək saatlıq maaşı qaytarsın. Yalnız aşağıdakı şərtlərə uyğun iş vəzifələrini daxil etsin:

 -- Kişilər tərəfindən tutulan və ən yüksək maaşı 40 dollardan çox olanlar,
 -- Və ya qadınlar tərəfindən tutulan və ən yüksək maaşı 42 dollardan çox olanlar.
 -- Əlavə izah : Kişilər və qadınlar üçün ayrıca ən yüksək maaş tapılır, sonra həmin maaş şərtlərə görə filtr olunur, ən sonda hər iş vəzifəsinin ən yüksək maaşı göstərilir.

WITH MaxRates AS (
    SELECT 
        e.JobTitle,
        e.Gender,
        MAX(ep.Rate) AS MaxRate
    FROM HumanResources.Employee e
    JOIN HumanResources.EmployeePayHistory ep
        ON e.BusinessEntityID = ep.BusinessEntityID
    GROUP BY e.JobTitle, e.Gender
),
FilteredMaxRates AS (
    SELECT *
    FROM MaxRates
    WHERE 
        (Gender = 'M' AND MaxRate > 40)
        OR
        (Gender = 'F' AND MaxRate > 42)
)

SELECT 
    JobTitle,
    MAX(MaxRate) AS HighestRate
FROM FilteredMaxRates
GROUP BY JobTitle


 -- TASK 7: Hər bir məhsulun qiymətini (ListPrice) aşağıdakı kriteriyalara əsasən təsnifləşdirin:

-- Əgər məhsulun qiyməti 1000-dən çoxdursa, o zaman "Premium" adlandırın.
-- Əgər məhsulun qiyməti 500 ilə 1000 arasındadırsa, o zaman "Expensive" adlandırın.
-- Əgər məhsulun qiyməti 500-dən azdırsa, o zaman "Cheap" adlandırın.
-- Qaytarılacaq sütunlar:

-- ProductID
-- Name
-- ListPrice
-- PriceCategory (Premium, Expensive, Cheap)


SELECT ProductID, Name, ListPrice,
		CASE
			WHEN ListPrice > 1000 THEN 'Premium'
			WHEN ListPrice BETWEEN 500 AND 1000 THEN 'Expensive'
			ELSE 'CHEAP'
		END AS PriceCategory
FROM Production.Product
ORDER BY ListPrice DESC;


-- 1 AVQUST

-- TASK 1: Elə SQL sorğusu yazın ki, satış kvotası 250,000 dollardan çox olan işçilərin SalesPerson ID-lərini müəyyən edin. 


-- TASK 2: Aşağıdakı cədvəllərdən SQL sorğusu yazın ki, SalesOrderID dəyərlərini əldə etsin.
-- Əgər hər hansı TerritoryID üçün sifariş yoxdursa, SalesOrderID NULL qaytarılsın.
-- Nəticədə aşağıdakı sütunlar göstərilməlidir:
-- TerritoryID,
-- CountryRegionCode,
-- SalesOrderID.


-- TASK 3: Hər bir satış nümayəndəsinin (SalesPerson) ümumi satış məbləğini və həmin nümayəndənin
-- region üzrə sıralanmasını hesablayın. Nəticədə BusinessEntityID, TerritoryID, SalesYTD, və Rank qaytarın.


-- TASK 4: Aşağıdakı cədvəldən SQL sorğusu yazın ki, aşağıdakılar əldə olunsun:

-- RateChangeDate (maaş dərəcəsinin dəyişmə tarixi) – tarix formatında göstərilməlidir,
-- Tam ad (adı, ortaq adı və soyadı birlikdə),
-- Həftəlik maaş (40 saatlıq iş həftəsinə əsasən hesablanır).
-- Nəticə tam ada görə artan sırada (ascending order) sıralanmalıdır.


-- TASK 5: Elə SQL sorğusu yazın ki:

-- Hər bir departament üçün aşağıdakı toplu statistikaları (aggregated values) qaytarsın:
-- Departamentin adı (name)
-- Ən aşağı maaş (minimum salary)
-- Ən yüksək maaş (maximum salary)
-- Orta maaş (average salary)
-- İşçilərin sayı (number of employees)