/*
Name : Zhenhang Ji CWID: 10445682
*/
with
Temp1 as
(select prod, cust, round(avg(quant)) as average, sum(quant) as total, count(quant) as cnt 
 from sales group by cust, prod order by prod),
Temp2 as
(select prod, cust, round(avg(quant)) as Q1_AVG from sales where month <= 3
 group by cust, prod order by prod),
Temp3 as 
(select prod, cust, round(avg(quant)) as Q2_AVG from sales where month > 3 and month < 7
group by cust, prod order by prod),
Temp4 as 
(select prod, cust, round(avg(quant)) as Q3_AVG from sales where month > 6 and month < 10
group by cust, prod order by prod),
Temp5 as
(select prod, cust, round(avg(quant)) as Q4_AVG from sales where month > 9
group by cust, prod order by prod)
select Temp1.cust, Temp1.prod, Q1_AVG, Q2_AVG, Q3_AVG, Q4_AVG, average, total, cnt
from ((((Temp1 natural join Temp2)natural join Temp3) natural join Temp4) natural join Temp5)
order by cust,prod


