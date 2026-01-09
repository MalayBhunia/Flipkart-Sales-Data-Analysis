----------- Flipkart E-Commerce Insights: Advanced Data Analysis with PostgreSQL --------------------------------
"
--> Project Overview :
   This dataset contains 80,000 detailed records of product listings from Flipkart, covering a wide range of categories
   like Fashion, Electronics, and Home Kitchen. It provides a holistic view of the e-commerce ecosystem by tracking
   pricing dynamics, sales volume, seller performance, and logistics data (such as shipping weights and delivery timelines).
   The data is designed to facilitate advanced SQL analysis, including trend forecasting, revenue optimization, and supply chain efficiency audits.
"

--> Insights :
"Q1. Find the top 5 brands in each product category based on total revenue (final_price * units_sold).
    Display the category, brand, total revenue, and their rank within that category"
	Select * From flipkart;

	with brand_revenue as (
		Select category, brand,
		Floor(sum(final_price * units_sold)) as Total_revenue,
		Dense_rank() Over(Partition By category Order By Floor(sum(final_price * units_sold)) Desc) as Rank
		From flipkart
		Group By 1, 2
	)
	Select category, brand, Total_revenue, Rank
	From brand_revenue
	Where Rank <=5

"Q2. Identify products that have been listed for more than 2 years (from current date) but have sold fewer 
	than 50 units despite having a stock level higher than 500."
	Select * From flipkart;

	Select product_name, category, 
		   stock_available,
		   units_sold, 
		   listing_date,
		   Age(current_date, listing_date) as listiong_age
	From flipkart
	Where (Current_date - Interval '2 years') > listing_date
	AND stock_available > 500 
	AND units_sold < 50
	Order By category,stock_available DESC;

"Q3. Calculate the average delivery days for each seller, but only for those sellers who have sold more
    than 1,000 units in total. Sort the result to find the fastest sellers."
	Select * From flipkart;

	Select seller, 
		   Round(AVG(delivery_days),2) as avg_delivery_days,
		   SUM(units_sold) as Total_units_sold
	From flipkart
	Group By seller
	Having SUM(units_sold) >1000
	Order By avg_delivery_days;
	
"Q4. The payment_modes column contains comma-separated values (e.g., 'COD, CARD').
	Write a query to find the total number of products that support 'COD' versus those that do not."
	Select * From flipkart;

	Select 
		Case 
			When payment_modes like '%COD%' Then 'Support_COD'
			Else 'Prepaid_only'
		End as payment_cat,
		Count(*) as product_count,
		Round(Count(*) * 100.0 / sum(count(*)) over(),2) as percentage
	From flipkart
	Group By 1
	
"Q5. Find the month-over-month growth (in percentage) of the number of products listed in the year 2022."
	Select * From flipkart;
	
	With months_record as (
		Select 
			To_char(listing_date, 'YYYY-MM') as month, --Fatch months and years
			Count(*) as Current_prod_count, -- Current month Total Product count
			LAG(Count(*)) Over(Order By To_char(listing_date, 'YYYY-MM')) as Prev_prod_count, -- Previous month product_count
			-- Current month - Previous month
			(Count(8) - LAG(Count(*)) Over(Order By To_char(listing_date, 'YYYY-MM'))) as Absalute_diff 
		From flipkart
		Where To_char(listing_date, 'YYYY')='2022'
		Group By 1
		Order By 1
	)
	Select month,
		  current_prod_count,
		  prev_prod_count,
		  absalute_diff,
		  -- Find per month percentage growth
		  Round(((absalute_diff)::Numeric / NULLIF(prev_prod_count,0))*100,2) as percentage_growth
	From months_record
	
"Q6. Categorize products into three groups based on discount_percent: 'No Discount' (0%), 'Moderate' (1-20%), and 'High' (>20%). 
    Calculate the average rating and total units sold for each group to see if higher discounts lead to better ratings or more sales."
    Select * From flipkart; 

	Select
		Case
			When discount_percent > 20 Then 'High (>20%)'
			When discount_percent Between 1 and 20 Then 'Moderate (1-20%)'
			Else 'No Discount (0%)'
		End as Discount_category,
		Round(AVG(rating)::Numeric,2) as Avg_rating,
		Sum(units_sold) as Total_units_sold,
		Count(*) as Product_count
	From flipkart
	Group By 1
	Order By Total_units_sold Desc;
"
--> Insight: The Moderate Discount group (1-20%) drives the highest total sales volume, contributing nearly 1  00 million 
   units. This suggests that even a small 'psychological' discount is highly effective at moving inventory compared to no discount at all
"

"Q7. For each city, identify sellers whose personal average rating is below the overall average seller rating for that 
    specific city. Provide the city name, the seller's name, their average rating and the city's overall average rating."
	Select * From flipkart;

	With city_wise_avg as (
		Select seller_city,
			   AVG(seller_rating) as Avg_citywise_rating
		From flipkart
		Group By 1
	),
	seller_wise_avg as(
		Select seller_city,
			   seller,
			   Avg(seller_rating) as avg_seller_rating
		From flipkart
		Group By 1,2		
	)
	Select Distinct s.seller_city,
		   s.seller,
		   Round((s.avg_seller_rating)::Numeric,3) as seller_avg,
		   Round((c.Avg_citywise_rating)::Numeric,3)as city_avg
	From seller_wise_avg s
	JOIN city_wise_avg c
	ON s.seller_city = c.seller_city
	Where s.avg_seller_rating < c.Avg_citywise_rating
	Order By 1 ASC, 2 ASC

	
"Q Calculate the average product_score for products that are returnable (is_returnable = True) vs. non-returnable.
    Furthermore, group these by return_policy_days (e.g., 0, 7, 10, 15, 30 days) to see if longer return windows correlate with higher scores."
	Select * From flipkart;

	Select return_policy_days,
	       is_returnable,
		   Round(AVG(product_score)::Numeric,2) as avg_product_score,
		   Count(*) as Product_count
	From flipkart
	Group By 1,2
	Order By return_policy_days;	
	
"Q9. For every seller_city, identify which product category has the highest total units_sold. Display the city, 
    the top category, and the total units sold in that category."
	Select * From flipkart;

	With top_cat as(
		Select seller_city,
			   category,
			   Sum(units_sold) as Total_unit,
			   Dense_rank() Over(Partition By seller_city Order By Sum(units_sold) Desc) as dense_rank
		From flipkart
		Group By seller_city, category
	)
	Select seller_city,
		   category as Top_category,
		   Total_unit
	From top_cat
	Where dense_rank =1
	Order By total_unit Desc;

"Q10. For each category, find the product with the highest price and the product with the lowest price.
     Display the category name, max_price_product_name, and min_price_product_name in a single row per category."
    Select * From flipkart;

	With High_Low_products as(
		Select category,
			  product_name,
			  final_price,
			  First_value(product_name) Over(Partition By category Order By final_price DESC) as max_price_product_name,
			  First_value(product_name) Over(Partition By category Order By final_price ASC) as min_price_product_name
		From flipkart
	)
	Select category,
		   max_price_product_name,
		   min_price_product_name
	From High_Low_products
	Group By 1,2,3
	Order By 1 ASC
