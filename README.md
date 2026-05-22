# 🛋️ Arkan Home: E-Commerce Data Localization & Power BI Analytics

[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](PowerBI_File)
[![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)](SQL_Scripts)
[![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)](Dataset)
[![Data Analytics](https://img.shields.io/badge/Data_Analytics-00897B?style=for-the-badge&logo=googleanalytics&logoColor=white)](#)

---

## 👥 Team Members

- [Ahmed Magdy](https://github.com/MigzXYZ)
- [Mark Morris](https://github.com/markmorrismaher)
- [Mai Ibrahim](https://github.com/maiibrahim335)
- [Aisha Taha](https://github.com/Aisha-taha)

---

## 📌 Project Overview

**Arkan Home** is an end-to-end data analytics and business intelligence project that transforms the public **Brazilian Olist E-Commerce dataset** into a localized Egyptian market scenario for a simulated **Home Decor and Furniture** e-commerce business.

The project demonstrates a complete analytics workflow, starting from raw transactional data preparation, SQL Server modeling, and ETL processing, then moving into Power BI data modeling, DAX measures, dashboard design, and business storytelling.

The final deliverable is an interactive Power BI dashboard that analyzes executive performance, sales behavior, logistics efficiency, customer satisfaction, and growth opportunities.

---

## 🎯 Business Problem

Large, realistic e-commerce datasets tailored to the Egyptian market are limited. This creates a challenge for analysts and business teams who want to practice market-specific analysis around:

- Customer distribution by Egyptian cities and regions
- Delivery performance across local geographic areas
- Product category performance in the home decor and furniture niche
- Payment behavior and revenue patterns
- Customer satisfaction and review scores
- Growth trends, forecasting, and discount scenario analysis

**Arkan Home** addresses this gap by localizing the Olist dataset into a realistic Egyptian e-commerce case study.

---

## 🧠 Project Objectives

The project was designed to answer practical business questions such as:

- Which cities generate the highest number of orders and revenue?
- Which product categories drive the largest share of sales?
- What are the strongest order patterns by weekday and hour?
- How do dispatch and delivery delays affect customer satisfaction?
- Which categories generate the highest number of low reviews?
- How does payment method distribution affect sales behavior?
- What is the expected revenue trend based on historical performance?
- What is the direct impact of discount scenarios on projected revenue?

---

## 🗂️ Dataset

The project is based on the public **Brazilian E-Commerce Public Dataset by Olist**, combined with custom localization mapping files created for this project.

### Included Mapping Files

The repository includes custom mapping files used to localize the original dataset:

| File | Purpose |
|---|---|
| `Geography_Mapping.xlsx` | Maps original Olist state codes to Egyptian cities, governorates, and regions |
| `product_category_mapping.csv` | Maps original product categories into business-friendly home decor and furniture categories |
| `State Flags.csv` | Adds Egyptian city/governorate flag image URLs for Power BI visuals |

### Required Olist Source Files

To rebuild the full database from scratch, download the original Olist dataset from Kaggle and import the following files into SQL Server:

| Source File | Purpose |
|---|---|
| `olist_orders_dataset.csv` | Order status and order timeline data |
| `olist_order_items_dataset.csv` | Order item-level product, seller, price, freight, and shipping data |
| `olist_order_payments_dataset.csv` | Payment methods, installments, and payment values |
| `olist_order_reviews_dataset.csv` or `.xlsx` | Review scores and review timestamps |
| `olist_products_dataset.csv` | Product category and product attributes |
| `olist_customers_dataset.csv` | Customer IDs and customer geographic references |
| `olist_sellers_dataset.csv` | Seller IDs and seller geographic references |

> The original Olist dataset can be downloaded from Kaggle:  
> https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

## 🏗️ Data Architecture

The project follows a data warehousing approach.

Raw transactional tables are first loaded into SQL Server, then transformed into an optimized analytical model using a **Star Schema**.

### Final Analytical Model

The model is built around one central fact table:

- `Fact_Sales`

Supported by the following dimension tables:

- `Dim_Product`
- `Dim_Geography`
- `Dim_PaymentMethod`
- `Dim_Status`
- `Dim_Date` *(created inside Power BI)*

### Supporting Mapping Tables

The SQL ETL process creates mapping tables to replace long text identifiers with integer surrogate keys:

- `map_order`
- `map_product`
- `map_seller`
- `map_customer_unique`

This improves model readability and makes the Power BI model easier to manage.

---

## 🧩 Data Model Notes

### Fact Table Grain

The grain of `Fact_Sales` is:

> **One row per order item**

This means a single order may appear more than once if it contains multiple products.

Because of this grain, order-level measures such as total orders, cancellation rate, late delivery rate, returning customers, and orders per customer should be calculated using distinct order logic.

### Main Modeling Decisions

- Long source IDs were replaced with integer surrogate keys.
- Product categories were localized into clearer home decor and furniture categories.
- Geography was localized into Egyptian cities and regions.
- Customer and seller geography are both represented through `Dim_Geography`.
- Payment methods were cleaned and consolidated.
- Review scores were aggregated at order level before being added to the fact table.
- Fact-level date fields were preserved for purchase, approval, dispatch, delivery, estimated delivery, and shipping limit analysis.

---

## 🧹 SQL Server ETL Pipeline

The SQL scripts are stored in the `SQL_Scripts/` folder.

### 1. Raw Table Setup

```sql
01_Arkan_Home_DB_Setup_and_Cleaning.sql
```

Creates the raw staging tables used to import the Olist source data and mapping files.

### 2. Product Column Cleaning

```sql
02_Arkan_Home_DB_Setup_and_Cleaning.sql
```

Cleans blank product attribute values and converts product-related numeric fields into integer data types.

### 3. Star Schema Builder

```sql
03_Arkan_Home_DB_ETL_and_StarSchema_Builder.sql
```

Builds the final analytical schema by creating:

- Surrogate key mapping tables
- `Dim_Geography`
- `Dim_Product`
- `Dim_PaymentMethod`
- `Dim_Status`
- `Fact_Sales`

It also joins orders, order items, products, customers, sellers, payments, reviews, geography mapping, and state flag data into the final fact table.

<img width="1278" height="839" alt="image" src="https://github.com/user-attachments/assets/c1cb10d3-59cf-4387-a23b-6fc4792ff59f" />

---

## 🔄 Main Transformation Rules

| Area | Transformation |
|---|---|
| Geography | Original Olist state codes are mapped to Egyptian cities, governorates, and regions |
| Product Categories | Original product categories are translated into home decor and furniture business categories |
| Payment Methods | `boleto`, `not_defined`, blank, and null payment types are consolidated into `cash` |
| Reviews | Review scores are aggregated by order before being joined to the fact table |
| Dates | Purchase, approval, dispatch, delivery, estimated delivery, and shipping limit dates are preserved for time analysis |
| Keys | Long text identifiers are replaced with integer surrogate keys |
| Logistics | Dispatch days, delivery days, late dispatch, late delivery, and delay metrics are analyzed in Power BI |
| Scenario Analysis | A discount what-if parameter is used to simulate direct revenue impact |

---

## 📊 Power BI Dashboard

The final Power BI file is stored in the `PowerBI_File/` folder:

```text
DEPI Graduation Project - Arkan Home.pbix
```

The report is designed as an interactive business dashboard with navigation buttons, slicers, bookmarks, tooltip pages, help overlays, metric switching, and what-if analysis.

### Dashboard Pages

| Page | Purpose |
|---|---|
| Landing Page | Branded entry page with About and Contact sections |
| Executive Overview | High-level business KPIs and city-level performance map |
| Sales | Sales KPIs, order heatmap, payment analysis, AOV trend, and Pareto category analysis |
| Logistics | Dispatch, delivery, late delivery, freight, regional delays, and operational performance |
| Customer Behavior | Customer acquisition, retention, CSAT, reviews, spending segments, and city performance |
| Growth Analysis | YTD revenue, rolling 3-month revenue, forecasting, revenue drivers, discount impact, and category performance |

<img width="1547" height="867" alt="image" src="https://github.com/user-attachments/assets/e8439d37-06fd-437a-ad65-e1110a7ec2a1" />

---

## 📈 Key Metrics

### Executive Metrics

- Total Orders
- Total Sellers
- Total Customers
- Total Revenue
- YTD Performance
- Previous Year Comparison
- City-level Performance

<img width="1547" height="867" alt="image" src="https://github.com/user-attachments/assets/afefcb09-a6ce-46d9-9136-7937053458a3" />

### Sales Metrics

- Total Sales
- Average Order Value
- Basket Size
- Daily Average Orders
- Cancelled Rate
- Sales by Payment Method
- Pareto Analysis by Category
- AOV Trend by Year and Month
- Orders by Weekday and Hour

<img width="1546" height="870" alt="image" src="https://github.com/user-attachments/assets/895b1e0b-56b3-4a1c-8118-3d1cdc338455" />

### Logistics Metrics

- Average Dispatch Days
- Late Dispatch Count
- Late Dispatch %
- Average Delivery Days
- Late Deliveries Count
- Late Delivery %
- Average Delay Days by Region
- Freight by City
- On-time vs Late Delivery

<img width="1546" height="869" alt="image" src="https://github.com/user-attachments/assets/6f0d929d-817d-4e49-8d1f-39c98f64713e" />

### Customer Metrics

- Total Customers
- Returning Customers
- Orders per Customer
- Average Customer Spend
- Average CSAT Score
- Review Score Distribution
- Customer Spending Segments
- CSAT vs Delivery Delay

<img width="1549" height="870" alt="image" src="https://github.com/user-attachments/assets/81cb11b9-cca3-4b66-9dfd-47855f777454" />

### Growth Metrics

- YTD Revenue
- Rolling 3-Month Revenue
- Revenue Trend and Forecast
- Revenue Drivers
- Discount Impact Scenario
- Revenue Gap
- Category Performance Matrix
- Top Categories with 1-Star Reviews

<img width="1547" height="866" alt="image" src="https://github.com/user-attachments/assets/83c4702e-a76f-4e6a-9445-be3aec06a86c" />

---

## 🧭 Dashboard Interactivity

The Power BI report includes:

- Year and month slicers
- Side menu navigation
- Page navigation buttons
- Help overlay for analytical pages
- Metric switch between revenue and orders
- Heatmap toggle to show or hide order numbers
- Discount what-if parameter
- Revenue forecasting visual
- Decomposition tree for revenue drivers
- Tooltip pages for additional context
- Play-axis visual for time-based category performance analysis

---

## 🛠️ Tools & Technologies

| Tool | Usage |
|---|---|
| SQL Server | Raw table creation, cleaning, ETL, and Star Schema building |
| Power BI | Dashboard design, data modeling, reporting, and interactivity |
| Power Query | Report-layer transformations and model preparation |
| DAX | KPIs, time intelligence, segmentation, and scenario analysis |
| Excel / CSV | Source files and custom mapping files |
| GitHub | Version control and project documentation |

---

## 📁 Repository Structure

```text
Arkan-Home-ECommerce-Data-Analysis/
│
├── Dataset/
│   ├── Geography_Mapping.xlsx
│   ├── product_category_mapping.csv
│   └── State Flags.csv
│
├── SQL_Scripts/
│   ├── 01_Arkan_Home_DB_Setup_and_Cleaning.sql
│   ├── 02_Arkan_Home_DB_Setup_and_Cleaning.sql
│   └── 03_Arkan_Home_DB_ETL_and_StarSchema_Builder.sql
│
├── PowerBI_File/
│   └── DEPI Graduation Project - Arkan Home.pbix
│
├── LICENSE
└── README.md
```

---

## 🚀 How to Rebuild the Project

### Step 1: Create the SQL Server database

Create a new SQL Server database named:

```sql
Home_Arkan_DB
```

### Step 2: Download the original Olist dataset

Download the source files from Kaggle and prepare the custom mapping files from the `Dataset/` folder.

### Step 3: Create the raw staging tables

Run:

```sql
01_Arkan_Home_DB_Setup_and_Cleaning.sql
```

### Step 4: Import the raw and mapping files

Import the Olist source files and custom mapping files into their matching SQL Server tables.

### Step 5: Clean product numeric columns

Run:

```sql
02_Arkan_Home_DB_Setup_and_Cleaning.sql
```

### Step 6: Build the Star Schema

Run:

```sql
03_Arkan_Home_DB_ETL_and_StarSchema_Builder.sql
```

### Step 7: Open the Power BI file

Open:

```text
PowerBI_File/DEPI Graduation Project - Arkan Home.pbix
```

Refresh the data connection if needed.

---

## ✅ Final Outcome

The final project demonstrates:

- SQL Server database preparation
- ETL pipeline design
- Star Schema modeling
- Data localization for the Egyptian market
- Power BI data modeling
- DAX KPI development
- Interactive dashboard design
- E-commerce sales analysis
- Logistics performance analysis
- Customer behavior analysis
- Growth and scenario analysis
- Business storytelling through data visualization

---

## 📌 Project Type

Created as a final graduation project for the:

**Data Analytics - Microsoft Power BI Specialist Track**

---

## 📄 License

This project is licensed under the MIT License.
