/*
Name : Zhenhang Ji CWID : 10445682
*/
with
Temp1 as (select prod, month, sum(quant) as s from sales group by prod, month order by prod,month),
Temp2 as (select prod, max(s) as most_fav, min(s) as least_fav from Temp1 group by prod),
Temp3 as (select Temp1.prod, Temp1.month as most_fav_month, Temp2.most_fav from Temp1,Temp2 where Temp1.prod = Temp2.prod and Temp1.s = Temp2.most_fav)
select Temp3.prod, Temp3.most_fav_month, Temp1.month as least_fav_month
from Temp1, Temp2, Temp3
where Temp2.prod = Temp3.prod and Temp1.s = Temp2.least_fav