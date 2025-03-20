
  
-- 1. Count the number of employees in each department
-- This query groups employees by department_id and counts how many employees exist in each.
SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;

-- 2. Find the average salary in each department
-- This query calculates the average salary for employees in each department.
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- 3. Find the maximum and minimum salary in each department
-- This query finds the highest and lowest salaries for each department.
SELECT department_id, MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM employees
GROUP BY department_id;

-- 4. Find the total salary paid in each department
-- This query sums up all employee salaries in each department.
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- 5. Count the number of employees in each job role
-- This query counts the number of employees who have the same job role.
SELECT job_id, COUNT(*) AS total_employees
FROM employees
GROUP BY job_id;

-- 6. Find the average salary for each job role
-- This query calculates the average salary for employees in each job role.
SELECT job_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY job_id;

-- 7. Find the maximum salary for each job role
-- This query finds the highest salary assigned to employees for each job role.
SELECT job_id, MAX(salary) AS max_salary
FROM employees
GROUP BY job_id;

-- 8. Find the minimum salary for each job role
-- This query finds the lowest salary assigned to employees for each job role.
SELECT job_id, MIN(salary) AS min_salary
FROM employees
GROUP BY job_id;

-- 9. Find the total salary paid for each job role
-- This query calculates the total salary payout for employees in each job role.
SELECT job_id, SUM(salary) AS total_salary
FROM employees
GROUP BY job_id;

-- 10. Count the number of employees hired in each year
-- This query extracts the year from the hire_date and counts employees hired in each year.
SELECT EXTRACT(YEAR FROM hire_date) AS hire_year, COUNT(*) AS total_employees
FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY hire_year;

-- 11. Find the total salary paid in each location
-- This query sums up the total salary per location by joining employees with department locations.
SELECT d.location_id, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.location_id;

-- 12. Find the number of employees in each manager's team
-- This query counts the employees who report to each manager.
SELECT manager_id, COUNT(*) AS team_size
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

-- 13. Find the highest salary for each manager
-- This query finds the highest salary among employees reporting to each manager.
SELECT manager_id, MAX(salary) AS max_salary
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

-- 14. Find the average salary for each manager's team
-- This query calculates the average salary of employees reporting to each manager.
SELECT manager_id, AVG(salary) AS avg_salary
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

-- 15. Count the number of employees hired in each month of the year
-- This query extracts the month from hire_date and counts how many employees were hired in each month.
SELECT EXTRACT(MONTH FROM hire_date) AS hire_month, COUNT(*) AS total_hired
FROM employees
GROUP BY EXTRACT(MONTH FROM hire_date)
ORDER BY hire_month;

-- 16. Find the department with the highest total salary
-- This query finds the department that pays the highest total salary by sorting in descending order.
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY total_salary DESC
FETCH FIRST 1 ROW ONLY;

-- 17. Find the job role with the highest average salary
-- This query finds the job role with the highest average salary by sorting in descending order.
SELECT job_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY job_id
ORDER BY avg_salary DESC
FETCH FIRST 1 ROW ONLY;

-- 18. Find the number of employees in each city
-- This query counts the number of employees per city, assuming departments are linked to locations.
SELECT l.city, COUNT(*) AS total_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
GROUP BY l.city;

-- 19. Find the number of employees who have a commission, grouped by department
-- This query counts employees who receive a commission, grouped by department.
SELECT department_id, COUNT(*) AS employees_with_commission
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;

-- 20. Find the sum of salaries for employees who have a commission, grouped by department
-- This query sums up the salaries of employees who receive a commission, grouped by department.
SELECT department_id, SUM(salary) AS total_salary_with_commission
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;


-- # Oracle SQL Aggregation Questions for Sales History Table

-- 1. Count the number of sales transactions for each product.  
-- 2. Find the average sale amount for each product.  
-- 3. Find the maximum and minimum sale amount for each product.  
-- 4. Find the total revenue generated by each product.  
-- 5. Count the number of sales transactions for each customer.  
-- 6. Find the average sale amount per customer.  
-- 7. Find the highest purchase amount for each customer.  
-- 8. Find the lowest purchase amount for each customer.  
-- 9. Find the total revenue generated by each store location.  
-- 10. Count the number of sales transactions for each region.  
-- 11. Find the total revenue per region.  
-- 12. Find the average sale amount per region.  
-- 13. Count the number of sales per month.  
-- 14. Find the total revenue per month.  
-- 15. Find the product that generated the highest revenue.  
-- 16. Find the most frequently purchased product.  
-- 17. Find the most valuable customer based on total spending.  
-- 18. Find the total revenue per sales channel (e.g., online vs. offline).  
-- 19. Count the number of sales for each payment method.  
-- 20. Find the total revenue generated per payment method.  



