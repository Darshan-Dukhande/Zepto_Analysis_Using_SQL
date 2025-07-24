# 🛒 Zepto SQL Data Analysis Project

## 📌 Project Overview

This project focuses on analyzing retail inventory and pricing data from Zepto, a quick-commerce grocery delivery platform. Using SQL, we perform end-to-end data cleaning, exploration, and business-level insights to help improve stock availability, revenue estimation, and discount effectiveness.

---

## 📂 Dataset Description

The dataset includes a list of grocery products with fields such as:

| Column Name            | Description                                 |
|------------------------|---------------------------------------------|
| `name`                 | Product name                                |
| `category`             | Product category                            |
| `mrp`                  | Maximum retail price (in paise, cleaned to ₹) |
| `discountedSellingPrice` | Final selling price                      |
| `discountPercent`      | Discount percentage                         |
| `availableQuantity`    | Quantity available in stock                 |
| `quantity`             | Listed quantity                             |
| `weightInGms`          | Weight of the product in grams              |
| `outOfStock`           | Indicates if the product is out of stock   |

---

## 🧹 Data Cleaning

- Removed records with `mrp = 0` or `discountedSellingPrice = 0`
- Converted MRP and selling prices from paise to rupees
- Created `outOfStock_bool` column (Boolean format for analysis)

---

## 🔍 Key Business Questions Answered

| No. | Query Description |
|-----|--------------------|
| Q1  | Top 10 best-value products by discount % |
| Q2  | High MRP but out-of-stock products |
| Q3  | Estimated revenue by category |
| Q4  | High MRP + Low Discount products |
| Q5  | Categories with highest avg discount |
| Q6  | Total inventory weight by category |
| Q7  | Top 5 categories by quantity |
| Q8–Q9 | Most and least discounted product per category |
| Q10 | Out-of-stock ratio per category |
| Q11–Q12 | Avg discount & low discount products |
| Q13 | Categories with highest revenue potential |
| Q14 | Total stocked vs out-of-stock products |
| Q15 | Duplicate products in different categories |
| Q16 | High MRP, low discount categories |
| Q17 | Product ranking by discount within category |
| Q18 | Product count + out-of-stock count by category |
| Q19 | Top 3 categories with largest price vs discount gap |
| Q20 | Products with below-average category discount |

---

## 📈 Key Insights

- **High Discounts**: Some products offer discounts over 70%, mostly in Snacks & Beverages.
- **Stock Issues**: Categories like **Dairy & Eggs** and **Cooking Essentials** have high out-of-stock ratios.
- **Revenue Potential**: Highest in **Snacks & Branded Foods**, **Cooking Essentials**, and **Dairy & Eggs**.
- **Pricing Gaps**: Premium categories with high MRP often lack competitive discounts.
- **Data Quality**: Some product names are duplicated across categories, indicating redundancy.

---

## 🛠️ SQL Concepts Used

- Data Cleaning: `UPDATE`, `DELETE`, column transformation
- Aggregation: `GROUP BY`, `SUM`, `AVG`, `COUNT`
- Conditional Logic: `CASE`, `HAVING`, `WHERE`
- Ranking: `ROW_NUMBER()`, `RANK() OVER`
- CTEs (Common Table Expressions)
- Window Functions

---

## 🚀 Future Enhancements

- Join with **sales** or **customer** tables for deeper analytics
- Visualize results using Power BI / Tableau / Python
- Deploy on web using Flask or Streamlit
- Convert analysis into a Jupyter Notebook for storytelling

---

## 📁 Files

- `Zepto_SQL_Project.sql` – All SQL queries for data cleaning and analysis
- `README.md` – Project documentation

---

## 🧠 Author

**Darshan Dukhande**  
_Data Science Enthusiast | SQL Analyst | ML Learner_  
📍 India  
📫 dukhandedarshan8@gmail.com

---

## 🏷️ Tags

`SQL` `Retail Analytics` `Data Cleaning` `Inventory Analysis` `Zepto` `Data Science Projects`