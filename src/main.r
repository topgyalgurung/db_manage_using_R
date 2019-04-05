//Consider a schema as follows:
Supplier (SID, NAME, SUPPLIER_ZIP)
Parts (PID, PNAME, PTYPE,SID) 
Sale (SHOPID, PID, SALES_DATE, QTY) 
Shop (SHOPID, SHOP_ZIP) 

Use VOLUME = SUM(QTY)

SUPPLIER with SID supplies this part. PTYPE can be Perishable or Imperishable.There can be more than one SHOPID per SHOP_ZIP and more than one Supplier per Supplier_ZIP. More than one supplier can supply a PARTS.

//import data
