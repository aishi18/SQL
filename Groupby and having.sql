-- 1. Count employees per department
SELECT department_id, COUNT(*) AS total_employees
FROM hr.employees
GROUP BY department_id;

-- 2. Total salary per department
SELECT department_id, SUM(salary) AS total_salary
FROM hr.employees
GROUP BY department_id;

-- 3. Average salary per department
SELECT department_id, AVG(salary) AS avg_salary
FROM hr.employees
GROUP BY department_id;

-- 4. Minimum salary per department
SELECT department_id, MIN(salary) AS min_salary
FROM hr.employees
GROUP BY department_id;

-- 5. Maximum salary per department
SELECT department_id, MAX(salary) AS max_salary
FROM hr.employees
GROUP BY department_id;

-- 6. Count employees per job role
SELECT job_id, COUNT(*) AS total_employees
FROM hr.employees
GROUP BY job_id;

-- 7. Total salary per job role
SELECT job_id, SUM(salary) AS total_salary
FROM hr.employees
GROUP BY job_id;

-- 8. Average salary per job role
SELECT job_id, AVG(salary) AS avg_salary
FROM hr.employees
GROUP BY job_id;

-- 9. Departments with more than 5 employees
SELECT department_id, COUNT(*) AS total_employees
FROM hr.employees
GROUP BY department_id
HAVING COUNT(*) > 5;

-- 10. Departments where total salary > 100,000
SELECT department_id, SUM(salary) AS total_salary
FROM hr.employees
GROUP BY department_id
HAVING SUM(salary) > 100000;

-- 11. Departments where average salary > 50,000
SELECT department_id, AVG(salary) AS avg_salary
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > 50000;

-- 12. Departments where max salary > 80,000
SELECT department_id, MAX(salary) AS max_salary
FROM hr.employees
GROUP BY department_id
HAVING MAX(salary) > 80000;

-- 13. Departments where min salary < 30,000
SELECT department_id, MIN(salary) AS min_salary
FROM hr.employees
GROUP BY department_id
HAVING MIN(salary) < 30000;

-- 14. Departments where number of employees is between 5 and 10
SELECT department_id, COUNT(*) AS employee_count
FROM hr.employees
GROUP BY department_id
HAVING COUNT(*) BETWEEN 5 AND 10;

-- 15. Departments where salary variance > 500,000
SELECT department_id, VARIANCE(salary) AS salary_variance
FROM hr.employees
GROUP BY department_id
HAVING VARIANCE(salary) > 500000;

-- 16. Departments where salary standard deviation > 5,000
SELECT department_id, STDDEV(salary) AS salary_stddev
FROM hr.employees
GROUP BY department_id
HAVING STDDEV(salary) > 5000;

-- 17. Employees sorted by salary in descending order
SELECT employee_id, first_name, salary
FROM hr.employees
ORDER BY salary DESC;

-- 18. Employees sorted by department and salary
SELECT employee_id, first_name, department_id, salary
FROM hr.employees
ORDER BY department_id ASC, salary DESC;

-- 19. Employees sorted by last name alphabetically
SELECT employee_id, first_name, last_name
FROM hr.employees
ORDER BY last_name ASC;

-- 20. Employees sorted by hire date
SELECT employee_id, first_name, hire_date
FROM hr.employees
ORDER BY hire_date ASC;

-- 21. Employees sorted by commission, placing NULLs last
SELECT employee_id, first_name, commission_pct
FROM hr.employees
ORDER BY commission_pct NULLS LAST;

-- 22. Employees sorted by commission, placing NULLs first
SELECT employee_id, first_name, commission_pct
FROM hr.employees
ORDER BY commission_pct NULLS FIRST;

-- 23. Employees sorted by length of first name
SELECT employee_id, first_name
FROM hr.employees
ORDER BY LENGTH(first_name) ASC;

-- 24. Employees sorted by last two characters of last name
SELECT employee_id, first_name, last_name
FROM hr.employees
ORDER BY SUBSTR(last_name, -2) ASC;

-- 25. Employees sorted by uppercase first name
SELECT employee_id, UPPER(first_name) AS upper_name
FROM hr.employees
ORDER BY upper_name ASC;

-- 26. Employees sorted by salary after adding a bonus
SELECT employee_id, first_name, salary
FROM hr.employees
ORDER BY (salary + 500) DESC;

-- 27. Employees sorted by job ID and last name
SELECT employee_id, first_name, last_name, job_id
FROM hr.employees
ORDER BY job_id ASC, last_name ASC;

-- 28. Employees sorted by department, then by first name
SELECT employee_id, first_name, department_id
FROM hr.employees
ORDER BY department_id ASC, first_name ASC;

-- 29. Employees with IT_PROG job role first
SELECT employee_id, first_name, job_id
FROM hr.employees
ORDER BY CASE WHEN job_id = 'IT_PROG' THEN 1 ELSE 2 END;

-- 30. Employees with priority to salaries above 5000
SELECT employee_id, first_name, salary
FROM hr.employees
ORDER BY CASE WHEN salary > 5000 THEN 1 ELSE 2 END, salary DESC;

-- 31. Departments where total salary between 50,000 and 200,000
SELECT department_id, SUM(salary) AS total_salary
FROM hr.employees
GROUP BY department_id
HAVING SUM(salary) BETWEEN 50000 AND 200000;

-- 32. Departments where max salary is at least double the min salary
SELECT department_id, MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM hr.employees
GROUP BY department_id
HAVING MAX(salary) >= 2 * MIN(salary);

-- 33. Employees in department 50 at the top
SELECT employee_id, first_name, department_id
FROM hr.employees
ORDER BY CASE WHEN department_id = 50 THEN 1 ELSE 2 END, department_id ASC;

-- 34. Employees sorted by highest salary ratio
SELECT department_id, MAX(salary) / AVG(salary) AS salary_ratio
FROM hr.employees
GROUP BY department_id
HAVING MAX(salary) / AVG(salary) > 1.5
ORDER BY salary_ratio DESC;

-- 35. Employees sorted by job ID then salary
SELECT employee_id, first_name, salary, job_id
FROM hr.employees
ORDER BY job_id ASC, salary DESC;

-- 36. Employees sorted by highest commission first
SELECT employee_id, first_name, commission_pct
FROM hr.employees
ORDER BY commission_pct DESC NULLS LAST;

-- 37. Employees sorted by salary, keeping those with no commission at the bottom
SELECT employee_id, first_name, salary, commission_pct
FROM hr.employees
ORDER BY CASE WHEN commission_pct IS NULL THEN 2 ELSE 1 END, salary DESC;

-- 38. Employees sorted by department and descending salary
SELECT employee_id, first_name, department_id, salary
FROM hr.employees
ORDER BY department_id ASC, salary DESC;

-- 39. Employees where more than 50% earn above 60,000
SELECT job_id, COUNT(CASE WHEN salary > 60000 THEN 1 END) * 1.0 / COUNT(*) AS high_earner_ratio
FROM hr.employees
GROUP BY job_id
HAVING COUNT(CASE WHEN salary > 60000 THEN 1 END) > COUNT(*) / 2;

-- 40. Departments where IT and HR salaries sum to 80,000 or more
SELECT department_id, SUM(CASE WHEN job_id IN ('IT_PROG', 'HR_REP') THEN salary ELSE 0 END) AS it_hr_salary
FROM hr.employees
GROUP BY department_id
HAVING SUM(CASE WHEN job_id IN ('IT_PROG', 'HR_REP') THEN salary ELSE 0 END) >= 80000;


-- ===========================
-- 1. Basic Aggregate Functions
-- ===========================

-- 1. Count total employees
SELECT COUNT(*) AS total_employees FROM hr.employees;

-- 2. Count distinct job roles
SELECT COUNT(DISTINCT job_id) AS unique_jobs FROM hr.employees;

-- 3. Sum of salaries of all employees
SELECT SUM(salary) AS total_salary FROM hr.employees;

-- 4. Average salary of all employees
SELECT AVG(salary) AS avg_salary FROM hr.employees;

-- 5. Minimum salary in the company
SELECT MIN(salary) AS min_salary FROM hr.employees;

-- 6. Maximum salary in the company
SELECT MAX(salary) AS max_salary FROM hr.employees;

-- 7. Median salary of all employees
SELECT MEDIAN(salary) AS median_salary FROM hr.employees;

-- 8. Mode of salaries
SELECT MODE() WITHIN GROUP (ORDER BY salary) AS most_common_salary FROM hr.employees;

-- 9. Variance of salaries
SELECT VARIANCE(salary) AS salary_variance FROM hr.employees;

-- 10. Standard deviation of salaries
SELECT STDDEV(salary) AS salary_stddev FROM hr.employees;

-- ==============================
-- 2. Aggregate Functions with GROUP BY
-- ==============================

-- 11. Total employees per department
SELECT department_id, COUNT(*) AS total_employees FROM hr.employees GROUP BY department_id;

-- 12. Total salary per department
SELECT department_id, SUM(salary) AS total_salary FROM hr.employees GROUP BY department_id;

-- 13. Average salary per department
SELECT department_id, AVG(salary) AS avg_salary FROM hr.employees GROUP BY department_id;

-- 14. Minimum salary per department
SELECT department_id, MIN(salary) AS min_salary FROM hr.employees GROUP BY department_id;

-- 15. Maximum salary per department
SELECT department_id, MAX(salary) AS max_salary FROM hr.employees GROUP BY department_id;

-- 16. Count employees per job role
SELECT job_id, COUNT(*) AS total_employees FROM hr.employees GROUP BY job_id;

-- 17. Departments where total salary > 100,000
SELECT department_id, SUM(salary) AS total_salary FROM hr.employees GROUP BY department_id HAVING SUM(salary) > 100000;

-- 18. Departments where average salary > 50,000
SELECT department_id, AVG(salary) AS avg_salary FROM hr.employees GROUP BY department_id HAVING AVG(salary) > 50000;

-- 19. Departments with more than 5 employees
SELECT department_id, COUNT(*) AS total_employees FROM hr.employees GROUP BY department_id HAVING COUNT(*) > 5;

-- 20. Job roles with more than 10 employees
SELECT job_id, COUNT(*) AS total_employees FROM hr.employees GROUP BY job_id HAVING COUNT(*) > 10;

-- ==================================
-- 3. Analytical Functions
-- ==================================

-- 21. Assign row numbers to employees ordered by salary
SELECT employee_id, salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank FROM hr.employees;

-- 22. Rank employees by salary
SELECT employee_id, salary, RANK() OVER (ORDER BY salary DESC) AS salary_rank FROM hr.employees;

-- 23. Dense rank employees by salary
SELECT employee_id, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank FROM hr.employees;

-- 24. Divide employees into 4 salary quartiles
SELECT employee_id, salary, NTILE(4) OVER (ORDER BY salary DESC) AS quartile FROM hr.employees;

-- 25. Get previous salary for each employee
SELECT employee_id, salary, LAG(salary) OVER (ORDER BY salary) AS prev_salary FROM hr.employees;

-- 26. Get next salary for each employee
SELECT employee_id, salary, LEAD(salary) OVER (ORDER BY salary) AS next_salary FROM hr.employees;

-- 27. First salary in the ordered set
SELECT employee_id, salary, FIRST_VALUE(salary) OVER (ORDER BY salary) AS lowest_salary FROM hr.employees;

-- 28. Last salary in the ordered set
SELECT employee_id, salary, LAST_VALUE(salary) OVER (ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS highest_salary FROM hr.employees;

-- 29. Calculate cumulative distribution of salaries
SELECT employee_id, salary, CUME_DIST() OVER (ORDER BY salary) AS cumulative_distribution FROM hr.employees;

-- 30. Calculate percentage rank of salaries
SELECT employee_id, salary, PERCENT_RANK() OVER (ORDER BY salary) AS percentile FROM hr.employees;

-- =========================================
-- 4. ORDER BY with Aggregate and Analytical Functions
-- =========================================

-- 31. Employees sorted by salary in descending order
SELECT employee_id, first_name, salary FROM hr.employees ORDER BY salary DESC;

-- 32. Employees sorted by department and salary
SELECT employee_id, first_name, department_id, salary FROM hr.employees ORDER BY department_id ASC, salary DESC;

-- 33. Employees sorted by last name alphabetically
SELECT employee_id, first_name, last_name FROM hr.employees ORDER BY last_name ASC;

-- 34. Employees sorted by hire date
SELECT employee_id, first_name, hire_date FROM hr.employees ORDER BY hire_date ASC;

-- 35. Employees sorted by length of first name
SELECT employee_id, first_name FROM hr.employees ORDER BY LENGTH(first_name) ASC;

-- 36. Employees sorted by last two characters of last name
SELECT employee_id, first_name, last_name FROM hr.employees ORDER BY SUBSTR(last_name, -2) ASC;

-- 37. Employees with IT_PROG job role first
SELECT employee_id, first_name, job_id FROM hr.employees ORDER BY CASE WHEN job_id = 'IT_PROG' THEN 1 ELSE 2 END;

-- 38. Employees sorted by highest salary ratio
SELECT department_id, MAX(salary) / AVG(salary) AS salary_ratio FROM hr.employees GROUP BY department_id HAVING MAX(salary) / AVG(salary) > 1.5 ORDER BY salary_ratio DESC;

-- 39. Employees sorted by highest commission first
SELECT employee_id, first_name, commission_pct FROM hr.employees ORDER BY commission_pct DESC NULLS LAST;

-- 40. Employees sorted by salary, keeping those with no commission at the bottom
SELECT employee_id, first_name, salary, commission_pct FROM hr.employees ORDER BY CASE WHEN commission_pct IS NULL THEN 2 ELSE 1 END, salary DESC;

-- ===================================
-- More Analytical Functions
-- ===================================

-- 41. Show running total of salaries
SELECT employee_id, salary, SUM(salary) OVER (ORDER BY employee_id) AS running_total FROM hr.employees;

-- 42. Calculate moving average salary for 3 employees
SELECT employee_id, salary, AVG(salary) OVER (ORDER BY employee

