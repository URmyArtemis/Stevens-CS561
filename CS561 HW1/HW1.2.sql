with
Temp as
(select cust, prod from sales group by cust, prod),
NY1 as 
(select cust, prod, max(quant) as NY_MAX from sales where state = 'NY' group by cust, prod),
NY2 as 
(select NY1.cust as customer, NY1.prod as product, NY1.NY_MAX, day as NY_MAX_DAY, month as NY_MAX_MONTH, year as NY_MAX_YEAR from sales, NY1 where NY1.prod = sales.prod and NY1.cust = sales.cust and NY1.NY_MAX = sales.quant),
NJ1 as
(select cust, prod, min(quant) as NJ_MIN from sales where state = 'NJ' and year > 2000 group by cust, prod),
NJ2 as
(select NJ1.cust as customer, NJ1.prod as product, NJ1.NJ_MIN, day as NJ_MIN_DAY, month as NJ_MIN_MONTH, year as NJ_MIN_YEAR from sales, NJ1 where NJ1.prod = sales.prod and NJ1.cust = sales.cust and NJ1.NJ_MIN = sales.quant),
CT1 as
(select cust, prod, min(quant) as CT_MIN from sales where state = 'CT' and year > 2000 group by cust, prod),
CT2 as
(select CT1.cust as customer, CT1.prod as product, CT1.CT_MIN, day as CT_MIN_DAY, month as CT_MIN_MONTH, year as CT_MIN_YEAR from sales, CT1 where CT1.prod = sales.prod and CT1.cust = sales.cust and CT1.CT_MIN = sales.quant),
NY as
(select temp.cust, temp.prod, NY2.NY_MAX, ny_max_month, ny_max_day, ny_max_year from NY2 full outer join Temp on Temp.cust=NY2.customer and Temp.prod=NY2.product),
NJ as
(select temp.cust, temp.prod, NJ2.NJ_MIN, nj_min_month, nj_min_day, nj_min_year from NJ2 full outer join Temp on Temp.cust=NJ2.customer and Temp.prod=NJ2.product),
CT as
(select temp.cust, temp.prod, CT2.CT_MIN, ct_min_month, ct_min_day, ct_min_year from CT2 full outer join Temp on Temp.cust=CT2.customer and Temp.prod=CT2.product)
select *
from ((NY natural join NJ) natural join CT)
order by cust


