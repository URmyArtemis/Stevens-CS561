/*
Name : Zhenhang Ji CWID : 10445682
*/
with
Temp1 as
(select month, prod, sum(quant) as s from sales group by month,prod order by month),
Temp2 as
(select month, max(s) as most_pop_q, min(s) as least_pop_q from Temp1 group by month order by month),
Temp3 as
(select Temp1.month, Temp1.prod as most_pop_prod, most_pop_q from Temp1, Temp2 where Temp1.month = Temp2.month and Temp1.s = Temp2.most_pop_q)
select Temp3.month, Temp3.most_pop_prod, Temp3.most_pop_q, Temp1.prod as least_pop_prod, Temp2.least_pop_q 
from Temp1, Temp2, Temp3
where Temp2.month = Temp3.month and Temp1.s = Temp2.least_pop_q




