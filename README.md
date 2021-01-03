# Database management project using R

      > fill<-read.csv("/Users/topgyaltsering/Desktop/classes/csci 435 hw/435 midterm/fills16.csv")
      
      > dim(fill)
      
      > head(fill)
    
      > require(sqldf)
      Loading required package: sqldf
      Loading required package: gsubfn
      Loading required package: proto
      Could not load tcltk.  Will use slower R code instead.
      Loading required package: RSQLite
      Warning message:
      In doTryCatch(return(expr), name, parentenv, handler) :
        unable to load shared object '/Library/Frameworks/R.framework/Resources/modules//R_X11.so':
        dlopen(/Library/Frameworks/R.framework/Resources/modules//R_X11.so, 6): Library not loaded: /opt/X11/lib/libSM.6.dylib
        Referenced from: /Library/Frameworks/R.framework/Resources/modules//R_X11.so
        Reason: image not found
        
      > sqldf("select * from fill where clid=176")
        clid cust symbol side oQty fillQty fillPx execid
      1  176  C10     BA SELL 5000     556 355.98     38
      2  176  C10     BA SELL 5000     667 385.44     77
      3  176  C10     BA SELL 5000     111 360.11    131
      4  176  C10     BA SELL 5000    1001 360.11    144
      5  176  C10     BA SELL 5000     334 359.35    147
      6  176  C10     BA SELL 5000     445 389.99    173
      7  176  C10     BA SELL 5000     222 367.47    211
      8  176  C10     BA SELL 5000     890 360.11    222
      9  176  C10     BA SELL 5000     778 354.65    298
 
      > sqldf("select cust,sum(fillQty) as totalVolume from fill group by cust")
         cust totalVolume
      1    C1       17000
      2   C10       13002
      3    C2       11498
      4    C3       20011
      5    C4        5500
      6    C5       15004
      7    C6       12008
      8    C7        3000
      9    C8       24009
      10   C9       18502
     
      > sqldf("select cust,totalVolume from (select cust, sum(fillQty) as totalVolume from fill group by cust) A order by totalVolume desc")
         cust totalVolume
      1    C8       24009
      2    C3       20011
      3    C9       18502
      4    C1       17000
      5    C5       15004
      6   C10       13002
      7    C6       12008
      8    C2       11498
      9    C4        5500
      10   C7        3000
      
      > sqldf("select cust,totalVolume from (select cust, sum(fillQty) as totalVolume from fill group by cust) A order by totalVolume desc limit 1")
        cust totalVolume
      1   C8       24009
      
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
 
