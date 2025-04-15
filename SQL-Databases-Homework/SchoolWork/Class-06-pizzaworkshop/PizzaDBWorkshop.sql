SELECT * FROM INFORMATION_SCHEMA.TABLES 
SELECT * FROM Users
SELECT * FROM PizzaSizes
SELECT * FROM Toppings
SELECT * FROM Orders
SELECT * FROM Pizzas
SELECT * FROM PizzaToppings

CREATE FUNCTION dbo.ConcatenateNames
(
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100)
)
RETURNS NVARCHAR(201) -- 100+100+1 for space
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName;
END;
GO
--Fullname concat
SELECT dbo.ConcatenateNames(FirstName, LastName) AS FullName 
FROM Users;
--View showing all undelivered
CREATE OR ALTER VIEW [vv_ShowAllUndeliveredPizzas] AS
WITH PizzaDetails AS (
    SELECT
        p.Id AS PizzaId,
        p.OrderId,
        p.Name AS PizzaName,
        ps.Name AS Size,
        p.Price,
        STRING_AGG(t.Name, ', ') WITHIN GROUP (ORDER BY t.Name) AS Toppings
    FROM 
        Pizzas p
    JOIN 
        PizzaSizes ps ON p.SizeId = ps.Id
    LEFT JOIN 
        PizzaToppings pt ON p.Id = pt.PizzaId
    LEFT JOIN 
        Toppings t ON pt.ToppingId = t.Id
    GROUP BY
        p.Id, p.OrderId, p.Name, ps.Name, p.Price
)
SELECT 
    u.FirstName + ' ' + u.LastName AS CustomerName,
    u.Phone,
    ord.Id AS OrderId,
    'Not Delivered' AS DeliveryStatus,
    pd.PizzaName,
    pd.Size,
    pd.Price AS PizzaPrice,
    pd.Toppings
FROM 
    Orders ord
JOIN 
    Users u ON ord.UserId = u.Id
JOIN 
    PizzaDetails pd ON ord.Id = pd.OrderId
WHERE 
    ord.IsDelivered = 0;

SELECT * FROM vv_ShowAllUndeliveredPizzas	

--Procedure that when provided an order ID can return the full 
--price of a whole order delivery all pizza and all toppings

CREATE PROCEDURE [CalculateTotalPrice]
AS
  SELECT * FROM Orders
  WHERE  IS NULL

EXECUTE dbo.[Students Without Group];

CREATE PROCEDURE [Students Per Group]
AS
  SELECT GroupId, COUNT(*) as Students
  FROM Students
  GROUP BY GroupId
  HAVING GroupId IS NOT NULL
  ORDER BY Students;

EXECUTE dbo.[Students Per Group];

