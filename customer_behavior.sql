select * from customer_shopping
limit 5;

select gender ,sum(purchase_amount) as revenue
from customer_shopping
group by gender
order by  revenue desc;


select customer_id,purchase_amount
from customer_shopping
where discount_applied = 'Yes' and purchase_amount >= (select avg(purchase_amount)
from customer_shopping)
limit 5;




select item_purchased,round(avg(review_rating::numeric),2) as avg_review
from customer_shopping
group by item_purchased
order by avg_review desc
limit 5;

select shipping_type, round(avg(purchase_amount),2) as avg_purchaseamount,sum(purchase_amount) as total_purchase
from customer_shopping
where shipping_type in ('Express','Standard')
group by shipping_type


select subscription_status,count(customer_id) as totalcustomers,round(avg(purchase_amount),2) as Avg_purchas,sum(purchase_amount) as Total_purchase
from customer_shopping
group by subscription_status
order by Avg_purchas,Total_purchase desc;



with customer_type as(
select customer_id,previous_purchases,
case
	when previous_purchases = 1 then 'New'
	when previous_purchases between 2 and 10 then 'Returning'
	else 'Loyal'
	end as customer_segment
from customer_shopping)
select customer_segment,count(customer_id) as no_of_customers
from customer_type
group by customer_segment
order by no_of_customers desc;


#top 3 purchased products within each category

with item_count as
(
select category,item_purchased,count(customer_id) as total_customers,
row_number() over (partition by category order by count(customer_id) desc) as item_rank 
from customer_shopping
group by item_purchased,category
)
select item_purchased,category,item_rank
from item_count
where item_rank <= 3;



#contribution of each age group

select age_group,sum(purchase_amount) as total_purchase
from customer_shopping
group by age_group
order by total_purchase desc;



