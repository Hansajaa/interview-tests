DELIMITER $$

CREATE PROCEDURE SaveProductsFromJSON(
    IN jsonData JSON
)
BEGIN
    -- Declare variables
    DECLARE productId INT;
    DECLARE productName VARCHAR(100);
    DECLARE productDesc VARCHAR(255);
    DECLARE productCategory VARCHAR(25);
    DECLARE productImage VARCHAR(255);
    DECLARE productStatus VARCHAR(25);
    DECLARE i INT DEFAULT 0;
    DECLARE j INT DEFAULT 0;
    DECLARE k INT DEFAULT 0;
    DECLARE typeId INT;
    DECLARE typeAmountId INT;
    DECLARE distAmountId INT;
    DECLARE numProducts INT;
    DECLARE numTypes INT;
    DECLARE numRestrictions INT;
    DECLARE numTags INT;
    DECLARE numDist INT;
    
    DECLARE createdBy VARCHAR(100) DEFAULT 'System';
    
    -- Start transaction
    START TRANSACTION;
    
    -- Get number of products in the JSON
    SET numProducts = JSON_LENGTH(JSON_EXTRACT(jsonData, '$.products'));
    
    -- Loop through each product
    productLoop: WHILE i < numProducts DO
        -- Get product data
        SET productName = JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].name')));
        SET productDesc = JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].description')));
        SET productCategory = JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].category')));
        SET productImage = JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].image')));
        SET productStatus = JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].status')));
        
        -- Insert product
        INSERT INTO Products (ProductName, ProductDescription, category, image, ProductStatus, CreatedBy, CreatedAt)
        VALUES (productName, productDesc, productCategory, productImage, productStatus, createdBy, NOW());
        
        -- Get the inserted product ID
        SET productId = LAST_INSERT_ID();
        
        -- Process tags
        SET numTags = JSON_LENGTH(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].tags')));
        SET j = 0;
        WHILE j < numTags DO
            INSERT INTO Tags (ProductID, TagValue)
            VALUES (
                productId,
                JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].tags[', j, ']')))
            );
            SET j = j + 1;
        END WHILE;
        
        -- Process restrictions
        SET numRestrictions = JSON_LENGTH(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].restrictions')));
        SET j = 0;
        WHILE j < numRestrictions DO
            INSERT INTO ProductRestrictions (ProductID, ProductRestrictionType, ProductRestrictionSubType, ProductRestrictionValue)
            VALUES (
                productId,
                JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].restrictions[', j, '].type'))),
                JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].restrictions[', j, '].subType'))),
                JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].restrictions[', j, '].value'))
            );
            SET j = j + 1;
        END WHILE;
        
        -- Process product types
        SET numTypes = JSON_LENGTH(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types')));
        SET j = 0;
        WHILE j < numTypes DO
            -- Get type ID from JSON
            SET typeId = JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].id'));
            
            -- Check if product type exists, insert if not
            IF NOT EXISTS (SELECT 1 FROM ProductTypes WHERE ProductTypeID = typeId) THEN
                INSERT INTO ProductTypes (ProductTypeID, ProductTypeName, ProductTypeStatus)
                VALUES (
                    typeId,
                    JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].name'))),
                    JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].status')))
                );
            END IF;
            
            -- Insert product type amount
            INSERT INTO ProductTypeAmounts (ProductID, TypeID, Price, Currency, ProductTypeAmountStatus)
            VALUES (
                productId,
                typeId,
                JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].price')),
                JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].currency'))),
                JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].status')))
            );
            
            -- Get the inserted product type amount ID
            SET typeAmountId = LAST_INSERT_ID();
            
            -- Process distributions
            SET numDist = JSON_LENGTH(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].distributions')));
            SET k = 0;
            WHILE k < numDist DO
                -- Get distribution ID from JSON
                SET distAmountId = JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].distributions[', k, '].id'));
                
                -- Check if distribution type exists, insert if not
                IF NOT EXISTS (SELECT 1 FROM ProductTypeDistributions WHERE ProductTypeDistributionID = distAmountId) THEN
                    INSERT INTO ProductTypeDistributions (ProductTypeDistributionID, ProductTypeDistributionName, ProductTypeDistributionStatus)
                    VALUES (
                        distAmountId,
                        JSON_UNQUOTE(JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].distributions[', k, '].name'))),
                        'active'
                    );
                END IF;
                
                -- Insert distribution amount
                INSERT INTO ProductTypeDistributionAmounts (ProductTypeAmountID, ProductTypeDistributionID, Amount)
                VALUES (
                    typeAmountId,
                    distAmountId,
                    JSON_EXTRACT(jsonData, CONCAT('$.products[', i, '].types[', j, '].distributions[', k, '].amount'))
                );
                
                SET k = k + 1;
            END WHILE;
            
            SET j = j + 1;
        END WHILE;
        
        SET i = i + 1;
    END WHILE;
    
    -- Commit transaction
    COMMIT;
    
    SELECT 'Data imported successfully' AS Result;
    
    -- Handle errors
    EXCEPTION_HANDLER: BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            SELECT 'Error occurred during import' AS Result;
        END;
    END;
END$$

DELIMITER ;




------------------------------------------------------------------------------------------

-- Import data through above Stored Procedure
CALL SaveProductsFromJSON('{
  "products": [
    {
      "name": "Product 1",
      "description": "This is a product 1",
      "category": "Category 1",
      "image": "https://via.placeholder.com/150",
      "status": "active",
      "restrictions": [
        {
          "type": "age",
          "value": 18,
          "subType": "min"
        },
        {
          "type": "age",
          "value": 60,
          "subType": "max"
        },
        {
          "type": "qty",
          "value": 2,
          "subType": "max"
        }
      ],
      "tags": [
        "tag1",
        "tag2"
      ],
      "types": [
        {
          "id": 1,
          "name": "Type 1",
          "price": 100,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 50
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 30
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 15
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 5
            }
          ]
        },
        {
          "id": 2,
          "name": "Type 2",
          "price": 200,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 100
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 60
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 30
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 10
            }
          ]
        },
        {
          "id": 3,
          "name": "Type 3",
          "price": 300,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 150
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 90
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 45
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 15
            }
          ]
        },
        {
          "id": 4,
          "name": "Type 4",
          "price": 400,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 200
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 120
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 60
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 20
            }
          ]
        }
      ]
    },
    {
      "name": "Product 2",
      "description": "This is a product 2",
      "category": "Category 2",
      "image": "https://via.placeholder.com/150",
      "status": "active",
      "restrictions": [
        {
          "type": "age",
          "value": 18,
          "subType": "min"
        },
        {
          "type": "age",
          "value": 60,
          "subType": "max"
        },
        {
          "type": "qty",
          "value": 2,
          "subType": "max"
        }
      ],
      "tags": [
        "tag1",
        "tag2"
      ],
      "types": [
        {
          "id": 1,
          "name": "Type 1",
          "price": 100,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 50
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 30
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 15
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 5
            }
          ]
        },
        {
          "id": 2,
          "name": "Type 2",
          "price": 200,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 100
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 60
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 30
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 10
            }
          ]
        },
        {
          "id": 3,
          "name": "Type 3",
          "price": 300,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 150
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 90
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 45
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 15
            }
          ]
        },
        {
          "id": 4,
          "name": "Type 4",
          "price": 400,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 200
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 120
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 60
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 20
            }
          ]
        }
      ]
    },
    {
      "name": "Product 3",
      "description": "This is a product 3",
      "category": "Category 3",
      "image": "https://via.placeholder.com/150",
      "status": "active",
      "restrictions": [
        {
          "type": "age",
          "value": 18,
          "subType": "min"
        },
        {
          "type": "age",
          "value": 60,
          "subType": "max"
        },
        {
          "type": "qty",
          "value": 2,
          "subType": "max"
        }
      ],
      "tags": [
        "tag1",
        "tag2"
      ],
      "types": [
        {
          "id": 1,
          "name": "Type 1",
          "price": 100,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 50
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 30
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 15
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 5
            }
          ]
        },
        {
          "id": 2,
          "name": "Type 2",
          "price": 200,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 100
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 60
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 30
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 10
            }
          ]
        },
        {
          "id": 3,
          "name": "Type 3",
          "price": 300,
          "status": "active",
          "currency": "USD",
          "distributions": [
            {
              "id": 1,
              "name": "Supplier",
              "amount": 150
            },
            {
              "id": 2,
              "name": "Seller",
              "amount": 90
            },
            {
              "id": 3,
              "name": "Platform",
              "amount": 45
            },
            {
              "id": 4,
              "name": "Delivery",
              "amount": 15
            }
          ]
        }
      ]
    }
  ]
}');