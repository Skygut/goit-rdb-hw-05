-- *************************

-- Homework 5

-- *************************
-- p1
SELECT od.*,
    (SELECT o.customer_id 
     FROM orders o 
     WHERE o.id = od.order_id) AS customer_id
FROM 
    order_details od;
    
  -- *************************
     
  -- p2
  SELECT od.*
FROM order_details od
WHERE od.order_id IN (
        SELECT o.id 
        FROM orders o 
        WHERE o.shipper_id = 3);

  -- *************************
    
  -- p3
    SELECT order_id, AVG(quantity) AS avg_quantity
    FROM (SELECT * FROM order_details WHERE quantity>10) AS quantity_table
    GROUP BY order_id; 
        
-- *************************

-- p4
 WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;  

-- *************************

-- p5
DROP FUNCTION IF EXISTS divide_numbers;

DELIMITER //

CREATE FUNCTION divide_numbers(dividend FLOAT, divisor FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE result FLOAT;
    
    SET result = dividend / divisor;
    
    RETURN result;
END//

DELIMITER ;

SELECT order_id, 
       quantity, 
       divide_numbers(quantity, 2.0) AS divided_quantity
FROM order_details;