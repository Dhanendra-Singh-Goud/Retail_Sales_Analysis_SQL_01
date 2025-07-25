--Write sql query to retrieve all coumns for sales madeon "2022-11-05
select 
* 
from dbo.[SQL - Retail Sales Analysis ]
where sale_date = '2022-11-05'

--2. write a sql query to retrieve all transaction where the category is "clothing" and the quantity sold is more than 10 in
--the month of nov-2022
select
*
from dbo.[SQL - Retail Sales Analysis ]
where category = 'clothing'
and quantiy >=4
and sale_date >='2022-11-01'
and sale_date < '2022-12-01'

--3. Write a sql  query to calculate the total sales for each category
select
category,
sum(total_sale) as total_sales
from dbo.[SQL - Retail Sales Analysis ]
group by category

--4. Write a sql query to find the average age of customers who purchased item 
--from the "Beauty" category
select 
avg(age) as avg_age
from dbo.[SQL - Retail Sales Analysis ]
where category = 'beauty'
--5.  Write a sql query to find all transactions wherethe total sales is greater than 1000
select 
*
from dbo.[SQL - Retail Sales Analysis ]
where total_sale > 1000

--6. Write a sql query to find all transactions made by each gender in
--each category
select
category,
gender,
count(category)
from dbo.[SQL - Retail Sales Analysis ]
group by category,gender;


--7. Write a sql query to calculate the average sale for each month.
-- Find out best selling month in each year

with MonthlySales as (
select 
    month(sale_date) as salesMonth,
    year(sale_date) as salesyear,
    avg(total_sale) as avg_total_sales
from dbo.[SQL - Retail Sales Analysis ]
group by MONTH(sale_date),year(sale_date)
)
select *
from (
select
   *,
   rank() over(partition by salesYear order by avg_total_sales desc) as rn
   from MonthlySales
   
 )t where rn = 1

 --8. Write a sql query to find the top 5 customers based on the
 --highest total sales.
 --with topScore as (
select 
top 5
customer_id,
sum(total_sale) as totalSales
from dbo.[SQL - Retail Sales Analysis ]
group by customer_id
order by totalSales desc
--)
--select * from topScore
--order by customer_id

--9. Write a sql query to find the number of unique customers who purchased
--items from each category
select
category,
count(distinct customer_id) as no_of_Uniquecustomer
from dbo.[SQL - Retail Sales Analysis ]
group by category;

--10. Write a sql query to create each shift and number of orders
--(Example morning <=12, afternoon between 12 & 17, Evening >17
 with hourly_sale_counting as(
 select
 *,
 case
     when DATEPART(hour, sale_time) <12 then 'Morning_Shift'
	 when datepart(hour, sale_time) between 12 and 17 then 'Noon Shift'
	 else 'evening'
 end as shift
 --count(*) as orderCount
 from dbo.[SQL - Retail Sales Analysis ]
 )
 select 
 shift,
 count(*) as total_orders
 from hourly_sale_counting
 group by shift
 order by total_orders desc
 /*
 group by
     case
	 when DATEPART(hour, sale_time)<12 then 'morning'
	 when DATEPART(hour,sale_time) between 12 and 17 then 'Noon'
	 else 'evening'
	 end
	 order by shift
	 */