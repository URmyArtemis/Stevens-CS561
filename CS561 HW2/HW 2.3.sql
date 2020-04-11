/*
Name : Zhenhang Ji CWID: 10445682
*/
with temp1 as
(select prod,quant,count(quant) as cnt from sales 
group by prod,quant order by prod,quant),
temp2 as
(select t1.prod, t1.quant, sum(t2.cnt) as rownum
from temp1 t1 join temp1 t2 on t1.prod=t2.prod  
where t1.quant>=t2.quant group by t1.prod,t1.quant order by prod),
temp3 as
(select prod, ((count(quant)+1)/2) as rownum from temp1 group by prod)
select prod as "PRODUCT", quant as "MEDIAN QUANT" 
from temp2 natural join temp3