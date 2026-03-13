/* ============================================================
   OBJECTIVE:
   Analyze e-commerce transactions to uncover insights about
   sales performance, customer behavior, and product trends.
   ============================================================ */
   

--   CHECKING TOTAL RECORDS IN DATASET
--  This helps verify that the dataset was imported correctly.
select count(*) from retail;


-- COUNT TOTAL UNIQUE TRANSACTIONS 
-- Each InvoiceNo represent one transcation
select count(distinct Invoice) as total_transactions
from retail;


-- COUNT UNIQUE CUSTOMERS
-- This shows how many customer made purchases
select count(distinct `Customer ID`) as total_customers
from retail;


-- COUNT UNIQUE PRODUCTS
-- each stockcode represents a product
select count(distinct StockCode) as total_products
from retail;


-- CALCULATE TOTAL REVENUE 
-- revenue = quantity * price
select sum( Quantity * Price ) as total_revenue
from retail;


-- REVENUE BY COUNTRY
-- Identify top countries generating highest revenue
select Country, 
Sum(Quantity * Price) as revenue
from retail
GROUP BY Country
ORDER BY revenue DESC;


-- TOP 10 BEST SELLING PRODUCTS
-- based on total quantity sold
select Description,
Sum(Quantity) as total_quantity_sold
from retail 
group by Description
order by total_quantity_sold desc 
limit 10 ;


-- TOP PRODUCTS BY REVENUE
-- Identify products generating the most revenue
select Description,
sum(Quantity * Price) as total_revenue
from retail
group by Description
order by total_revenue desc
limit 10;


-- TOP 10 CUSTOMERS BY TOTAL SPENDING
-- helps identify high_value customers
select `Customer ID`,
sum(Quantity * Price) as total_spent
from retail
group by `Customer ID`
order by total_spent desc
limit 10;


-- AVERAGE CUSTOMER SPENDING
-- Measures average revenue generated per customer
select avg(customer_spending) as avg_spending
from(
select `Customer ID` ,
Sum(Quantity * Price) as customer_spending
from retail
group by `Customer ID`
) as customer_data;


-- MONTHLY SALES TREND
-- helps identify seasonal sales patterns 
select date_format(InvoiceDate, '%Y-%m') as month,
sum(Quantity *Price) as revenue 
from retail
group by month
order by month ;


-- DAILY SALES TREND
-- useful for detecting daily fluctuations in revenue
select date(InvoiceDate) as day,
sum(Quantity * Price) as revenue
from retail
group by day
order by day;


-- AVERAGE ORDER VALUE
-- measure the average revenue generated per order
SELECT AVG(order_value) AS avg_order_value
FROM
(
SELECT Invoice,
SUM(Quantity * Price) AS order_value
FROM retail
GROUP BY Invoice
) AS orders;


-- ANALYZE PRODUCT RETURNS 
-- Negative quantity indicate returned product
select Description,
Sum(Quantity) as returned_quantity
from retail
where Quantity < 0
group by Description
order by returned_quantity;


-- AVERAGE ITEMS PER ORDER
-- Helps understand customer purchasing behavior
SELECT AVG(total_items) AS avg_items_per_order
FROM
(
SELECT Invoice,
SUM(Quantity) AS total_items
FROM retail
GROUP BY Invoice
) AS basket;
