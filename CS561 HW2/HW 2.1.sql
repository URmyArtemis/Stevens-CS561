/*
Name : Zhenhang Ji CWID : 10445672
*/
with Temp1 as
(select cust,prod,state,round(avg(quant)) as cust_avg from sales group by cust,prod,state order by cust),
Temp2 as
(select Temp1.cust,Temp1.prod,Temp1.state,round(avg(quant)) as other_state_avg from Temp1,sales 
 where Temp1.prod = sales.prod and Temp1.cust = sales.cust and Temp1.state != sales.state
group by Temp1.cust,Temp1.prod,Temp1.state order by Temp1.cust),
Temp3 as
(select Temp1.cust,Temp1.prod,Temp1.state,round(avg(quant)) as other_prod_avg from Temp1,sales 
 where Temp1.prod != sales.prod and Temp1.cust = sales.cust and Temp1.state = sales.state
group by Temp1.cust,Temp1.prod,Temp1.state order by Temp1.cust)
select * from(Temp1 natural full outer join Temp2 natural full outer join Temp3)
order by cust,prod