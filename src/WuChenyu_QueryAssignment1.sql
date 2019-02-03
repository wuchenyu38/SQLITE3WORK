.echo on

.output WuChenyu_QueryAssignment1_Output.txt

.header on
.mode columns


.print ""
.print "Student Name: Chenyu Wu"
.print ""

.open 'LG_Sales.db'
.print "Problems 1: Generate a tabular report of all departments and their information in the company. The output should be in alphabetical order of department names."
.print ""
.print "Solution For Q1"
.print ""
SELECT * from LGDEPARTMENT order by Dept_Name;
.print ""
.print "Problems 2: Generate a tabular report of all employee information. Ensure that your query result includes department’s name. Sort the results by Department name, and employee’s last name and first name."
.print ""
.print "Solution For Q2"
.print ""
SELECT LGEMPLOYEE.emp_num, emp_fname, emp_lname, emp_email, emp_phone, emp_hiredate, emp_title, emp_comm, LGEMPLOYEE.dept_num, dept_name from LGEMPLOYEE INNER JOIN LGDEPARTMENT ON LGEMPLOYEE.Dept_Num=LGDEPARTMENT.Dept_Num order by Dept_Name, SUBSTR(Emp_Fname,1,1), Emp_Lname;

.print ""
.print "Problems 3: Generate a tabular report of all products and their information that have Water as product base and are of either Primer or Top Coat category. Display the result in the sorted order of product type and product category."
.print ""
.print "Solution For Q3"
.print ""

SELECT * from LGPRODUCT where (Prod_Base = "Water" and Prod_Category = "Primer") or (Prod_Base = "Water" and Prod_Category = "Top Coat" ) order by Prod_Type, Prod_Category;

.print ""
.print "Problems 4: Generate a tabular report of all employees hired during January 1, 2006 to December 31, 2010. Sort the output by year of hire, last name, and first name. The result should include columns last name, first name, title, email, hire date, and year of hire."
.print ""
.print "Solution For Q4"
.print ""

ALTER TABLE LGEMPLOYEE
ADD COLUMN Emp_HireYear Date;
UPDATE LGEMPLOYEE SET
Emp_HireYear = strftime('%Y',Emp_HireDate);

SELECT emp_lname, emp_fname,emp_title, emp_email,emp_hiredate,emp_hireyear FROM LGEMPLOYEE WHERE Emp_HireDate between "2006-01-01" and "2010-12-31" order by emp_hireyear, SUBSTR(emp_lname,1,1), emp_fname;

.print ""
.print "Problems 5: Generate a tabular report of all Invoices corresponding to purchases made by customers from Massachusetts during 2015."
.print ""
.print "Solution For Q5"
.print ""

SELECT * FROM LGINVOICE INNER JOIN LGCUSTOMER ON LGINVOICE.Cust_Code=LGCUSTOMER.Cust_Code where (LGCUSTOMER.CUST_STATE = "MA") and (LGINVOICE.Inv_Date between "2015-01-01"and "2015-12-31");
.output stdout
.echo OFF