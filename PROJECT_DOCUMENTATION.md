# Arkan Home Project Documentation

## 1. Project Planning

### Project Name
**Arkan Home: E-Commerce Data Localization & Power BI Analytics**

### Project Type
Final Graduation Project for the **Data Analytics - Microsoft Power BI Specialist Track**.

### Project Idea
Arkan Home is a simulated Egyptian e-commerce business specialized in **Home Decor and Furniture**. The project transforms the public Brazilian Olist E-Commerce dataset into a localized Egyptian market case study, then uses SQL Server and Power BI to build an end-to-end business intelligence solution.

### Main Objective
The project aims to transform raw transactional e-commerce data into decision-ready insights through:

- Data cleaning and preparation
- Egyptian market localization
- SQL Server database design
- ETL and Star Schema modeling
- Power BI data modeling
- DAX KPI development
- Interactive dashboard design
- Business storytelling and decision support

### Business Questions
The project was designed to answer questions such as:

- Which cities and regions generate the highest revenue and order volume?
- Which product categories drive most of the business performance?
- What are the peak order days and hours?
- How do dispatch and delivery delays affect customer satisfaction?
- Which categories generate the highest number of 1-star reviews?
- What is the impact of discount scenarios on projected revenue?
- Which logistics areas require operational improvement?
- How is revenue expected to perform in the upcoming period?

### Scope
The project covers five main business areas:

1. Executive Overview
2. Sales Analysis
3. Logistics Analysis
4. Customer Behavior Analysis
5. Growth Analysis

### Deliverables
- SQL Server database scripts
- Localized mapping datasets
- Power BI dashboard file
- GitHub repository documentation
- Project documentation file
- Dashboard screenshots and/or presentation export

---

## 2. Stakeholder Analysis

### Primary Stakeholders

| Stakeholder | Interest | Dashboard Value |
|---|---|---|
| Executive Management | Overall business performance and growth | Executive KPIs, revenue, orders, customers, and city performance |
| Sales Team | Sales trends, AOV, category performance, and payment behavior | Sales page, Pareto analysis, payment method distribution, and order heatmap |
| Logistics Team | Dispatch, delivery, delay, freight, and regional performance | Logistics page, late delivery metrics, delay days, and destination city analysis |
| Customer Experience Team | Customer satisfaction, reviews, repeat customers, and city-level behavior | Customer behavior page, CSAT, review score distribution, and CSAT vs delivery |
| Growth / Strategy Team | Forecasting, revenue drivers, discount scenarios, and category opportunities | Growth page, revenue trend, forecast, what-if discount impact, and category matrix |

### Stakeholder Needs
The dashboard was designed to support both operational monitoring and strategic decision-making. It allows each stakeholder group to focus on the metrics most relevant to their role while keeping the full business picture connected through one analytical model.

---

## 3. Dataset and Localization

### Source Dataset
The project uses the public **Brazilian E-Commerce Public Dataset by Olist**.

### Main Source Tables
- Orders
- Order Items
- Payments
- Reviews
- Products
- Customers
- Sellers

### Custom Mapping Files
To adapt the dataset into a realistic Egyptian business scenario, the project uses:

| File | Purpose |
|---|---|
| `Geography_Mapping.xlsx` | Maps original Olist state codes to Egyptian cities, governorates, and regions |
| `product_category_mapping.csv` | Maps original product categories into home decor and furniture categories |
| `State Flags.csv` | Adds Egyptian city/governorate image URLs for Power BI visuals |

### Localization Logic
The localization process transformed the original dataset from a Brazilian e-commerce case into an Egyptian market simulation by:

- Mapping original geographic codes to Egyptian cities and regions
- Reclassifying product categories into home decor and furniture business categories
- Adding geographic flag image URLs
- Translating the business context into a local e-commerce scenario

---

## 4. Database Design

### Database Name
`Home_Arkan_DB`

### Raw Staging Tables
The raw data was first loaded into SQL Server staging tables:

- `olist_orders`
- `olist_order_items`
- `olist_order_payments`
- `olist_order_reviews`
- `olist_products`
- `olist_customers`
- `olist_sellers`
- `geography_mapping`
- `product_categories_mapping`
- `state_flags`

### Why SQL Server Was Used
SQL Server was used to perform the heavier data preparation and modeling steps before loading the data into Power BI. This helped create a cleaner analytical model and reduce complexity in the reporting layer.

---

## 5. ETL Process

### Step 1: Raw Data Loading
Raw CSV and Excel files were imported into SQL Server staging tables.

### Step 2: Data Cleaning
The cleaning process included:

- Handling blank values in product attribute columns
- Converting numeric product columns from text to integer
- Cleaning and consolidating payment methods
- Preparing date and timeline columns for analysis

### Step 3: Surrogate Key Mapping
Long source identifiers were converted into integer surrogate keys using mapping tables:

- `map_order`
- `map_product`
- `map_seller`
- `map_customer_unique`

This made the model cleaner and easier to analyze.

### Step 4: Dimension Building
The following dimensions were created:

- `Dim_Product`
- `Dim_Geography`
- `Dim_PaymentMethod`
- `Dim_Status`

### Step 5: Fact Table Building
The main analytical table `Fact_Sales` was created by joining orders, order items, customers, sellers, products, payments, reviews, geography, and order status data.

### Fact Table Grain
The grain of `Fact_Sales` is:

> One row per order item

This means an order can appear more than once if it contains multiple products. Therefore, order-level measures must use distinct order logic.

---

## 6. Star Schema Design

### Central Fact Table
- `Fact_Sales`

### Dimension Tables
- `Dim_Product`
- `Dim_Geography`
- `Dim_PaymentMethod`
- `Dim_Status`
- `Dim_Date` *(created in Power BI)*

### Modeling Logic
The model follows a Star Schema structure where the fact table is at the center and dimension tables filter it through one-to-many relationships.

### Benefits
- Cleaner relationships
- Easier DAX calculations
- Better reporting performance
- Clear separation between business entities
- Easier dashboard maintenance

---

## 7. Power BI Modeling

After building the SQL Star Schema, the final tables were loaded into Power BI.

### Power BI Enhancements
Additional model-level fields and tables were created for reporting, including:

- `Dim_Date`
- Price and freight values in EGP
- Total price calculation
- Date-only fields
- Order hour and day name
- Metric switch table
- Discount what-if parameter
- Toggle table for heatmap display
- Customer segmentation table

### Relationship Design
The main active analytical relationship is based on purchase date, while operational date fields such as delivery and dispatch dates are used in logistics calculations.

<img width="1278" height="839" alt="image" src="https://github.com/user-attachments/assets/c1cb10d3-59cf-4387-a23b-6fc4792ff59f" />

---

## 8. Dashboard UI/UX Design

### Design Theme
The dashboard uses a consistent Arkan Home visual identity with:

- Green and white color palette
- Furniture and home decor branding
- Side navigation menu
- Rounded cards and clear KPI layout
- Page-level slicers for year and month
- Help overlays to guide users
- Clear separation between analytical sections

<img width="1547" height="867" alt="image" src="https://github.com/user-attachments/assets/e8439d37-06fd-437a-ad65-e1110a7ec2a1" />

### Dashboard Pages

| Page | Purpose |
|---|---|
| Landing Page | Branded entry page with About and Contact sections |
| Executive Overview | High-level KPIs and city-level performance |
| Sales | Sales KPIs, heatmap, payment analysis, AOV, and Pareto analysis |
| Logistics | Dispatch, delivery, freight, delay, and regional performance |
| Customer Behavior | Customers, retention, CSAT, reviews, and spending segments |
| Growth Analysis | YTD revenue, rolling revenue, forecast, revenue drivers, discount scenario, and category performance |

### Interactivity
The dashboard includes:

- Page navigation
- Year and month slicers
- Metric switching between revenue and orders
- Heatmap number toggle
- Discount what-if scenario
- Tooltip pages
- Forecast visual
- Decomposition tree
- Play axis for time-based category performance

---

## 9. Key Metrics

### Executive Metrics
- Total Orders
- Total Sellers
- Total Customers
- Total Revenue
- YTD Performance
- Previous Year Comparison
- City-level Performance

### Sales Metrics
- Total Sales
- AOV
- Basket Size
- Daily Average Orders
- Cancelled Rate
- Payment Method Distribution
- Pareto Category Analysis
- Orders by Day and Hour

### Logistics Metrics
- Average Dispatch Days
- Late Dispatch Count
- Late Dispatch %
- Average Delivery Days
- Late Deliveries
- Late Delivery %
- Average Delay Days
- Freight by City
- On-Time vs Late Delivery

### Customer Metrics
- Total Customers
- Returning Customers
- Orders per Customer
- Average Customer Spend
- Average CSAT Score
- Review Score Distribution
- Customer Spending Segments
- CSAT vs Delivery Delay

### Growth Metrics
- YTD Revenue
- Rolling 3-Month Revenue
- Revenue Trend and Forecast
- Revenue Drivers
- Discount Impact Scenario
- Revenue Gap
- Category Performance Matrix
- Top Categories with 1-Star Reviews

---

## 10. Final Outcome

The final project delivers a complete BI solution that demonstrates:

- Raw data understanding
- Market localization
- SQL database design
- ETL pipeline development
- Star Schema modeling
- Power BI modeling
- DAX measure development
- Interactive dashboard design
- Business analysis and storytelling

The main strength of the project is that it does not only visualize data. It engineers the data first, localizes it to a business context, models it properly, and then turns it into decision-ready insights.

---

## 11. Repository Link

https://github.com/MigzXYZ/Arkan-Home-ECommerce-Data-Analysis
