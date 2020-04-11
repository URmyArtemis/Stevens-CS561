/*
Name : Zhenhang Ji CWID : 10445672
*/
with 
Temp1 as
(select max(quant) as MAX_Q, min(quant) as MIN_Q, round(avg(quant)) as AVG_Q, prod as prod from sales group by prod),

Temp2 as
(select Temp1.prod, Temp1.max_q, sales.cust as max_cust, Temp1.min_q, Temp1.avg_q, day as max_day ,month as max_month, year as max_year,state as max_state
from Temp1, sales
where Temp1.prod = sales.prod and Temp1.max_q = sales.quant)

select Temp2.prod, Temp2.max_q, Temp2.max_cust, Temp2.max_month, Temp2.max_day, Temp2.max_year, Temp2.max_state, Temp2.min_q, 
sales.cust as min_cust, sales.month as min_month, sales.day as min_day, sales.year as min_year, sales.state as min_state,
Temp2.avg_q
from Temp2, sales
where Temp2.prod = sales.prod and Temp2.min_q = sales.quant