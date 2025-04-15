USE master 
GO

DROP DATABASE IF EXISTS PizzaOrderingAppDB
GO

CREATE DATABASE PizzaOrderingAppDB
GO

USE PizzaOrderingAppDB 
GO

-- 1. First create all tables without foreign key dependencies
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
    Address NVARCHAR(255),
    Phone NVARCHAR(20) -- Changed from INT to NVARCHAR for phone numbers
);
GO

CREATE TABLE PizzaSizes (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    DiameterCM INT NOT NULL,
    BasePrice DECIMAL(5,2) NOT NULL
);
GO

CREATE TABLE Toppings (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Price DECIMAL(4,2) NOT NULL
);
GO

-- 2. Now create tables with foreign key dependencies
CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Price DECIMAL(10,2) NOT NULL,
    IsDelivered BIT NOT NULL,
    UserId INT NOT NULL
);
GO

CREATE TABLE Pizzas (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    SizeId INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    OrderId INT NOT NULL
);
GO

CREATE TABLE PizzaToppings (
    Id INT PRIMARY KEY IDENTITY(1,1),
    PizzaId INT NOT NULL,
    ToppingId INT NOT NULL,
    CONSTRAINT UQ_PizzaTopping UNIQUE (PizzaId, ToppingId) -- Ensures unique combinations
);
GO

-- 3. Add all foreign key constraints after tables exist
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Users FOREIGN KEY (UserId) REFERENCES Users(Id);
GO

ALTER TABLE Pizzas
ADD CONSTRAINT FK_Pizzas_Orders FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    CONSTRAINT FK_Pizzas_Sizes FOREIGN KEY (SizeId) REFERENCES PizzaSizes(Id);
GO

ALTER TABLE PizzaToppings
ADD CONSTRAINT FK_PizzaToppings_Pizzas FOREIGN KEY (PizzaId) REFERENCES Pizzas(Id),
    CONSTRAINT FK_PizzaToppings_Toppings FOREIGN KEY (ToppingId) REFERENCES Toppings(Id);
GO

-- Insert sample data
INSERT INTO Users (FirstName, LastName, Address, Phone)
VALUES 
('Bob', 'Bobsky', 'Bob Street 22', '070111222'),
('Jill', 'Wayne', 'Jill Street 22', '070222333'),
('Greg', 'Gregsky', 'Greg Street 22', '070333444');
GO

INSERT INTO PizzaSizes (Name, DiameterCM, BasePrice)
VALUES 
('Small', 25, 5.00),
('Medium', 30, 7.00),
('Large', 35, 9.00),
('Family', 40, 12.00);
GO

INSERT INTO Toppings (Name, Price)
VALUES 
('Cheese', 0.40),
('Mushrooms', 0.80),
('Bacon', 1.00),
('Onions', 0.20),
('Garlic', 0.30);
GO

INSERT INTO Orders (Price, IsDelivered, UserId)
VALUES 
(8.50, 1, 1),
(7.20, 1, 1),
(15.70, 0, 1),
(3.00, 0, 2),
(16.40, 1, 3);
GO

INSERT INTO Pizzas (Name, SizeId, Price, OrderId)
VALUES 
('Capricciosa', 1, 6.50, 1),
('Pepperoni', 3, 9.70, 1),
('Margarita', 1, 5.60, 2),
('Seafood', 2, 8.90, 2),
('Hawaiian', 2, 8.70, 2),
('Capricciosa', 2, 7.50, 3),
('Pepperoni', 4, 12.80, 3),
('Capricciosa', 3, 9.20, 3),
('Hawaiian', 4, 13.20, 3),
('Capricciosa', 3, 9.00, 4),
('Margarita', 4, 12.00, 5),
('Seafood', 3, 12.50, 5),
('Pepperoni', 3, 12.20, 5),
('Capricciosa', 4, 11.70, 5);
GO

INSERT INTO PizzaToppings (PizzaId, ToppingId)
VALUES 
(1, 1), (1, 3), 
(2, 1), 
(4, 3), (4, 5), 
(6, 1), 
(7, 1), 
(9, 2), 
(10, 4), 
(11, 1), (11, 5), 
(12, 4), 
(14, 1), (14, 2);
GO

USE PizzaOrderingAppDB;
GO

SELECT * FROM INFORMATION_SCHEMA.TABLES 
SELECT * FROM Users
SELECT * FROM PizzaSizes
SELECT * FROM Toppings
SELECT * FROM Orders
SELECT * FROM Pizzas
SELECT * FROM PizzaToppings

