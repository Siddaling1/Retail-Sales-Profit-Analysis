CREATE DATABASE Retail_Sales_and_Profit_Analysis;

USE Retail_Sales_and_Profit_Analysis;

/* 1.Retrieve total sales, quantity, and profit for each region. */

SELECT Region , SUM(Total_Sales) AS Total_Sales ,  SUM( Quantity) as Quantity ,SUM(Profit) as Profits
from sales
GROUP BY Region;

/* 2.Find top 5 customers by total purchase amount. */

SELECT DISTINCT Customer_Name , SUM(Total_Sales) AS Total_Sales 
FROM sales
GROUP BY Customer_Name 
ORDER BY Total_Sales desc limit 5 ;

/* 3.Calculate total profit by product category and sub-category  */

ALTER TABLE sales 
CHANGE COLUMN `Sub-Category` `Sub_Category` VARCHAR(100);

SELECT s.Category, s.Sub_Category, SUM(s.Profit) AS Profits
FROM sales s
GROUP BY s.Category, s.Sub_Category
HAVING SUM(s.Profit) = (
    SELECT MAX(sub.ProfitSum)
    FROM (
        SELECT Category, SUM(Profit) AS ProfitSum
        FROM sales
        GROUP BY Category, Sub_Category
    ) sub
    WHERE sub.Category = s.Category
);


/* 4.Find all orders where discount is greater than 70%. */

SET SQL_SAFE_UPDATES = 0;

UPDATE sales
SET Discount = Discount * 100;

SET SQL_SAFE_UPDATES = 1;

SELECT DISTINCT Order_ID 
FROM sales
WHERE Discount >70;


/* 5.Calculate average profit per order.*/

SELECT DISTINCT Order_ID, AVG(profit) as Profit 
FROM sales
GROUP BY Order_ID;


/* 6.List all customers who placed more than 5 orders.*/

SELECT Customer_Name ,COUNT(Row_ID) AS Orders
FROM sales
GROUP BY Customer_Name
HAVING  Orders > 5;


/* 7.Find the top 3 most sold products by quantity.*/

SELECT Product_Name ,MAX(Quantity) AS Quantity
FROM sales
GROUP BY Product_Name
ORDER BY Product_Name DESC LIMIT 3;


/* 8.Identify which shipping mode has the highest average profit.*/

SELECT Ship_Mode , AVG(Profit) as Avg_Profits
FROM sales
GROUP BY Ship_Mode
ORDER BY Avg_Profits DESC ;


/* 9.Retrieve sales and profit by state within each region. */

SELECT Region , State , SUM(Total_Sales) AS Sales , SUM(Profit) as Profits
FROM sales
GROUP BY  State , Region;


/* 10.Find the percentage contribution of each region to total sales. */

SELECT 
    Region,
    SUM(Total_Sales) AS Region_Sales,
    ROUND((SUM(Total_Sales) * 100.0 / (SELECT SUM(Total_Sales) FROM sales)), 2) AS Percentage_Contribution
FROM sales
GROUP BY Region
ORDER BY Percentage_Contribution DESC;


























































































































