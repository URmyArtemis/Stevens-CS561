/*
Name : Zhenhang Ji CWID : 10445672
*/
with Temp as
(select cust, prod from sales group by cust, prod),
Temp1 as
(select cust, prod, round(avg(quant)) as q1_avg, 1 as q from sales
where month between 1 and 3 group by cust,prod),
Temp2 as
(select cust, prod, round(avg(quant)) as q2_avg, 2 as q from sales
where month between 4 and 6 group by cust,prod),
Temp3 as
(select cust, prod, round(avg(quant)) as q3_avg, 3 as q from sales
where month between 7 and 9 group by cust,prod),
Temp4 as
(select cust, prod, round(avg(quant)) as q4_avg, 4 as q from sales
where month between 10 and 12 group by cust,prod),
t1 as 
(select Temp.cust, Temp.prod, temp1.q, Temp1.q1_avg from Temp full outer join Temp1
on Temp.cust = Temp1.cust and Temp.prod=Temp1.prod),
part1 as
(select t1.cust, t1.prod, 1 as q, null as before_avg, Temp2.q2_avg as after_avg from t1 left outer join Temp2
on t1.cust = Temp2.cust and t1.prod = Temp2.prod),
t2 as 
(select Temp.cust, Temp.prod, Temp2.q, Temp2.q2_avg from Temp full outer join Temp2
on Temp.cust = Temp2.cust and Temp.prod=Temp2.prod),
part12 as	
(select t2.cust, t2.prod, 2 as q, Temp1.q1_avg as before_avg from t2 full outer join Temp1
on t2.cust = Temp1.cust and t2.prod = Temp1.prod),
part2 as
(select part12.cust, part12.prod, 2 as q, part12.before_avg, Temp3.q3_avg as after_avg from part12 full outer join Temp3
on part12.cust = Temp3.cust and part12.prod = Temp3.prod),
t3 as 
(select Temp.cust, Temp.prod, Temp3.q, Temp3.q3_avg from Temp full outer join Temp3
on Temp.cust = Temp3.cust and Temp.prod=Temp3.prod),
part23 as	
(select t3.cust, t3.prod, 3 as q, Temp2.q2_avg as before_avg from t3 full outer join Temp2
on t3.cust = Temp2.cust and t3.prod = Temp2.prod),
part3 as
(select part23.cust, part23.prod, 3 as q, part23.before_avg, Temp4.q4_avg as after_avg from part23 full outer join Temp4
on part23.cust = Temp4.cust and part23.prod = Temp4.prod),
t4 as 
(select Temp.cust, Temp.prod, Temp4.q, Temp4.q4_avg from Temp full outer join Temp4
on Temp.cust = Temp.cust and Temp.prod=Temp4.prod),
part4 as	
(select t4.cust, t4.prod, 4 as q, Temp3.q3_avg as before_avg, null as after_avg from t4 full outer join Temp3
on t4.cust = Temp3.cust and t4.prod = Temp3.prod)
(select cust,prod, q, before_avg, cast(@after_avg as varchar(10)) as after_avg from part1)
union
(select cust,prod,q,cast(@before_avg as varchar(10)) as before_avg, cast(@after_avg as varchar(10)) as after_avg from part2)
union
(select cust,prod,q,cast(@before_avg as varchar(10)) as before_avg, cast(@after_avg as varchar(10)) as after_avg from part3)
union
(select cust,prod,q,cast(@before_avg as varchar(10)) as before_avg, after_avg from part4)
order by cust,prod,q


