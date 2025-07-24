CREATE DATABASE IF NOT EXISTS ZeptoDB;
USE ZeptoDB;

SELECT * FROM zepto
limit 10;

ALTER TABLE zepto 
ADD COLUMN id INT AUTO_INCREMENT UNIQUE;

ALTER TABLE zepto
ADD PRIMARY KEY (id);

ALTER TABLE zepto 
ADD COLUMN outOfStock_bool BOOLEAN;

SET SQL_SAFE_UPDATES = 0;

UPDATE zepto
SET outOfStock_bool = CASE 
    WHEN outOfStock = 'TRUE' THEN TRUE 
    ELSE FALSE 
END
WHERE id IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM zepto
WHERE outOfStock_bool IS NULL;





-- Data cleaning

-- products with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- convert paise to rupees
UPDATE zepto
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT mrp, discountedSellingPrice FROM zepto;





-- Data exploration

-- count of rows
select count(*) from zepto;

-- to check null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

-- different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- products in stock vs out of stock
SELECT outOfStock, COUNT(id)
FROM zepto
GROUP BY outOfStock;

SELECT outOfStock_bool, COUNT(id)
FROM zepto
GROUP BY outOfStock_bool;

-- product names present multiple times
SELECT name, COUNT(id) AS "Number of units"
FROM zepto
GROUP BY name
HAVING count(id) > 1
ORDER BY count(id) DESC;





-- Data analysis

-- Q1.Find the top 10 best-value products based on the discount percentage

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name,mrp
FROM zepto
WHERE outOfStock_bool = 1 and mrp > 300
ORDER BY mrp DESC;

-- Q3.Calculate Estimated Revenue for each category

SELECT category, SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4.Find all products where MRP is greater than ₹500 and discount is less than 10%

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5.Identify the top 5 categories offering the highest average discount percentage.

SELECT category, ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6.What is the Total Inventory Weight Per Category 

SELECT category, SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;

-- Q7.Top 5 Categories by Number of Products

select category, sum(availableQuantity) as total_quantity
from zepto
GROUP BY category
ORDER BY total_quantity desc
limit 5;

-- Q8.Most Discounted Product in Each Category

with max_percent_cte as (
SELECT name, category, discountPercent,
row_number() OVER (partition by category order by discountPercent desc) as rn
from zepto
)
select name, category, discountPercent as max_discounted_prd_per_cat
from max_percent_cte
where rn = 1;

-- Q9.Least Discounted Product in Each Category

with least_percent_cte as (
SELECT name, category, discountPercent,
row_number() OVER (partition by category order by discountPercent) as rn
from zepto
)
select name, category, discountPercent as least_discounted_prd_per_cat
from least_percent_cte
where rn = 1;

-- Q10.Out of Stock Ratio per Category

select category,
count(*) as total_prd_per_cat,
sum(case when outOfStock_bool = 1 then 1 else 0 end) as out_of_stock_prd,
(sum(case when outOfStock_bool = 1 then 1 else 0 end)/count(*))*100 as percent_of_out_of_stock_prd
from zepto
group by category
order by percent_of_out_of_stock_prd;

-- Q11.Average Discount by Category

select category, avg(discountPercent) as avg_dis_per_cat
from zepto
group by category
order by avg(discountPercent) desc;

-- Q12.High MRP but Low Discount Products

select name, mrp, discountPercent
from zepto
where mrp > 300 and discountPercent < 10
order by mrp desc
limit 10;

-- Q13.Category with Highest Revenue Potential

SELECT category, SUM(discountedSellingPrice * 1) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue desc
limit 3;

-- Q14.Total Stocked vs Out-of-Stock Products

select name,
sum(case when outOfStock_bool = 1 then 1 else 0 end) as outOfStockProduct,
sum(case when outOfStock_bool = 0 then 1 else 0 end) as InStockProduct
from zepto
group by id;

-- Q15.Detect Duplicate Product Names in Different Categories

SELECT name
FROM zepto
GROUP BY name
HAVING COUNT(DISTINCT category) > 1;

-- Q16.Find Categories with Low Discount Averages but High MRPs

select category, avg(mrp) as avg_mrp, avg(discountPercent) as avg_dis_per
from zepto
where mrp > 300 and discountPercent < 10
group by category;

-- Q17.Rank Products by Discount within Their Category

select name, category, discountPercent,
RANK() over (partition by category order by discountPercent) as rankk
from zepto;

-- Q18.Category-wise Product Count and Out-of-Stock Count

select category,
count(category) as Total_prd_in_each_cat,
sum(case when outOfStock_bool = 1 then 1 else 0 end) as outOfStockProduct
from zepto
group by category;


select name ,
sum(case when outOfStock_bool = 1 then 1 else 0 end) as outOfStockProduct
from zepto
where category = 'Cooking Essentials'
group by name
having sum(case when outOfStock_bool = 1 then 1 else 0 end) = 1;

-- Q19.Identify the top 3 categories that have the largest difference between average MRP and average discounted selling price

select category,
avg(mrp) as total_mrp_per_cat,
avg(discountedSellingPrice) as total_discounted_price,
(avg(mrp) - avg(discountedSellingPrice)) as difference
from zepto
group by category
order by difference desc
limit 3;

-- Q20.List all products whose discountPercent is less than the average discountPercent of their category

with avg_cte as(
select name, category, discountPercent,
avg (discountPercent) over (partition by category) as avg_dis_per_cat
from zepto
)
select name, category, discountPercent, avg_dis_per_cat
from avg_cte
where discountPercent < avg_dis_per_cat
order by category;

