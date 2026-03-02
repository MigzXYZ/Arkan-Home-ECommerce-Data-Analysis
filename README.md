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

## 🏗️ Data Architecture & Star Schema
To ensure maximum performance (using the VertiPaq engine), the data was modeled into a highly optimized **Star Schema**:

* **Fact Table (`Fact_Sales`):** The core table containing transaction details, standardized EGP pricing, freight values, and review scores (Granularity: Item level).
* **Dimensions:**
    * `Dim_Products`: Filtered for the Home Décor niche with localized English names.
    * `Dim_Customers`: Mapped to Egyptian Governorates and Cities.
    * `Dim_Sellers`: Mapped to Egyptian Governorates and Cities.
    * `Dim_Date`: Role-playing dimension for purchase, shipping, and delivery tracking.

<img width="1775" height="810" alt="image" src="https://github.com/user-attachments/assets/32abbbea-f943-42d2-a26a-e27d16eed015" />


---

## ⚙️ Data Engineering & ETL (Power Query)
Key transformations applied to synthesize the Egyptian market environment:

1.  **Geographic Localization:** Mapped Brazilian state codes to 27 Egyptian Governorates (e.g., SP -> Cairo, RJ -> Alexandria) to enable accurate local logistics analysis.
2.  **Strategic Currency Translation (BRL to EGP):** Instead of a flat exchange rate, a **Conditional Inflation Multiplier** was applied based on product categories to reflect realistic 2024/2026 Egyptian market prices:
    * *High-Ticket Items* (e.g., Modern Sofa Sets, Chandeliers): Multiplied by **65**.
    * *Mid-Ticket Items* (e.g., Gallery Wall Art, Ergonomic Chairs): Multiplied by **35**.
    * *Low-Ticket Items* (e.g., Scented Candles, Organizers): Multiplied by **15**.
3.  **Data Flattening:** Aggregated Payments and Reviews datasets (`Group By` order_id) and merged them into the `Fact_Sales` table to avoid duplication and eliminate many-to-many relationships.

---

## 📈 Key Performance Indicators (DAX) - *[Work In Progress]*
The upcoming analytical phase will focus on developing advanced DAX measures to answer critical business questions across three main perspectives:

* **Sales Performance:** Total Revenue (EGP), Average Order Value (AOV), and Best-Selling Categories.
* **Logistics & Supply Chain:** Average Delivery Delay, Freight Cost vs. Product Price ratio across different Governorates (e.g., Cairo vs. Upper Egypt).
* **Customer Satisfaction:** Average CSAT score and impact of delayed shipping on reviews.

---

## 📊 Dashboard Previews - *[Coming Soon]*
*(Screenshots of the final Power BI Dashboard pages will be added here upon completion)*
* **Page 1:** Executive Summary & Sales KPIs.
* **Page 2:** Logistics & Delivery Performance.
* **Page 3:** Customer Demographics & Satisfaction.

---

## 🚀 How to Navigate this Repository
1.  `Dataset/`: Contains the original raw CSV files (Olist) and the custom mapping dictionaries (`Geography_Mapping.xlsx`, `product_category_mapping.csv`).
   * **Note:** The raw Brazilian E-Commerce public dataset by Olist is not hosted in this repository due to size limits. You can download it directly from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
3. `SQL_Scripts/`: Contains the full database schema extraction and the manual queries used for data cleaning, table creation, and datatype transformation in SQL Server.
4. `PowerBI_File/`: Contains the `DEPI Final Graduation Project.pbix` (Download to interact with the model).

---
*Created as a Final Graduation Project for the Data Analytics - Microsoft Power BI Specialist Track.*
