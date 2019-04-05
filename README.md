# MySQLproject

      fill<-read.csv("/Users/topgyaltsering/Desktop/classes/csci 435 hw/435 midterm/fills16.csv",     sep=",",stringAsFactors=FALSE)
      Error in read.table(file = file, header = header, sep = sep, quote = quote,  : 
        unused argument (stringAsFactors = FALSE)
      > fill<-read.csv("/Users/topgyaltsering/Desktop/classes/csci 435 hw/435 midterm/fills16.csv", sep=",",stringSAsFactors=FALSE)
      Error in read.table(file = file, header = header, sep = sep, quote = quote,  : 
        unused argument (stringSAsFactors = FALSE)
      > fills<-read.csv("C:/Users/admin/Desktop/fills.csv",sep=",",stringsAsFactors=FALSE)
      Error in file(file, "rt") : cannot open the connection
      In addition: Warning message:
      In file(file, "rt") :
        cannot open file 'C:/Users/admin/Desktop/fills.csv': No such file or directory
      > fill<-read.csv("/Users/topgyaltsering/Desktop/classes/csci 435 hw/435 midterm/fills16.csv")
      > dim(fills)
      Error: object 'fills' not found
      > dim(fill)
      [1] 337   8
      > head(fill)
        clid cust symbol side oQty fillQty    fillPx execid
      1  133   C8      F  BUY 2000      95   8.48753      1
      2  138   C1    SBS  BUY 5000     273   7.47000      2
      3  269   C8     BA  BUY 2000     154 386.37000      3
      4  193   C7    BAC SELL 1500      71  27.92000      4
      5  127  C10      C SELL 5000     536  69.95000      5
      6  209   C2    IBM  BUY 2000    1000 140.85001      6
      > sqldf("select * from fill where clid=176")
      Error in sqldf("select * from fill where clid=176") : 
        could not find function "sqldf"
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
      > sqldf("select cust,sum(fillQty) as totalVolume from fills group by cust")
      Error in result_create(conn@ptr, statement) : no such table: fills
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
      > sqldf("select cust,totalVolume from (select cust, sum(fillQty) as totalVolume from fills group by cust) A order by totalVolume desc")
      Error in result_create(conn@ptr, statement) : no such table: fills
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
      1            24009
      > sqldf("select cust,sum(fillQty) from fill group by cust having sum(fillQty)=(select max(totalVolume)from (select sum(fillQty) as totalVolume from fill group by cust)A)")
        cust sum(fillQty)
      1   C8        24009
      > sqldf("select *, fillQty *fillPx totalDollar from fill where clid=176")
        clid cust symbol side oQty fillQty fillPx execid totalDollar
      1  176  C10     BA SELL 5000     556 355.98     38   197924.89
      2  176  C10     BA SELL 5000     667 385.44     77   257088.48
      3  176  C10     BA SELL 5000     111 360.11    131    39972.21
      4  176  C10     BA SELL 5000    1001 360.11    144   360470.09
      5  176  C10     BA SELL 5000     334 359.35    147   120022.90
      6  176  C10     BA SELL 5000     445 389.99    173   173545.55
      7  176  C10     BA SELL 5000     222 367.47    211    81578.34
      8  176  C10     BA SELL 5000     890 360.11    222   320497.89
      9  176  C10     BA SELL 5000     778 354.65    298   275917.70
      > sqldf(" select clid, sum(fillQty*fillPx) totalDollar from fill group by clid")
         clid totalDollar
      1   103    24655.27
      2   104    11315.00
      3   105    74042.50
      4   110  1333433.40
      5   111   105045.62
      6   112   690886.94
      7   114  3749749.51
      8   115   144078.98
      9   122   718251.70
      10  123   143169.79
      11  124   299479.88
      12  127   349836.85
      13  131  2627041.99
      14  133    17646.57
      15  134    25502.84
      16  138    36372.59
      17  146   232170.00
      18  149    19080.00
      19  163    10622.95
      20  168    59960.00
      21  174   553585.00
      22  176  1827018.04
      23  181   277966.64
      24  193    43936.12
      25  199    19172.50
      26  209   277916.36
      27  212    24798.26
      28  215    19790.31
      29  216   136036.20
      30  222   528893.61
      31  223  1801789.81
      32  227    19244.39
      33  228    43705.69
      34  237   117379.38
      35  239   103894.53
      36  240    18715.88
      37  242    66750.00
      38  243    18063.06
      39  244   307567.47
      40  247   133339.21
      41  251   739441.07
      42  268    36689.68
      43  269   747287.46
      44  277   232847.65
      45  278    64358.33
      46  284    63485.00
      47  285   793569.99
      48  287  1846591.99
      49  292   658231.11
      50  295   284744.63
      > head(sqldf("select clid,sum(fillQty *fillPx)totalDollar, case when sum(fillQty)>=min(oQty) then 'filled' else 'unfilled' end as status, sum(fillQty* fillPx)/sum(fillQty)avgPx from fill group by clid"),15)
         clid totalDollar   status       avgPx
      1   103    24655.27 unfilled   12.339975
      2   104    11315.00   filled    7.543333
      3   105    74042.50   filled   37.021250
      4   110  1333433.40   filled  266.473502
      5   111   105045.62   filled   70.030413
      6   112   690886.94   filled  138.177388
      7   114  3749749.51   filled 1874.874757
      8   115   144078.98   filled   28.810034
      9   122   718251.70   filled  359.125852
      10  123   143169.79   filled   28.633958
      11  124   299479.88   filled   59.848098
      12  127   349836.85 unfilled   69.995369
      13  131  2627041.99   filled 1751.361328
      14  133    17646.57 unfilled    8.832118
      15  134    25502.84 unfilled   12.764185
      > #fdkjladjgkdsg
      > #comments
      > sqldf("select clid,sum(fillQty*fillPx)totalDollar, 'FILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)>=min(oQty) UNION select clid, sum(fillQty*fillPx) totalDollar,'UNFILLED" as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)<min(oQty)"")
      Error: unexpected symbol in "sqldf("select clid,sum(fillQty*fillPx)totalDollar, 'FILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)>=min(oQty) UNION select clid, sum(fill"
      > sqldf("select clid,sum(fillQty*fillPx)totalDollar, 'FILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)>=min(oQty) UNION select clid, sum(fillQty*fillPx) totalDollar,'UNFILLED" as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)<min(oQty)")
      Error: unexpected symbol in "sqldf("select clid,sum(fillQty*fillPx)totalDollar, 'FILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)>=min(oQty) UNION select clid, sum(fill"
      > sqldf("select clid,sum(fillQty*fillPx)totalDollar, 'FILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)>=min(oQty) UNION select clid, sum(fillQty*fillPx) totalDollar,'UNFILLED" as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)<min(oQty)")
      Error: unexpected symbol in "sqldf("select clid,sum(fillQty*fillPx)totalDollar, 'FILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)>=min(oQty) UNION select clid, sum(fill"
      > sqldf("select clid,sum(fillQty*fillPx)totalDollar, 'FILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)>=min(oQty) UNION select clid, sum(fillQty*fillPx) totalDollar,'UNFILLED' as status, sum(fillQty*fillPx)/sum(fillQty) avgPx from fill group by clid having sum(fillQty)<min(oQty)")
         clid totalDollar   status       avgPx
      1   103    24655.27 UNFILLED   12.339975
      2   104    11315.00   FILLED    7.543333
      3   105    74042.50   FILLED   37.021250
      4   110  1333433.40   FILLED  266.473502
      5   111   105045.62   FILLED   70.030413
      6   112   690886.94   FILLED  138.177388
      7   114  3749749.51   FILLED 1874.874757
      8   115   144078.98   FILLED   28.810034
      9   122   718251.70   FILLED  359.125852
      10  123   143169.79   FILLED   28.633958
      11  124   299479.88   FILLED   59.848098
      12  127   349836.85 UNFILLED   69.995369
      13  131  2627041.99   FILLED 1751.361328
      14  133    17646.57 UNFILLED    8.832118
      15  134    25502.84 UNFILLED   12.764185
      16  138    36372.59   FILLED    7.274518
      17  146   232170.00   FILLED  154.779999
      18  149    19080.00   FILLED   12.720000
      19  163    10622.95   FILLED    7.063132
      20  168    59960.00   FILLED   29.980000
      21  174   553585.00 UNFILLED  370.043450
      22  176  1827018.04   FILLED  365.111519
      23  181   277966.64   FILLED   55.593329
      24  193    43936.12   FILLED   29.290746
      25  199    19172.50   FILLED   12.781667
      26  209   277916.36   FILLED  138.888737
      27  212    24798.26   FILLED   12.374382
      28  215    19790.31   FILLED   13.193541
      29  216   136036.20   FILLED   67.984110
      30  222   528893.61 UNFILLED  264.711519
      31  223  1801789.81   FILLED  360.357962
      32  227    19244.39   FILLED   12.803985
      33  228    43705.69   FILLED   29.078969
      34  237   117379.38   FILLED   58.689691
      35  239   103894.53   FILLED   69.078810
      36  240    18715.88 UNFILLED   12.510615
      37  242    66750.00   FILLED   44.500000
      38  243    18063.06   FILLED   12.042038
      39  244   307567.47   FILLED  153.706882
      40  247   133339.21   FILLED   66.636288
      41  251   739441.07 UNFILLED  370.090625
      42  268    36689.68   FILLED    7.332070
      43  269   747287.46   FILLED  372.897936
      44  277   232847.65   FILLED  155.231769
      45  278    64358.33   FILLED   12.858807
      46  284    63485.00   FILLED   12.697000
      47  285   793569.99   FILLED  158.713998
      48  287  1846591.99 UNFILLED  369.466185
      49  292   658231.11   FILLED  131.540989
      50  295   284744.63   FILLED  142.088140
      > # Generate a report for each customer order, if it has been filled and the average
      >  price at which it has been filled.
      Error: unexpected symbol in " price at"
      > # Generate a report for each customer order, if it has been filled and the # average price at which it has been filled.
      > sqldf("select clid, CASE WHEN min(oQty) - sum(fillQty) < 1 THEN 'FILLED' WHEN min(oQty) - sum(fillQty) > 0 THEN 'UNFILLED' END as status , round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fills03 group by clid ")
      Error in result_create(conn@ptr, statement) : no such table: fills03
      > sqldf("select clid, CASE WHEN min(oQty) - sum(fillQty) < 1 THEN 'FILLED' WHEN min(oQty) - sum(fillQty) > 0 THEN 'UNFILLED' END as status , round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fill group by clid ")
         clid   status   AvgPx
      1   103 UNFILLED   12.34
      2   104   FILLED    7.54
      3   105   FILLED   37.02
      4   110   FILLED  266.47
      5   111   FILLED   70.03
      6   112   FILLED  138.18
      7   114   FILLED 1874.87
      8   115   FILLED   28.81
      9   122   FILLED  359.13
      10  123   FILLED   28.63
      11  124   FILLED   59.85
      12  127 UNFILLED   70.00
      13  131   FILLED 1751.36
      14  133 UNFILLED    8.83
      15  134 UNFILLED   12.76
      16  138   FILLED    7.27
      17  146   FILLED  154.78
      18  149   FILLED   12.72
      19  163   FILLED    7.06
      20  168   FILLED   29.98
      21  174 UNFILLED  370.04
      22  176   FILLED  365.11
      23  181   FILLED   55.59
      24  193   FILLED   29.29
      25  199   FILLED   12.78
      26  209   FILLED  138.89
      27  212   FILLED   12.37
      28  215   FILLED   13.19
      29  216   FILLED   67.98
      30  222 UNFILLED  264.71
      31  223   FILLED  360.36
      32  227   FILLED   12.80
      33  228   FILLED   29.08
      34  237   FILLED   58.69
      35  239   FILLED   69.08
      36  240 UNFILLED   12.51
      37  242   FILLED   44.50
      38  243   FILLED   12.04
      39  244   FILLED  153.71
      40  247   FILLED   66.64
      41  251 UNFILLED  370.09
      42  268   FILLED    7.33
      43  269   FILLED  372.90
      44  277   FILLED  155.23
      45  278   FILLED   12.86
      46  284   FILLED   12.70
      47  285   FILLED  158.71
      48  287 UNFILLED  369.47
      49  292   FILLED  131.54
      50  295   FILLED  142.09
      > sqldf("select clid, 'FILLED' as status , round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fill group by clid having min (oQty) - sum(fillQty) < 1 UNION select clid, 'UNFILLED' as status , round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fill group by clid having min (oQty) - sum(fillQty) > 0")
         clid   status   AvgPx
      1   103 UNFILLED   12.34
      2   104   FILLED    7.54
      3   105   FILLED   37.02
      4   110   FILLED  266.47
      5   111   FILLED   70.03
      6   112   FILLED  138.18
      7   114   FILLED 1874.87
      8   115   FILLED   28.81
      9   122   FILLED  359.13
      10  123   FILLED   28.63
      11  124   FILLED   59.85
      12  127 UNFILLED   70.00
      13  131   FILLED 1751.36
      14  133 UNFILLED    8.83
      15  134 UNFILLED   12.76
      16  138   FILLED    7.27
      17  146   FILLED  154.78
      18  149   FILLED   12.72
      19  163   FILLED    7.06
      20  168   FILLED   29.98
      21  174 UNFILLED  370.04
      22  176   FILLED  365.11
      23  181   FILLED   55.59
      24  193   FILLED   29.29
      25  199   FILLED   12.78
      26  209   FILLED  138.89
      27  212   FILLED   12.37
      28  215   FILLED   13.19
      29  216   FILLED   67.98
      30  222 UNFILLED  264.71
      31  223   FILLED  360.36
      32  227   FILLED   12.80
      33  228   FILLED   29.08
      34  237   FILLED   58.69
      35  239   FILLED   69.08
      36  240 UNFILLED   12.51
      37  242   FILLED   44.50
      38  243   FILLED   12.04
      39  244   FILLED  153.71
      40  247   FILLED   66.64
      41  251 UNFILLED  370.09
      42  268   FILLED    7.33
      43  269   FILLED  372.90
      44  277   FILLED  155.23
      45  278   FILLED   12.86
      46  284   FILLED   12.70
      47  285   FILLED  158.71
      48  287 UNFILLED  369.47
      49  292   FILLED  131.54
      50  295   FILLED  142.09
      > #5)  Generate a report of all orders which have NOT been filled #SUM(partial_fill_qty) < OrderQty.
      >  sqldf("select clid, 'UNFILLED' as status , oQty, sum(fillQty) as filled, round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fills03 group by clid having min (oQty) - sum(fillQty) > 0")
      Error in result_create(conn@ptr, statement) : no such table: fills03
      > sqldf("select clid, 'UNFILLED' as status , oQty, sum(fillQty) as filled, round(sum(fillQty * fillPx)/sum(fillQty),2) as AvgPx from fill group by clid having min (oQty) - sum(fillQty) > 0")
        clid   status oQty filled  AvgPx
      1  103 UNFILLED 2000   1998  12.34
      2  127 UNFILLED 5000   4998  70.00
      3  133 UNFILLED 2000   1998   8.83
      4  134 UNFILLED 2000   1998  12.76
      5  174 UNFILLED 1500   1496 370.04
      6  222 UNFILLED 2000   1998 264.71
      7  240 UNFILLED 1500   1496  12.51
      8  251 UNFILLED 2000   1998 370.09
      9  287 UNFILLED 5000   4998 369.47
      > #6) For each order, find the min(fillPx) and max(fillPx) for the partialFills.
      > sqldf("select clid, round(max(fillPx) ,2) highpx, round(min(fillPx),2) lowpx from fill group by clid ")
         clid  highpx   lowpx
      1   103   12.56   12.09
      2   104    7.58    7.47
      3   105   38.74   34.56
      4   110  272.57  256.32
      5   111   72.62   63.80
      6   112  153.75  124.79
      7   114 1971.31 1764.03
      8   115   29.24   28.46
      9   122  365.50  354.65
      10  123   30.27   26.59
      11  124   62.90   48.83
      12  127   72.62   64.21
      13  131 1768.70 1719.36
      14  133    9.16    8.49
      15  134   13.90   12.14
      16  138    7.71    6.41
      17  146  154.78  154.78
      18  149   12.72   12.72
      19  163    7.58    6.41
      20  168   29.98   29.98
      21  174  389.99  354.65
      22  176  389.99  354.65
      23  181   57.83   49.21
      24  193   30.43   27.38
      25  199   13.18   12.17
      26  209  140.85  129.10
      27  212   13.90   11.25
      28  215   13.84   11.50
      29  216   69.71   66.59
      30  222  272.57  256.32
      31  223  386.47  350.05
      32  227   13.61   11.30
      33  228   30.23   28.32
      34  237   63.23   50.88
      35  239   71.93   63.80
      36  240   13.61   11.30
      37  242   44.50   44.50
      38  243   13.13   11.25
      39  244  159.33  145.37
      40  247   69.21   64.21
      41  251  392.30  350.05
      42  268    7.56    6.68
      43  269  392.30  356.26
      44  277  157.33  153.35
      45  278   13.84   11.61
      46  284   13.61   12.10
      47  285  159.42  154.92
      48  287  386.47  350.05
      49  292  140.85  124.79
      50  295  151.31  124.79
      > #7) ind the symbol for which the difference between min(fillPx) and max(fillPx) #is smallest?
      > sqldf("select clid from fills03 where clid in ( select clid from fills03 group by clid having (max(fillPx) - min(fillPx) ) = ( select max(spread) from (select max(fillPx) - min(fillPx) as spread from fills03 group by clid) A ))")
      Error in result_create(conn@ptr, statement) : no such table: fills03
      > sqldf("select clid from fill where clid in ( select clid from fill group by clid having (max(fillPx) - min(fillPx) ) = ( select max(spread) from (select max(fillPx) - min(fillPx) as spread from fill group by clid) A ))")
         clid
      1   114
      2   114
      3   114
      4   114
      5   114
      6   114
      7   114
      8   114
      9   114
      10  114
      > sqldf("select clid from fill where clid in ( select clid from fill group by clid having (max(fillPx) - min(fillPx) ) = ( select max(spread) from (select max(fillPx) - min(fillPx) as spread from fill group by clid) A ))")
         clid
      1   114
      2   114
      3   114
      4   114
      5   114
      6   114
      7   114
      8   114
      9   114
      10  114
      > #8) For each customer, generate the total money owed SUM (partial_fill_qty *
      >  # partial_fill_px )
      > sqldf ("select cust, sum(fillQty*fillPx) from fills03 group by cust ")
      Error in result_create(conn@ptr, statement) : no such table: fills03
      > sqldf ("select cust, sum(fillQty*fillPx) from fill group by cust ")
         cust sum(fillQty*fillPx)
      1    C1           3955839.1
      2   C10           2261667.9
      3    C2            597873.1
      4    C3           5713547.8
      5    C4            363420.5
      6    C5           1354519.3
      7    C6           1343947.6
      8    C7            276106.1
      9    C8           6106288.0
      10   C9            505942.5
      > #9) List the customers who transacted the most volume (bot or sold the most
      >  # number of shares, sum(fillqty) for all orders submitted by each customer, and
      >  #then find the customer with the maximum
      > sqldf(" select cust, sum(fillQty) from fill where cust in ( select cust from fill group by cust having sum(fillQty) = ( select max (volume) from ( select sum(fillQty) as volume from fill group by cust ) ) )")
        cust sum(fillQty)
      1   C8        24009
      > #10) List the customers who transacted the most in dollar amount (bot or
      >  #sold,sum (fillqty* fillpx) and find the customer(s) with the highest)
      > sqldf(" select cust, round(sum(fillQty*fillPx),2) dollarVolume from fills03 where cust in ( select cust from fills03 group by cust having sum(fillQty*fillPx) = ( select max (dollarVolume) from ( select sum(fillQty*fillPx) as dollarVolume from fill group by cust ) ) )")
      Error in result_create(conn@ptr, statement) : no such table: fills03
      > sqldf(" select cust, round(sum(fillQty*fillPx),2) dollarVolume from fill where cust in ( select cust from fill group by cust having sum(fillQty*fillPx) = ( select max (dollarVolume) from ( select sum(fillQty*fillPx) as dollarVolume from fill group by cust ) ) )")
        cust dollarVolume
      1   C8      6106288
