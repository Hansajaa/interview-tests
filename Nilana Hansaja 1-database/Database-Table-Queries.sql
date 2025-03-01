CREATE DATABASE savinda; -- Create database

USE savinda; -- And use that perticular database

-- Creating a Product Table
CREATE TABLE Products(
	ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    ProductDescription VARCHAR(255) NOT NULL,
    Category VARCHAR(25) NOT NULL,
    Image VARCHAR(255) NOT NULL,
    ProductStatus VARCHAR(25) NOT NULL,
    CreatedBy VARCHAR(100) NOT NULL,
    CreatedAt DATETIME DEFAULT current_timestamp
);

-- Sample Relevent data insert query for Product Table
INSERT INTO savinda.products (ProductName, ProductDescription, Category, Image, ProductStatus, CreatedBy) VALUES ("Product 1", "This is a product 1", "Category 1", "https://via.placeholder.com/150", "active", "admin");



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Creating a Tags Table
CREATE TABLE Tags(
	TagID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    TagValue VARCHAR(50) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Sample Relevent data insert queries for Tags Table
INSERT INTO savinda.tags (ProductID, TagValue) VALUES (1, "Tag 1");
INSERT INTO savinda.tags (ProductID, TagValue) VALUES (1, "Tag 2");



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Creating a Product Restriction Table
CREATE TABLE ProductRestrictions(
	ProductRestrictionID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    ProductRestrictionType VARCHAR(50) NOT NULL,
    ProductRestrictionSubType VARCHAR(50) NOT NULL,
    ProductRestrictionValue INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Sample Relevent data insert queries for Restriction Table
INSERT INTO savinda.productrestrictions (ProductID, ProductRestrictionType, ProductRestrictionSubType, ProductRestrictionValue) VALUES (1,"age","min",18);
INSERT INTO savinda.productrestrictions (ProductID, ProductRestrictionType, ProductRestrictionSubType, ProductRestrictionValue) VALUES (1,"age","max",60);
INSERT INTO savinda.productrestrictions (ProductID, ProductRestrictionType, ProductRestrictionSubType, ProductRestrictionValue) VALUES (1,"qty","max",2);



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Creating a Product Types Table
CREATE TABLE ProductTypes(
	ProductTypeID INT PRIMARY KEY AUTO_INCREMENT,
    ProductTypeName VARCHAR(50) NOT NULL,
    ProductTypeStatus VARCHAR(10) NOT NULL
);

-- Sample Relevent data insert queries for Product Types Table
INSERT INTO savinda.producttypes (ProductTypeName, ProductTypeStatus) VALUES ("Type 1", "active");
INSERT INTO savinda.producttypes (ProductTypeName, ProductTypeStatus) VALUES ("Type 2", "active");
INSERT INTO savinda.producttypes (ProductTypeName, ProductTypeStatus) VALUES ("Type 3", "active");
INSERT INTO savinda.producttypes (ProductTypeName, ProductTypeStatus) VALUES ("Type 4", "active");



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Creating a Product Type Amounts Table
CREATE TABLE ProductTypeAmounts(
	ProductTypeAmountID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    TypeID INT NOT NULL,
    Price DOUBLE NOT NULL,
    Currency VARCHAR(10) NOT NULL,
    ProductTypeAmountStatus VARCHAR(10) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TypeID) REFERENCES ProductTypes(ProductTypeID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Sample Relevent data insert queries for Product Type Amounts Table
INSERT INTO savinda.producttypeamounts (ProductID, TypeID, Price, Currency, ProductTypeAmountStatus) VALUES (1, 1, 100, "USD", "active");
INSERT INTO savinda.producttypeamounts (ProductID, TypeID, Price, Currency, ProductTypeAmountStatus) VALUES (1, 2, 200, "USD", "active");
INSERT INTO savinda.producttypeamounts (ProductID, TypeID, Price, Currency, ProductTypeAmountStatus) VALUES (1, 3, 300, "USD", "active");
INSERT INTO savinda.producttypeamounts (ProductID, TypeID, Price, Currency, ProductTypeAmountStatus) VALUES (1, 4, 400, "USD", "active");



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Creating a Product Type Distributions Table
CREATE TABLE ProductTypeDistributions(
	ProductTypeDistributionID INT PRIMARY KEY AUTO_INCREMENT,
    ProductTypeDistributionName VARCHAR(50) NOT NULL,
    ProductTypeDistributionStatus VARCHAR(10) NOT NULL
);

-- Sample Relevent data insert queries for Product Type Distributions Table
INSERT INTO savinda.producttypedistributions (ProductTypeDistributionName, ProductTypeDistributionStatus) VALUES ("Supplier", "active");
INSERT INTO savinda.producttypedistributions (ProductTypeDistributionName, ProductTypeDistributionStatus) VALUES ("Seller", "active");
INSERT INTO savinda.producttypedistributions (ProductTypeDistributionName, ProductTypeDistributionStatus) VALUES ("Platform", "active");
INSERT INTO savinda.producttypedistributions (ProductTypeDistributionName, ProductTypeDistributionStatus) VALUES ("Delivery", "active");



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Creating a Product Type Distribution Amounts Table
CREATE TABLE ProductTypeDistributionAmounts(
	ProductTypeDistributionAmountID INT PRIMARY KEY AUTO_INCREMENT,
    ProductTypeAmountID INT NOT NULL,
    ProductTypeDistributionID INT NOT NULL,
    Amount DOUBLE NOT NULL,
    FOREIGN KEY (ProductTypeAmountID) REFERENCES ProductTypeAmounts(ProductTypeAmountID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ProductTypeDistributionID) REFERENCES ProductTypeDistributions(ProductTypeDistributionID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Sample Relevent data insert queries for Product Type Distribution Amounts Table
INSERT INTO savinda.producttypedistributionamounts (ProductTypeAmountID, ProductTypeDistributionID, Amount) VALUES (1, 1, 50);
INSERT INTO savinda.producttypedistributionamounts (ProductTypeAmountID, ProductTypeDistributionID, Amount) VALUES (1, 2, 30);
INSERT INTO savinda.producttypedistributionamounts (ProductTypeAmountID, ProductTypeDistributionID, Amount) VALUES (1, 3, 15);
INSERT INTO savinda.producttypedistributionamounts (ProductTypeAmountID, ProductTypeDistributionID, Amount) VALUES (1, 4, 5);