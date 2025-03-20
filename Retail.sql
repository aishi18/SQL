-- 1. Write a query to display customer full name with their title (Mr/Ms), both first name and last name are in upper case, customer email id, customer creation date and display customer’s category after applying below categorization rules: i) IF customer creation date Year <2005 Then Category A ii) IF customer creation date Year >=2005 and <2011 Then Category B iii)IF customer creation date Year>= 2011 Then Category C Hint: Use CASE statement, no permanent change in table required. [NOTE: TABLES to be used - ONLINE_CUSTOMER TABLE]
select if(CUSTOMER_GENDER='F','Ms','Mr') as'ms/mr',
UPPER(CONCAT(CUSTOMER_FNAME , ' ' , CUSTOMER_LNAME)) as 'CustomerName', 
CUSTOMER_EMAIL,CUSTOMER_CREATION_DATE,
case 
	when year(CUSTOMER_CREATION_DATE) < 2005 then 'Category A'
    when year(CUSTOMER_CREATION_DATE) > 2005 and year(CUSTOMER_CREATION_DATE)<2011 then 'Category B'
    else 'Category c'
    end as 'customer’s category '
from ONLINE_CUSTOMER ;

-- 2. Write a query to display the following information for the products, which have not been sold: product_id, product_desc, product_quantity_avail, product_price, inventory values (product_quantity_avail*product_price), New_Price after applying discount as per below criteria. Sort the output with respect to decreasing value of Inventory_Value. i) IF Product Price > 200,000 then apply 20% discount ii) IF Product Price > 100,000 then apply 15% discount iii) IF Product Price =< 100,000 then apply 10% discount # Hint: Use CASE statement, no permanent change in table required. [NOTE: TABLES to be used - PRODUCT, ORDER_ITEMS TABLE]
select p.PRODUCT_ID AS 'number of products that have not been sold',
p.PRODUCT_DESC, p.PRODUCT_QUANTITY_AVAIL, p.PRODUCT_PRICE, 
p.PRODUCT_QUANTITY_AVAIL * p.PRODUCT_PRICE as INVENTORY_VALUE,
case 
when p.PRODUCT_PRICE > '200000' then p.PRODUCT_PRICE*0.80
when p.PRODUCT_PRICE > '100000' and p.PRODUCT_PRICE <= '200000' then p.PRODUCT_PRICE*0.85
when p.PRODUCT_PRICE <= '100000' then p.PRODUCT_PRICE*0.90
end as Calculated_Price
from product as p
LEFT JOIN order_items as oi on p.PRODUCT_ID = oi.PRODUCT_ID
where oi.PRODUCT_ID is null
ORDER BY INVENTORY_VALUE DESC;

-- 3. Write a query to display Product_class_code, Product_class_description, Count of Product type in each productclass, Inventory Value (p.product_quantity_avail*p.product_price). Information should be displayed for only those product_class_code which have more than 1,00,000. Inventory Value. Sort the output with respect to decreasing value of Inventory_Value. [NOTE: TABLES to be used - PRODUCT_CLASS, PRODUCT_CLASS_CODE]
select PC.PRODUCT_CLASS_CODE, count(PC.PRODUCT_CLASS_CODE) as product_count,PC.PRODUCT_CLASS_DESC, 
sum(P.PRODUCT_QUANTITY_AVAIL*P.PRODUCT_PRICE) as Inventory_Values
from PRODUCT  as P
    left join  PRODUCT_CLASS AS PC ON P.PRODUCT_CLASS_CODE=PC.PRODUCT_CLASS_CODE
    group by p.PRODUCT_CLASS_CODE having Inventory_Values>100000
ORDER BY Inventory_Values DESC;

-- 4. Write a query to display customer_id, full name, customer_email, customer_phone and country of customers who have cancelled all the orders placed by them (USE SUB-QUERY)[NOTE: TABLES to be used - ONLINE_CUSTOMER, ADDRESSS, OREDER_HEARDER]
select oc.CUSTOMER_ID,CONCAT(oc.CUSTOMER_FNAME , ' ' , oc.CUSTOMER_LNAME) as 'Customer_FullName', 
oc.CUSTOMER_EMAIL,oc.CUSTOMER_PHONE,a.COUNTRY 
from ONLINE_CUSTOMER as oc 
Left join ADDRESS as a on a.ADDRESS_ID=OC.ADDRESS_ID
where CUSTOMER_ID in (select CUSTOMER_ID from ORDER_HEADER where ORDER_STATUS = 'cancelled')
group by CUSTOMER_ID;

-- 5. Write a query to display Shipper name, City to which it is catering, num of customer catered by the shipper in the city and number of consignments delivered to that city for Shipper DHL [NOTE: TABLES to be used - SHIPPER,ONLINE_CUSTOMER, ADDRESSS, ORDER_HEARDER]
select S.SHIPPER_NAME,  ad.CITY, count(distinct(oh.CUSTOMER_ID)) as CUSTOMER_CATERED, 
count(ad.CITY) as CONSIGNMENTS_DELIVERED  from  shipper as S
left join order_header as oh on S.SHIPPER_ID = oh.SHIPPER_ID
left join online_customer as oc on oh.CUSTOMER_ID=oc.CUSTOMER_ID
left join address as ad on oc.ADDRESS_ID = ad.ADDRESS_ID
where S.SHIPPER_NAME = 'DHL'
group by ad.CITY;

-- 6. Write a query to display product_id, product_desc, product_quantity_avail, quantity sold, quantity available and show inventory Status of products as below as per below condition: a. For Electronics and Computer categories, if sales till date is Zero then show 'No Sales in past, give discount to reduce inventory', if inventory quantity is less than 10% of quantity sold,show 'Low inventory, need to add inventory', if inventory quantity is less than 50% of quantity sold, show 'Medium inventory, need to add some inventory', if inventory quantity is more or equal to 50% of quantity sold, show 'Sufficient inventory' b. For Mobiles and Watches categories, if sales till date is Zero then show 'No Sales in past, give discount to reduce inventory', if inventory quantity is less than 20% of quantity sold, show 'Low inventory, need to add inventory', if inventory quantity is less than 60% of quantity sold, show 'Medium inventory, need to add some inventory', if inventory quantity is more or equal to 60% of quantity sold, show 'Sufficient inventory' c. Rest of the categories, if sales till date is Zero then show 'No Sales in past, give discount to reduce inventory', if inventory quantity is less than 30% of quantity sold, show 'Low inventory, need to add inventory', if inventory quantity is less than 70% of quantity sold, show 'Medium inventory, need to add some inventory', if inventory quantity is more or equal to 70% of quantity sold, show 'Sufficient inventory' -- (USE SUB-QUERY) -- [NOTE: TABLES to be used - PRODUCT, PRODUCT_CLASS, ORDER_HEADER]
select p.PRODUCT_ID, p.PRODUCT_DESC, sum(p.PRODUCT_QUANTITY_AVAIL) as PRODUCT_QUANTITY_AVAIL, sum(ifnull(oi.PRODUCT_QUANTITY,0)) as QUANTITY_SOLD, 
sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0)) as AVAILABLE_QUANTITY,
case when sum(ifnull(oi.PRODUCT_QUANTITY,0))  = 0 then 'No Sales in past, give discount to reduce inventory'
when pc.product_class_desc = 'Electronics' or pc.product_class_desc = 'Computer' then 
	case 	when  (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) < 0.1 * sum(ifnull(oi.PRODUCT_QUANTITY,0))  then 'Low inventory, need to add inventory'
		when (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) < 0.5 * sum(ifnull(oi.PRODUCT_QUANTITY,0)) then 'Medium inventory, need to add some inventory'
        	when (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) >= 0.5 * sum(ifnull(oi.PRODUCT_QUANTITY,0)) then 'Sufficient inventory'
        end 
when pc.product_class_desc = 'Mobiles' or pc.product_class_desc = 'Watches' then 
	case  when  (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) < 0.2 * sum(ifnull(oi.PRODUCT_QUANTITY,0))  then 'Low inventory, need to add inventory'
		when (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) < 0.6 * sum(ifnull(oi.PRODUCT_QUANTITY,0)) then 'Medium inventory, need to add some inventory'
            when (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) >= 0.6 * sum(ifnull(oi.PRODUCT_QUANTITY,0)) then 'Sufficient inventory'
        end 
when pc.product_class_desc != 'Mobiles' or pc.product_class_desc = !'Watches' or pc.product_class_desc != 'Electronics' or pc.product_class_desc != 'Computer' then 
	case  when  (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) < 0.3 * sum(ifnull(oi.PRODUCT_QUANTITY,0))  then 'Low inventory, need to add inventory'
		when (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) < 0.7 * sum(ifnull(oi.PRODUCT_QUANTITY,0)) then 'Medium inventory, need to add some inventory'
        	when (sum(p.PRODUCT_QUANTITY_AVAIL) - sum(ifnull(oi.PRODUCT_QUANTITY,0))) >= 0.7 * sum(ifnull(oi.PRODUCT_QUANTITY,0)) then 'Sufficient inventory'
        end 
	end as INVENTORY_STATUS
from  product as p
left join product_class as pc on p.product_class_code = pc.product_class_code
left join order_items as oi on p.product_id = oi.product_id
group by p.product_id
order by PRODUCT_ID asc;
-- 7. Write a query to display order_id and volume of the biggest order (in terms of volume) that can fit in carton id 10 -- [NOTE: TABLES to be used - CARTON, ORDER_ITEMS, PRODUCT]
select oi.order_id, sum(oi.product_quantity * p.len * p.width * p.height) as PRODUCT_VOLUME
from order_items as oi
left join product as p on oi.product_id = p.product_id
group by  order_id  having PRODUCT_VOLUME < (select len * width * height as CARTON_VOLUME from carton where carton_id = 10) 
order by product_volume desc
limit 1;


-- 8. Write a query to display customer id, customer full name, total quantity and total value (quantity*price) shipped where mode of payment is Cash and customer last name starts with 'G' --[NOTE: TABLES to be used - ONLINE_CUSTOMER, ORDER_ITEMS, PRODUCT, ORDER_HEADER]
select oc.customer_id, concat(oc.customer_fname,' ',oc.customer_lname) as CUSTOMER_FULL_NAME, 
sum(oi.product_quantity) as TOTAL_QUANTITY, sum(oi.product_quantity*p.product_price) as TOTAL_VALUE
from online_customer as oc
left join order_header as oh on oc.customer_id = oh.customer_id
left join order_items as oi on oh.order_id = oi.order_id
left join product as p on oi.product_id = p.product_id
where oh.payment_mode = 'Cash' and oc.customer_lname LIKE 'G%'
group by CUSTOMER_FULL_NAME ; 

-- 9. Write a query to display product_id, product_desc and total quantity of products which are sold together with product id 201 and are not shipped to city Bangalore and New Delhi. Display the output in descending order with respect to the tot_qty. -- (USE SUB-QUERY) -- [NOTE: TABLES to be used - order_items, product,order_head, online_customer, address]
select p.product_id, p.product_desc, sum(oi.product_quantity) as TOTAL_QUANTITY, oi.order_id  from product as p
left join order_items as oi on p.product_id = oi.product_id 
where oi.order_id in 
	(select oi.order_id from order_items as oi
		left join order_header as oh on oi.order_id = oh.order_id
		left join online_customer as oc on oh.customer_id = oc.customer_id
		left join address as a on oc.address_id = a.address_id
		where product_id = '201' and a.city != 'Bangalore' and a.city != 'New Delhi') 
group by oi.order_id
order by TOTAL_QUANTITY desc;

-- 10. Write a query to display the order_id,customer_id and customer fullname, total quantity of products shipped for order ids which are even and shipped to address where pincode is not starting with "5" -- [NOTE: TABLES to be used - online_customer,Order_header, order_items,address]

select oh.order_id, oc.customer_id, concat(oc.customer_fname,' ',oc.customer_lname) as CUSTOMER_FULL_NAME, sum(oi.product_quantity) as TOTAL_QUANTITY
from online_customer as oc
left join order_header as oh on oc.customer_id = oh.customer_id
left join order_items as oi on oh.order_id = oi.order_id
left join address as a on oc.address_id = a.address_id
where oh.order_id % 2 = 0 and a.pincode not like '5%' and oi.product_quantity is not null
group by oc.customer_id;
 