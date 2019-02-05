.echo on

.output WuChenyu_QueryAssignment2_Output.txt

.header on
.mode columns


.print ""
.print "Student Name: Chenyu Wu"
.print ""

.open 'LG_Sales.db'

.print "Problems 1: "
.print "Generate a tabular report to facilitate performance review of every LG employee who handled customer orders. The query result should display employee information (including ID, name, Job title, Hire Date, Years of employment), total sales volume in dollars and by total number of orders served. The result should be grouped by job title; and descending order of sales volume (say dollars)."
.print "Solution For Q1"
.print ""

Select  LGEMPLOYEE.Emp_Num, Emp_Fname, Emp_Lname, Emp_HireDate, strftime('%Y',Emp_HireDate) as Year, Emp_Title, COUNT(LGEMPLOYEE.Emp_Num) AS Total_Num_Orders, SUM(LGINVOICE.Inv_Total) AS Total_Sale_Vol from LGINVOICE INNER JOIN LGEMPLOYEE ON LGINVOICE.Emp_Num = LGEMPLOYEE.Emp_Num group by LGEMPLOYEE.Emp_Num order by LGEMPLOYEE.Emp_Title, Total_Sale_Vol DESC;

.print "Problems 2: "
.print "Generate a tabular report to facilitate quarterly market performance of LG Sales. The query result should display total sales ($$) for each quarter of every year. The results should be grouped by state and year of sales."
.print "Solution For Q2"
.print ""
select LGCUSTOMER.Cust_State, sum(LGINVOICE.Inv_Total) as Sales_Quarter, strftime('%Y',Inv_Date) as Year, (strftime('%m', Inv_Date)+2)/3 as Quarter
from LGCUSTOMER INNER JOIN LGINVOICE ON LGCUSTOMER.cust_code=LGINVOICE.Cust_Code group by Cust_State, strftime('%Y', Inv_Date), (strftime('%m', Inv_Date)+2)/3;

.print "Problems 3: "
.print "Generate a tabular report to facilitate review of product sales across brands by their type, base material, and functional category. The query result should display product information (including brand: type, name; product: type, base material, category), total sales volume (in dollars, and quantity sold). The results should be grouped by brand type, product characteristics (type, base material, and category)."
.print "Solution For Q3"
.print ""	

select Prod_type, prod_base, prod_category , LGBRAND.BRAND_NAME, LGBRAND.BRAND_TYPE, sum(LGINVOICE.INV_TOTAL) as TOTAL_SALES from LGPRODUCT 
INNER JOIN LGBRAND ON LGPRODUCT.BRAND_ID = LGBRAND.BRAND_ID
INNER JOIN LGLINE ON LGLINE.PROD_SKU = LGPRODUCT.PROD_SKU
INNER JOIN LGINVOICE ON LGLINE.INV_NUM=LGINVOICE.INV_NUM group by LGBRAND.BRAND_TYPE, LGPRODUCT.PROD_TYPE, LGPRODUCT.PROD_BASE, LGPRODUCT.PROD_CATEGORY;


.print "Problems 4: "
.print "LG’s purchasing department has to place procurement orders to restock their warehouse. Identify all the products that have to be restocked by considering the minimum quantity of products as reorder levels [HINT: you need check the condition if quantity on hand has reached the minimum permitted value]. The query result should display all product information and brand information. The result should be grouped by brand type followed by product characteristics (type, base material, and category)."
.print "Solution For Q4"
.print ""	

#Minimum quantity of proucts as reorder levels
#select * from LGPRODUCT
#select * from LGBRAND
#group by brand type, prod_type, prod_base, prod_category
#QOH<MIN

select * from LGPRODUCT INNER JOIN LGBRAND ON 
LGBRAND.BRAND_ID=LGPRODUCT.BRAND_ID AND LGPRODUCT.PROD_QOH<Prod_Min order by
LGBRAND.BRAND_type, LGPRODUCT.PROD_TYPE, LGPRODUCT.PROD_BASE, LGPRODUCT.PROD_CATEGORY;

.output stdout
.echo OFF


#select LGCUSTOMER.Cust_State, sum(LGINVOICE.Inv_Total) as Sales_Quarter, strftime('%Y',Inv_Date) as Year, (strftime('%m', Inv_Date)+2)/3 as Quarter from LGCUSTOMER INNER JOIN LGINVOICE ON LGCUSTOMER.cust_code=LGINVOICE.Cust_Code group by strftime('%Y', Inv_Date), (strftime('%m', Inv_Date)+2)/3, Cust_State;