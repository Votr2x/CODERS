------Sub queries in From Clause--------

SELECT t.Color, count(ProductID) AS Cnt
FROM (
	SELECT prd.ProductID, prd.Name, prd.color
		FROM Production.Product Prd
		LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
			 ON Prd.ProductID = SlsOrdDtl.ProductID 
		LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
			 ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
) AS t
GROUP BY color
HAVING Color IS NOT NULL
ORDER BY Cnt DESC

SELECT *
FROM (
	SELECT Color,count(ProductDescriptionID) AS Cnt
	FROM (
		SELECT prd.ProductID,
			prdm.ProductModelID,
			prddesc.ProductDescriptionID,
			prddesc.Description,
			CatalogDescription,
			prd.Color,
			prdsubc.Name AS SubCatName,
			prdm.Name AS ModelName
		FROM Production.Product prd
		JOIN Production.ProductModel prdm 
			ON prd.ProductModelID=prdm.ProductModelID
		JOIN Production.ProductSubcategory prdsubc 
			ON prd.ProductSubcategoryID = prdsubc.ProductSubcategoryID
		JOIN Production.ProductCategory prdc 
			ON prdc.ProductCategoryID=prdsubc.ProductCategoryID
		JOIN Production.ProductModelProductDescriptionCulture prdmprddesccul
			ON prdmprddesccul.ProductModelID = prdm.ProductModelID
		JOIN Production.ProductDescription prddesc
			ON prddesc.ProductDescriptionID=prdmprddesccul.ProductDescriptionID
	) t
	--WHERE Color='Multi'
	GROUP BY Color
) tt
WHERE Color = 'Silver'
ORDER BY Cnt DESC
;

SELECT *
FROM(
	SELECT color, count(ProductID) AS Cnt
	FROM (
		SELECT prd.ProductID,prd.Name,prd.color
		FROM Production.Product Prd
		LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
			 ON Prd.ProductID = SlsOrdDtl.ProductID 
		LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
			 ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
		--WHERE Prd.Color='Black'

		UNION

		SELECT prd.ProductID,prd.Name,prd.color
		FROM Production.Product Prd
		LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
			 ON Prd.ProductID = SlsOrdDtl.ProductID
		LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
			 ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
		--WHERE Prd.Color='Silver'
	) AS T
	GROUP BY color
) AS TT
WHERE Color IN ('Yellow','Red')
ORDER BY Color DESC

--CTE(Common Table Expression)

WITH sales_product AS ( 
	SELECT prd.ProductID,prd.Name,prd.color,SlsOrdDtl.LineTotal
			FROM Production.Product Prd
			LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
				 ON Prd.ProductID = SlsOrdDtl.ProductID 
			LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr
				 ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
			WHERE Prd.Color='Black'
			UNION
			SELECT prd.ProductID,prd.Name,prd.color,SlsOrdDtl.LineTotal
			FROM Production.Product Prd
			LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
				 ON Prd.ProductID = SlsOrdDtl.ProductID
			LEFT JOIN Sales.SalesOrderHeader SlsOrdHdr 
				 ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
			WHERE Prd.Color='Silver'
),
product AS (
	SELECT prd.ProductID,prd.Name,prd.color,prd.ListPrice
		FROM Production.Product Prd
		WHERE ListPrice > 1000
)
SELECT sprd.*,prd.ListPrice
FROM sales_product sprd
JOIN product prd ON sprd.ProductID=prd.ProductID;

SELECT *
FROM Person.Person;

WITH SalesPersonINFO AS (
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
,customerInfo AS (
SELECT
    c.CustomerID AS Customer_ID
    ,p.[BusinessEntityID]
    ,p.[Title]
    ,p.[FirstName]
    ,p.[MiddleName]
    ,p.[LastName]
    ,p.[Suffix]
    ,pp.[PhoneNumber]
	,pnt.[Name] AS [PhoneNumberType]
    ,ea.[EmailAddress]
    ,p.[EmailPromotion]
    ,a.[AddressLine1]
    ,a.[AddressLine2]
    ,a.[City]
    ,[StateProvinceName] = sp.[Name]
    ,a.[PostalCode]
    ,[CountryRegionName] = cr.[Name]
FROM [Sales].Customer c
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = c.[PersonID]
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = p.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    LEFT OUTER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    LEFT OUTER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
	LEFT OUTER JOIN [Person].[EmailAddress] ea
	ON ea.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PersonPhone] pp
	ON pp.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
	ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID]

)
,productInfo AS (
SELECT
     p.[ProductID] AS Product_ID
	,p.[Name] AS ProductName
	,p.[ProductNumber]
	,p.[MakeFlag]
	,p.[FinishedGoodsFlag]
	,p.[Color]
	,p.[SafetyStockLevel] AS MinInventoryQuantity
	,p.[StandardCost]
	,p.[ListPrice] AS SellingPrice
	,p.[Size] AS ProductSize
	,um.[Name] AS ProductMeasureSizeName
	,p.[Weight] AS ProductWeight
	,um1.[Name] AS ProductMeasureWeightName
	,p.[DaysToManufacture]
    ,p.[ProductLine]
	,p.[Class]
	,p.[Style]
	,p.[ProductSubcategoryID]
	,psc.[Name] AS SubCategoryName
	,pc.[Name] AS CategoryName
	,p.[ProductModelID]
	,pm.[Name] AS ModelName
	,pm.[CatalogDescription]
	,pm.[Instructions]
	,p.SellStartDate
	,p.SellEndDate
	,l.[LocationID] AS InventoryLocationID
	,l.[Name] AS InventoryLocationName
	,ppp.[ProductPhotoID]
	,pp.[LargePhotoFileName]
FROM [Production].[Product] p
	INNER JOIN [Production].[ProductModel] pm 
	ON p.ProductModelID=pm.ProductModelID
	LEFT OUTER JOIN [Production].[ProductSubcategory] psc 
	ON psc.ProductSubcategoryID=p.ProductSubcategoryID
	LEFT OUTER JOIN [Production].[ProductCategory] pc 
	ON psc.ProductCategoryID=pc.ProductCategoryID
	LEFT OUTER JOIN [Production].[UnitMeasure] um 
	ON um.UnitMeasureCode=p.SizeUnitMeasureCode
	LEFT OUTER JOIN [Production].[UnitMeasure] um1 
	ON um1.UnitMeasureCode=p.WeightUnitMeasureCode
	LEFT OUTER JOIN [Production].[ProductInventory] pi 
	ON pi.ProductID=p.ProductID
	LEFT OUTER JOIN [Production].[Location] l 
	ON l.LocationID=pi.LocationID
	LEFT OUTER JOIN [Production].[ProductProductPhoto] ppp 
	ON ppp.ProductID=p.ProductID
	LEFT OUTER JOIN [Production].[ProductPhoto] pp 
	ON pp.ProductPhotoID=ppp.ProductPhotoID
)

--SELECT CONCAT_WS(' ',FirstName,MiddleName,LastName) AS FullName,
--	   ProductName,
--	   Color,
--       COUNT(ProductID) AS Cnt
--	FROM (
--		SELECT SlsOrdHdr.*,SlsOrdDtl.ProductID,spi.*,pinfo.*
--		FROM Sales.SalesOrderHeader SlsOrdHdr
--			JOIN Sales.SalesOrderDetail SlsOrdDtl
--			ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
--			JOIN SalesPersonINFO spi 
--			ON spi.[BusinessEntityID]=SlsOrdHdr.SalesPersonID
--			JOIN productInfo pinfo
--			ON pinfo.Product_ID=SlsOrdDtl.ProductID
--	) t
--WHERE FirstName + MiddleName + LastName IS NOT NULL
--GROUP BY CONCAT_WS(' ',FirstName,MiddleName,LastName), ProductName, Color
--HAVING Color IS NOT NULL
--ORDER BY FullName, ProductName, Color Desc


--SELECT CountryRegionName,
--	CONCAT_WS(' ',FirstName,MiddleName,LastName) AS FullName,
--	AVG(TotalDue) AvgTotalDue
--FROM(
--	SELECT SlsOrdHdr.*,custinfo.*
--		FROM Sales.SalesOrderHeader SlsOrdHdr
--		LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
--			ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
--		LEFT JOIN customerInfo custinfo ON SlsOrdHdr.CustomerID=custinfo.Customer_ID
--	) t
--WHERE CountryRegionName='Germany'
--GROUP BY CountryRegionName,CONCAT_WS(' ',FirstName,MiddleName,LastName)


--SELECT CountryRegionName,
--	   City,
--	   CONCAT_WS(' ',FirstName,MiddleName,LastName) AS FullName,
--	   ROUND(SUM(TotalDue),2) AS SumTotalDue
--	   --count(distinct CustomerID) AS Cnt
--FROM(
--	SELECT SlsOrdHdr.*,c.*
--		FROM Sales.SalesOrderHeader SlsOrdHdr
--		LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
--			ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
--		LEFT JOIN customerInfo c ON SlsOrdHdr.CustomerID=c.Customer_ID
--	) t
--WHERE CountryRegionName='France' AND City='Paris'
--GROUP BY CountryRegionName,City, CONCAT_WS(' ',FirstName,MiddleName,LastName)

SELECT CountryRegionName,JobTitle, SUM(TotalSalesSumValue) TotalSalesSumValue
	FROM(
	SELECT FullName,JobTitle,CountryRegionName,StateProvinceName, COUNT(SalesOrderID) AS SalesCnt, SUM(TotalDue) TotalSalesSumValue
	FROM(
		SELECT *, CONCAT_WS(' ',FirstName,MiddleName,LastName) AS FullName
			FROM (
				SELECT SlsOrdHdr.*,spi.*
				FROM Sales.SalesOrderHeader SlsOrdHdr
					LEFT JOIN Sales.SalesOrderDetail SlsOrdDtl
					ON SlsOrdHdr.SalesOrderID=SlsOrdDtl.SalesOrderID
					LEFT JOIN SalesPersonINFO spi 
					ON spi.[BusinessEntityID]=SlsOrdHdr.SalesPersonID
			) t
		) tt
	GROUP BY FullName,JobTitle,CountryRegionName,StateProvinceName
	--ORDER BY FullName DESC,CountryRegionName
) ttt
GROUP BY CountryRegionName,JobTitle
ORDER BY CountryRegionName DESC,JobTitle


