# 📊 Flipkart Sales Data Analysis
An end-to-end data engineering and analytics project focused on 80,000+ Flipkart product listings. This project covers the entire data lifecycle: from raw data cleaning in Python, deep-dive analytical querying in PostgreSQL, to interactive business intelligence in Power BI.

## 🚀 Project Overview
The objective of this project is to analyze pricing dynamics, seller performance, and supply chain efficiency in the e-commerce ecosystem. By leveraging this dataset, we identify top-performing brands, identify "dead stock" inventory, and evaluate delivery performance across different regions in India.

## 🛠️ Tech Stack & Workflow
1. Data Cleaning & Preprocessing (Python)<br>
 ● Tool: Jupyter Notebook (Flipkart_data_analysis.ipynb)<br>
 ● Libraries: Pandas, NumPy, SQLAlchemy<br>
 ● Key Tasks:<br>
    ━ Handled missing values in product attributes (e.g., sizes).<br>
    ━ Standardized pricing and discount calculations.<br>
    ━ Automation: Developed a pipeline to automatically load the cleaned CSV data directly into a PostgreSQL database using SQLAlchemy.

2. Advanced Insights (PostgreSQL)<br>
 ● Tool: PostgreSQL Server (Flipkart sales insights.sql)<br>
 ● Key Techniques: CTEs (Common Table Expressions), Window Functions (DENSE_RANK, FIRST_VALUE), and Complex Joins.<br>
 ● Business Questions Answered:<br>
   ━ Top Brands: Identifying the top 5 revenue-generating brands within every product category.<br>
   ━ Inventory Audit: Pinpointing "Dead Stock" (items listed for 2+ years with high stock but low sales).<br>
   ━ Logistics: Identifying delivery bottlenecks and city-wise top-selling categories.<br>
   ━ Pricing Strategy: Determining the highest and lowest price points per category.<br>

3. Interactive Dashboard (Power BI)<br>
 ● Tool: Power BI Desktop (Flipkart_sales_dashboard.pbit)<br>
 ● Dashboard Structure:<br>
  ━ Page 1: Seller Performance: A focused view on revenue leadership, average delivery timelines, and seller quality ratings.<br>
  ━ Page 2: Category Insights: Analysis of inventory risk (Stock-to-Sales ratio), payment mode preferences (UPI vs. COD), and the impact of discounts on sales volume.<br>

##	📈 Key Insights from the Analysis<br>
1. High-Performance Sellers: UrbanRetails and QuickShop dominate the platform, maintaining high quality (4.0+ rating) even at massive scales.<br>
2. Inventory Health: Identified that the Mobiles and Home & Kitchen categories currently hold the highest "Stock-to-Sales" ratio, indicating a need for targeted marketing.<br>
3. Delivery Efficiency: Average delivery time is stable at 6 days. We built a "Bottleneck Alert" system to flag any seller exceeding 8 days.<br>
4. Payment Trends: Card payments are the primary transaction method, followed by UPI, suggesting a highly digitized customer base.<br>

## 📂 Project Structure & Data Source<br>
Data Source<br>
 ●  Dataset Name: Flipkart Product Dataset<br>
 ● Size: 80,000+ Records<br>
 ● Description: This dataset contains detailed product information including Product Name, Category, Brand, Seller, Price, Units Sold, Ratings, Stock Available, and Delivery Days.<br>
 ● Source: [https://www.kaggle.com/datasets/rohiteng/flipkart-retail-product-dataset]<br>

##	🖼️ Screenshots / Demos
1. Category & Other Details : ![Dashboard Preview](https://github.com/MalayBhunia/Flipkart-Sales-Data-Analysis/blob/main/Screenshot%202026-01-09%20203039.png)
2. Seller Performance Dashboard: ![Dashboard Preview](https://github.com/MalayBhunia/Flipkart-Sales-Data-Analysis/blob/main/Screenshot%202026-01-09%20203411.png)
