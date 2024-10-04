use project;
# 1
select * from products p
join categories c on p.category_id = c.category_id
join brands b on p.brand_id=b.brand_id
where list_price= (select max(list_price) from products);

# 2
select count(distinct customer_id) 'total customers' from customers ;

select count(distinct c.customer_id) 'total customers' from customers c
join orders o on c.customer_id=o.customer_id
where o.order_status!=3;

# 3
select count(distinct store_id) 'total stores'from stores;

# 4
select order_id,
SUM(list_price*quantity*(1-discount)) as total_price_spent_per_order
from order_items
GROUP BY order_id;

#5
select s.store_id,
SUM(oi.list_price*oi.quantity*(1-oi.discount)) as total_sales_per_store
from stores s
join orders o on s.store_id=o.store_id
join order_items oi on o.order_id=oi.order_id
GROUP BY s.store_id;

#6
select c.category_name,
count(oi.order_id) as total_sold
from categories c

join products p  on p.category_id=c.category_id
join order_items oi on p.product_id=oi.product_id
GROUP BY c.category_name
order by total_sold desc
limit 1;

# 7
SELECT c.category_name, COUNT(o.order_id) AS rejected_orders
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories c ON p.category_id = c.category_id
WHERE o.order_status = 3
GROUP BY c.category_name;


# 8
select p.product_name,
count(oi.order_id) as total_sold
from products p
join order_items oi on p.product_id=oi.product_id
GROUP BY p.product_name
order by total_sold 
limit 1;

# 9
select concat(first_name,' ',last_name) as 'fell name'from customers
where customer_id=259;

# 10

select c.customer_id,p.product_name ,oi.quantity,o.order_date,o.order_status 
from customers c
left join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id
join products p on p.product_id=oi.product_id
where o.customer_id=259
;


# 11

select concat(st.first_name," ",st.last_name) as 'staff name',s.store_name
from customers c
join orders o on c.customer_id=o.customer_id
join staffs st on st.staff_id=o.staff_id
join stores s on o.store_id=s.store_id
where c.customer_id=259;

# 12
select count(distinct(staff_id)) "staff count" from staffs;
--
select staff_id  "Lead staff id" from staffs
group by staff_id
order by sum(active) desc
limit 1;

# 13
select b.brand_name,count(oi.item_id) 'Number of orders',sum(oi.quantity) 'Sum of Quantity per orders'from  brands b
join products p on b.brand_id=p.brand_id
join order_items oi on oi.product_id=p.product_id
group by b.brand_name
order by count(oi.item_id) desc,sum(oi.quantity) desc
limit 1;

# 14
select count(distinct category_id) 'total categories' from categories ;
--
select c.category_name "Least liked bike",
count(oi.order_id) as total_sold
from categories c
join products p  on p.category_id=c.category_id
join order_items oi on p.product_id=oi.product_id
GROUP BY c.category_name
order by total_sold
limit 1;

# 15
select b.brand_name,st.store_name,sum(s.quantity) as 'quantity at store' from  brands b
join products p on b.brand_id=p.brand_id
join order_items oi on oi.product_id=p.product_id
join stocks s on s.product_id=p.product_id
join stores st on s.store_id = st.store_id 
group by b.brand_name ,st.store_name
order by count(oi.item_id) desc,sum(oi.quantity) desc,sum(s.quantity) desc
limit 1 ;

# 16
select s.state,
count(o.order_id) as total_sold
from stores s
join orders o  on o.store_id=s.store_id
GROUP BY s.state
order by total_sold desc
limit 1;

# 17
select p.product_id,oi.discount from order_items oi
right join products p on p.product_id=oi.product_id
where p.product_id=259;

# 18
SELECT 
    p.product_name,
    s.quantity,
    p.list_price,
    c.category_name,
    p.model_year,
    b.brand_name
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
JOIN 
    brands b ON p.brand_id = b.brand_id
JOIN 
    stocks s ON p.product_id = s.product_id
WHERE 
    p.product_id = 44;
    


# 19
select zip_code from stores where state='CA';

# 20
select count(distinct state) 'total states' from stores ;

# 21
select sum(oi.quantity) "total bikes sold" from categories c
join products p on p.category_id =c.category_id
join order_items oi on oi.product_id=p.product_id
join orders o on oi.order_id=o.order_id
where c.category_name='Children Bicycles' 
and o.order_date between "2018-11-18" and "2018-03-01";


# 22
select c.customer_id,o.shipped_date from customers c
left join orders o on c.customer_id=o.customer_id
where c.customer_id=523;

# 23
select count(order_id) 'pending orders' from orders
where order_status=1 ;

# 24
select c.category_name,b.brand_name,p.product_name,p.model_year from products as p
join categories as c on c.category_id= p.category_id
join brands as b on p.brand_id=b.brand_id
where p.product_name = "Electra white water 3i - 2018";
