# 🛋️ Arkan Home: E-Commerce Data Localization & Analytics (Egypt)

[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://github.com/MigzXYZ/Arkan-Home-ECommerce-Data-Analysis/tree/main/PowerBI_File)
[![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)](https://github.com/MigzXYZ/Arkan-Home-ECommerce-Data-Analysis/tree/main/SQL_Scripts)
[![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)](https://github.com/MigzXYZ/Arkan-Home-ECommerce-Data-Analysis/tree/main/Dataset)

## 👥 Team Members
* [Ahmed Magdy](https://github.com/MigzXYZ)
* [Mark Morris]
* [Mai Ibrahim](https://github.com/maiibrahim335)
* [Aisha Taha](https://github.com/Aisha-taha)

## 📌 Project Overview
**Arkan Home** is a data-driven project that transforms and localizes a global e-commerce dataset (Olist Brazil) to simulate a realistic specialized E-commerce business operating in the **Egyptian Market**, specifically focusing on the **Home Décor and Furniture** niche.

This project covers the end-to-end data pipeline: from database extraction and complex ETL processes to building a highly optimized Star Schema and delivering actionable business insights via an interactive Power BI dashboard.

## 🎯 Problem Statement
There is a significant lack of accessible, large-scale e-commerce datasets specifically tailored to the Egyptian market. This makes it challenging for analysts and startups to build predictive models or logistical strategies based on local variables (e.g., shipping to Upper Egypt vs. Cairo, or EGP price inflation). 

**Solution:** This project bridges that gap by engineering a synthesized, localized dataset through advanced mapping, logical currency translation, and niche filtering.

---

## 🏗️ Data Architecture, ETL & Localization
*(This section combines both SQL Server database optimization and Power Query localization steps)*

To ensure high performance and follow Data Warehousing best practices, the data model was transformed from a normalized transactional structure into an optimized **Star Schema**. All heavy transformations were pushed upstream to SQL Server using the principle of **Query Folding** to reduce the load on the Power BI engine, while market-specific localization was handled via Power Query.

### 1. Database Engineering (SQL Server):
* **Surrogate Keys for Performance:** Complex string identifiers (UUIDs) were converted into sequential Integers (INTs). This significantly reduces memory consumption and speeds up DAX calculations.
* **Degenerate Dimensions:** Instead of creating nearly empty dimension tables for Customers and Sellers, their keys were integrated directly into the `Fact_Sales` table. This saves storage while maintaining the ability to perform `DISTINCTCOUNT` aggregations.
* **Geographic Localization:** Mapped Brazilian state codes to 27 Egyptian Governorates (e.g., SP -> Cairo, RJ -> Alexandria) to enable accurate local logistics analysis.
* **Role-Playing Dimension:** A single `Dim_Geography` table was designed to serve multiple roles (Customer Geography and Seller Geography) simultaneously.
* **Data Cleaning & Consolidation:**
  * Replaced `NULL` or blank product categories with `'Others'`.
  * Consolidated fragmented payment methods (`boleto`, `not_defined`) into a unified `'Cash'` category.
  * Aggregated Payments and Reviews datasets (`Group By` order_id) and merged them into the `Fact_Sales` table to avoid duplication and eliminate many-to-many relationships.

### 2. Market Localization (Power Query):
Key transformations applied to synthesize the Egyptian market environment:
* **Strategic Currency Translation (BRL to EGP):** Instead of a flat exchange rate, a **Conditional Inflation Multiplier** was applied based on product categories to reflect realistic 2024/2026 Egyptian market prices:
    * *High-Ticket Items* (e.g., Modern Sofa Sets, Chandeliers): Multiplied by **65**.
    * *Mid-Ticket Items* (e.g., Gallery Wall Art, Ergonomic Chairs): Multiplied by **35**.
    * *Low-Ticket Items* (e.g., Scented Candles, Organizers): Multiplied by **15**.
* **Dynamic Image URLs:** Integrated Egyptian State Flags directly into the geographic dimension to be rendered dynamically within Power BI visuals.

### 🕸️ Data Model (Star Schema)
The model consists of a single, centralized Fact Table (`Fact_Sales`) surrounded by supporting Dimension Tables:
1. `Dim_Date` (Generated via DAX)
2. `Dim_Product`
3. `Dim_Geography`
4. `Dim_PaymentMethod`
5. `Dim_Status`

<img width="1496" height="793" alt="image" src="https://github.com/user-attachments/assets/f17558e7-ea3d-47e1-be28-3031ef3d90b7" />

---

## 📈 Key Performance Indicators (DAX) - *[Work In Progress]*
The upcoming analytical phase will focus on developing advanced DAX measures to answer critical business questions across three main perspectives:

* **Sales Performance:** Total Revenue (EGP), Average Order Value (AOV), and Best-Selling Categories.
* **Logistics & Supply Chain:** Average Delivery Delay, Freight Cost vs. Product Price ratio across different Governorates (e.g., Cairo vs. Upper Egypt).
* **Customer Satisfaction:** Average CSAT score and impact of delayed shipping on reviews.

---

## 📊 Dashboard Previews - *[Coming Soon]*
*(Screenshots of the final Power BI Dashboard pages will be added here upon completion)*

---

## 🚀 How to Navigate this Repository
1. `Dataset/`: Contains the original raw CSV files (Olist) and the custom mapping dictionaries (`Geography_Mapping.xlsx`, `product_category_mapping.csv`).
   * **Note:** The raw Brazilian E-Commerce public dataset by Olist is not hosted in this repository due to size limits. You can download it directly from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
2. `SQL_Scripts/`: Contains the full database schema extraction and the manual queries used for data cleaning, table creation, and datatype transformation in SQL Server.
3. `PowerBI_File/`: Contains the `DEPI Final Graduation Project.pbix` (Download to interact with the model).

---
*Created as a Final Graduation Project for the Data Analytics - Microsoft Power BI Specialist Track.*
