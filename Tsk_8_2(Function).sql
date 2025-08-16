

-- Use CASE to Categorize Orders Based on Amount

select orders.order_id,
customer.customer_id,
customer.customer_name,
orders.amount,
case
when orders.amount < 500 then "Lower"
when orders.amount > 500 and orders.amount < 1000 then "Middle"
else "Higher"
end as Status
 from orders join customer on customer.customer_id = orders.customer_id;
 
 delimiter //
create function  order_status(orderAmount decimal(10,2))
returns decimal(10,2)
deterministic
begin
	declare amt decimal(10,2);
    set amt = orderAmount;
    return amt;
end //
delimiter ;

delimiter //
create function order_result(orderAmount decimal(10,2))
returns varchar(100)
deterministic
begin
	declare amt decimal(10,2);
    declare result varchar(30);
    set amt = orderAmount;
   set result = case
		when amt < 500 then 'Lower'
        when amt > 500 and  amt < 1000 then 'Middle'
        when amt > 1000 then 'Larger'
        end;
        return result;
end //
delimiter ;

drop function order_result;

select orders.order_id,
customer.customer_id,
customer.customer_name,
orders.amount,
sales_order.order_result(amount) as status
 from orders join customer on customer.customer_id = orders.customer_id;

-- Use IF to Mark Orders as 'Large' or 'Small'

select orders.order_id,
customer.customer_id,
orders.amount,
if( orders.amount >800,'Larger','Smaller') as Status
 from orders join customer on orders.customer_id = customer.customer_id


delimiter //
create function New_Order_Status(OrderAmount decimal(10,2))
returns decimal(10,2)
deterministic
begin
	declare amt decimal(10,2);
    
    set amt = OrderAmount;
		return amt;
end //
delimiter ;

select orders.order_id,
customer.customer_id,
orders.amount,
if( sales_order.New_Order_Status(orders.amount) >800,'Larger','Smaller') as Status
 from orders join customer on orders.customer_id = customer.customer_id


delimiter //
create function New_Order_Data(orderAmount decimal(10,2))
returns varchar(100)
deterministic
begin
	declare amt decimal(10,2);
    declare result varchar(100);
    set amt = orderAmount;
   set result = if(amt > 500,'Larger','Smaller');
   return result;
end //
delimiter ;

drop function New_Order_Data;

select orders.order_id,
customer.customer_id,
orders.amount,
sales_order.New_Order_Data(orders.amount) as Status
 from orders join customer on orders.customer_id = customer.customer_id;


-- Filter Orders from Customers in New York OR Amount > 250;

select orders.order_id,customer.customer_id,orders.amount,customer.country
 from orders join customer on orders.customer_id = customer.customer_id
 where country = 'Canada' and amount > 300;
 
 -- Get Total Orders for Each Customer With Conditional Aggregation
 
 select customer.customer_name,customer.customer_id,
 count(case when orders.amount < 500 then orders.amount end) as 'Lower_Order',
 count(case when orders.amount > 500 and orders.amount < 1000 then orders.amount end) as 'Middle_Order',
count(case when orders.amount > 1000 then orders.amount  end) as 'Higher_Order'
 from orders join customer on orders.customer_id = customer.customer_id
 group by customer.customer_name,customer.customer_id;
 
 -- Use CASE Inside ORDER BY to Prioritize Certain Cities
 
 select orders.order_id,customer.customer_id,customer.country
 from orders join customer on orders.customer_id = customer.customer_id
order by
case 
	when country = 'USA' then 1
    when COUNTRY = 'Canada' then 2
    else 3
end
 