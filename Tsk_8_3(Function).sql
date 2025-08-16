

select * from orders where customer_id = 1001;

delimiter //
create function order_data(customerId int)
returns json
deterministic
begin
declare result JSON;
select json_object('ORDER_ID',order_id,'ORDER_DATE',Order_Date)
into result from orders where customer_id = customerId limit 1;
return result;
end //
delimiter ;

drop function order_data;
select order_data(1001)
