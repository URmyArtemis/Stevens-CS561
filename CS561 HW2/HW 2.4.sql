/*
Name : Zhenhang Ji CWID: 10445682
*/
with S as
(SELECT cust,prod,month,sum(quant) FROM sales GROUP BY cust,prod,month),
T as
(select cust,prod,sum(quant) as prod_total from sales group by cust,prod order by cust,prod),
temp1 as
(SELECT s1.cust,s1.prod,s1.month,sum(s2.sum) as month_total FROM S as S1 JOIN S as s2 ON s1.cust=s2.cust AND s1.prod=s2.prod
AND s1.month>=s2.month GROUP BY s1.cust,s1.prod,s1.month ORDER BY s1.cust,s1.prod,s1.month),
temp2 as
(select temp1.cust,temp1.prod,temp1.month as "2/3 purchased by month" from temp1,T
where temp1.month_total > (2.0/3.0 * T.prod_total) and temp1.prod = T.prod and temp1.cust = T.cust
group by temp1.cust,temp1.prod,temp1.month order by cust, prod)

select temp2.cust,temp2.prod,min(temp2."2/3 purchased by month") as "2/3 purchased by month"
from temp2 group by temp2.cust,temp2.prod ORDER BY cust,prod