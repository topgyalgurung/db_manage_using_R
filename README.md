# Database management project using R

      > fill<-read.csv("/Users/topgyaltsering/Desktop/classes/csci 435 hw/435 midterm/fills16.csv")
      
      > dim(fill)
      
      > head(fill)
    
      > require(sqldf)
        
      > sqldf("select * from fill where clid=176")
 
      > sqldf("select cust,sum(fillQty) as totalVolume from fill group by cust")
     
      > sqldf("select cust,totalVolume from (select cust, sum(fillQty) as totalVolume from fill group by cust) A order by totalVolume desc")
      > sqldf("select cust,totalVolume from (select cust, sum(fillQty) as totalVolume from fill group by cust) A order by totalVolume desc limit 1")   
      > sqldf("select max(totalVolume) from (select sum(fillQty) as totalVolume from fill group by cust)A")
        max(totalVolume)
      
      > sqldf("select cust,sum(fillQty) from fill group by cust having sum(fillQty)=(select max(totalVolume)from (select sum(fillQty) as totalVolume from fill group by cust)A)")

      > sqldf("select *, fillQty *fillPx totalDollar from fill where clid=176")
      
      > sqldf(" select clid, sum(fillQty*fillPx) totalDollar from fill group by clid")
      
      > head(sqldf("select clid,sum(fillQty *fillPx)totalDollar, case when sum(fillQty)>=min(oQty) then 'filled' else 'unfilled' end as status, sum(fillQty* fillPx)/sum(fillQty)avgPx from fill group by clid"),15)
      
      > sqldf("select clid,sum(fillQty*fillPx)totalDollar, 'FILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)>=min(oQty) UNION select clid, sum(fillQty*fillPx) totalDollar,'UNFILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)<min(oQty)")

      > sqldf("select clid, 'FILLED' as status , round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fill group by clid having min (oQty) - sum(fillQty) < 1 UNION select clid, 'UNFILLED' as status , round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fill group by clid having min (oQty) - sum(fillQty) > 0")
      
      > #5)  Generate a report of all orders which have NOT been filled #SUM(partial_fill_qty) < OrderQty.
      
      > sqldf("select clid, 'UNFILLED' as status , oQty, sum(fillQty) as filled, round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fill group by clid having min (oQty) - sum(fillQty) > 0")
      
      > #6) For each order, find the min(fillPx) and max(fillPx) for the partialFills.
      > sqldf("select clid, round(max(fillPx) ,2) highpx, round(min(fillPx),2) lowpx from fill group by clid ")
      > #7) ind the symbol for which the difference between min(fillPx) and max(fillPx) #is smallest?
      > sqldf("select clid from fill where clid in ( select clid from fill group by clid having (max(fillPx) - min(fillPx) ) = ( select max(spread) from (select max(fillPx) - min(fillPx) as spread from fill group by clid) A ))")
      
      > sqldf("select clid from fill where clid in ( select clid from fill group by clid having (max(fillPx) - min(fillPx) ) = ( select max(spread) from (select max(fillPx) - min(fillPx) as spread from fill group by clid) A ))")
      
      > #8) For each customer, generate the total money owed SUM (partial_fill_qty *
      >  # partial_fill_px )
      > sqldf ("select cust, sum(fillQty*fillPx) from fill group by cust ")
      
      > #9) List the customers who transacted the most volume (bot or sold the most
      >  # number of shares, sum(fillqty) for all orders submitted by each customer, and
      >  #then find the customer with the maximum
      > sqldf(" select cust, sum(fillQty) from fill where cust in ( select cust from fill group by cust having sum(fillQty) = ( select max (volume) from ( select sum(fillQty) as volume from fill group by cust ) ) )")
        cust sum(fillQty)
      
      > #10) List the customers who transacted the most in dollar amount (bot or
      >  #sold,sum (fillqty* fillpx) and find the customer(s) with the highest)
      > sqldf(" select cust, round(sum(fillQty*fillPx),2) dollarVolume from fill where cust in ( select cust from fill group by cust having sum(fillQty*fillPx) = ( select max (dollarVolume) from ( select sum(fillQty*fillPx) as dollarVolume from fill group by cust ) ) )")
 
