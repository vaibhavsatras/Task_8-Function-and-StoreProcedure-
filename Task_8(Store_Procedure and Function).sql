
-- Procedure: Get Orders by Customer ID
-- select customer.customer_id,count(orders.order_id) as Order_Count
--  from customer join orders on customer.customer_id = orders.customer_id 
--  group by customer.customer_id;
 
  delimiter // 
 create procedure Order_Count()
 begin 
 select customer.customer_id, count(orders.order_id) as Order_Count
 from customer join orders on customer.customer_id = orders.customer_id
 group by Customer_Id;
 end //
 delimiter ; 
call Order_Count();


-- Function: Total Amount Spent by a Customer

SELECT CUSTOMER.CUSTOMER_ID,SUM(AMOUNT) AS TOTAL_AMOUNT
 FROM CUSTOMER JOIN ORDERS ON CUSTOMER.CUSTOMER_ID = ORDERS.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID;

DELIMITER //
CREATE FUNCTION TOTAL_AMOUNT(ORDERID INT)
RETURNS VARCHAR(100)
deterministic
BEGIN
-- DECLARE customerid int;
declare orderamt decimal(10,2);
-- SELECT   customer_id into customerid  FROM ORDERS WHERE ORDER_ID = ORDERID;
 SELECT  amount into orderamt  FROM ORDERS WHERE ORDER_ID = ORDERID;
-- RETURN customerid;
return orderamt;
END //
DELIMITER ;

select TOTAL_AMOUNT(201) as Total_Order;
select  * from orders;
SHOW CREATE FUNCTION TOTAL_AMOUNT;
DROP FUNCTION TOTAL_AMOUNT;

