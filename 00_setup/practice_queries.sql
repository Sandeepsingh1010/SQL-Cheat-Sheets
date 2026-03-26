-- ============================================================================
-- HR DATABASE - PRACTICE QUERIES
-- Use these queries to practice different SQL concepts
-- All queries work with the data created by hr_database_setup.sql
-- ============================================================================

-- ============================================================================
-- 1. BASIC SELECT QUERIES (01_basics)
-- ============================================================================

-- List all employees
SELECT * FROM employees;

-- List employee names and departments
SELECT first_name, last_name, salary FROM employees;

-- List employees with their department names
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- ============================================================================
-- 2. WHERE CLAUSE FILTERING (01_basics)
-- ============================================================================

-- Find employees in Technology department (dept_id = 3)
SELECT first_name, last_name, salary FROM employees
WHERE dept_id = 3;

-- Find employees earning more than $100,000
SELECT first_name, last_name, salary FROM employees
WHERE salary > 100000;

-- Find employees hired in last year
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date >= TRUNC(SYSDATE) - 365;

-- ============================================================================
-- 3. AND, OR, NOT OPERATORS (01_basics)
-- ============================================================================

-- Employees in Technology OR Sales departments
SELECT first_name, last_name, dept_id FROM employees
WHERE dept_id = 2 OR dept_id = 3;

-- Employees NOT in Technology department
SELECT first_name, last_name, dept_id FROM employees
WHERE dept_id != 3;

-- Senior developers OR managers (using IN)
SELECT first_name, last_name, job_id FROM employees
WHERE job_id IN ('SENIOR_DEV', 'MANAGER');

-- Active employees in Sales with salary > 70000
SELECT first_name, last_name, salary FROM employees
WHERE dept_id = 2 AND status = 'ACTIVE' AND salary > 70000;

-- ============================================================================
-- 4. ORDER BY (01_basics)
-- ============================================================================

-- List employees sorted by salary (highest first)
SELECT first_name, last_name, salary FROM employees
ORDER BY salary DESC;

-- List employees by department, then by salary
SELECT dept_id, first_name, last_name, salary FROM employees
ORDER BY dept_id, salary DESC;

-- ============================================================================
-- 5. DISTINCT (01_basics)
-- ============================================================================

-- List unique departments that have employees
SELECT DISTINCT dept_id FROM employees;

-- List unique job titles
SELECT DISTINCT job_id FROM employees;

-- ============================================================================
-- 6. LIMIT/ROWNUM (01_basics)
-- ============================================================================

-- Top 5 highest paid employees
SELECT first_name, last_name, salary FROM employees
ORDER BY salary DESC
FETCH FIRST 5 ROWS ONLY;

-- First 10 employees
SELECT first_name, last_name FROM employees
WHERE ROWNUM <= 10;

-- ============================================================================
-- 7. GROUP BY (01_basics)
-- ============================================================================

-- Count employees by department
SELECT dept_id, COUNT(*) AS employee_count
FROM employees
GROUP BY dept_id;

-- Average salary by department
SELECT d.dept_name, COUNT(e.emp_id) AS emp_count, ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name;

-- Count employees by status
SELECT status, COUNT(*) AS count
FROM employees
GROUP BY status;

-- ============================================================================
-- 8. HAVING (01_basics)
-- ============================================================================

-- Departments with more than 2 employees
SELECT dept_id, COUNT(*) AS emp_count
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 2;

-- Departments with average salary > 90000
SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) > 90000;

-- ============================================================================
-- 9. INNER JOIN (04_joins)
-- ============================================================================

-- Employees with their managers
SELECT e.first_name AS employee, m.first_name AS manager, e.job_id
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id;

-- Employees with their job titles
SELECT e.first_name, e.last_name, j.job_title, e.salary
FROM employees e
JOIN job_titles j ON e.job_id = j.job_id;

-- Projects with assigned employees
SELECT p.proj_name, e.first_name, e.last_name, a.role_on_project
FROM projects p
JOIN assignments a ON p.proj_id = a.proj_id
JOIN employees e ON a.emp_id = e.emp_id;

-- ============================================================================
-- 10. LEFT JOIN (04_joins)
-- ============================================================================

-- All departments with employee counts (even empty ones)
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- Employees and their managers (show NULL if no manager)
SELECT e.first_name AS employee,
       NVL(m.first_name, 'N/A') AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- ============================================================================
-- 11. IN OPERATOR (05_joins_subqueries)
-- ============================================================================

-- Employees in Technology or Finance departments
SELECT first_name, last_name FROM employees
WHERE dept_id IN (3, 6);

-- Employees with specific job titles
SELECT first_name, last_name, job_id FROM employees
WHERE job_id IN ('SENIOR_DEV', 'DEVELOPER', 'JUNIOR_DEV');

-- Employees assigned to projects
SELECT DISTINCT emp_id, first_name, last_name
FROM employees
WHERE emp_id IN (SELECT emp_id FROM assignments);

-- ============================================================================
-- 12. NOT IN (05_joins_subqueries)
-- ============================================================================

-- Employees NOT assigned to any project
SELECT emp_id, first_name, last_name
FROM employees
WHERE emp_id NOT IN (SELECT DISTINCT emp_id FROM assignments WHERE emp_id IS NOT NULL);

-- Employees NOT in development
SELECT first_name, last_name FROM employees
WHERE job_id NOT IN ('SENIOR_DEV', 'DEVELOPER', 'JUNIOR_DEV');

-- ============================================================================
-- 13. EXISTS (05_joins_subqueries)
-- ============================================================================

-- Employees who have assignments
SELECT e.emp_id, e.first_name, e.last_name
FROM employees e
WHERE EXISTS (
    SELECT 1 FROM assignments a WHERE a.emp_id = e.emp_id
);

-- Departments with active projects
SELECT DISTINCT d.dept_id, d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM projects p WHERE p.dept_id = d.dept_id AND p.status = 'ACTIVE'
);

-- ============================================================================
-- 14. NOT EXISTS (05_joins_subqueries)
-- ============================================================================

-- Employees without project assignments
SELECT e.emp_id, e.first_name, e.last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM assignments a WHERE a.emp_id = e.emp_id
);

-- Departments without projects
SELECT d.dept_id, d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM projects p WHERE p.dept_id = d.dept_id
);

-- ============================================================================
-- 15. ANY OPERATOR (05_joins_subqueries)
-- ============================================================================

-- Employees earning more than any junior developer
SELECT first_name, last_name, salary FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees WHERE job_id = 'JUNIOR_DEV'
);

-- ============================================================================
-- 16. ALL OPERATOR (05_joins_subqueries)
-- ============================================================================

-- Employees earning more than all junior developers
SELECT first_name, last_name, salary FROM employees
WHERE salary > ALL (
    SELECT salary FROM employees WHERE job_id = 'JUNIOR_DEV'
);

-- ============================================================================
-- 17. SUBQUERIES IN SELECT (05_joins_subqueries)
-- ============================================================================

-- Employees with salary comparison
SELECT first_name, last_name, salary,
       (SELECT AVG(salary) FROM employees) AS avg_company_salary
FROM employees;

-- Employees with department average
SELECT e.first_name, e.salary,
       (SELECT AVG(salary) FROM employees WHERE dept_id = e.dept_id) AS dept_avg
FROM employees e;

-- ============================================================================
-- 18. CORRELATED SUBQUERIES (05_joins_subqueries)
-- ============================================================================

-- Employees earning more than their department average
SELECT e.first_name, e.salary, e.dept_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary) FROM employees
    WHERE dept_id = e.dept_id
);

-- Departments with more than average employees
SELECT dept_id, dept_name FROM departments d
WHERE (SELECT COUNT(*) FROM employees WHERE dept_id = d.dept_id) >
      (SELECT AVG(emp_count) FROM (
           SELECT COUNT(*) AS emp_count FROM employees GROUP BY dept_id
       ));

-- ============================================================================
-- 19. STRING FUNCTIONS (06_functions)
-- ============================================================================

-- Employee names concatenated
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

-- Or using ||
SELECT first_name || ' ' || last_name AS full_name FROM employees;

-- Uppercase names
SELECT UPPER(first_name) FROM employees;

-- Lowercase email
SELECT LOWER(email) FROM employees;

-- Find employees with 'ar' in their last name
SELECT first_name, last_name FROM employees
WHERE INSTR(LOWER(last_name), 'ar') > 0;

-- ============================================================================
-- 20. NUMERIC FUNCTIONS (06_functions)
-- ============================================================================

-- Round salaries
SELECT first_name, ROUND(salary, -2) AS rounded_salary FROM employees;

-- Absolute value
SELECT ABS(salary - 100000) AS difference FROM employees;

-- Ceiling and floor
SELECT salary, CEIL(salary), FLOOR(salary) FROM employees;

-- ============================================================================
-- 21. DATE FUNCTIONS (06_functions)
-- ============================================================================

-- Days employed
SELECT first_name, TRUNC(SYSDATE - hire_date) AS days_employed FROM employees;

-- Add months to date
SELECT first_name, hire_date, ADD_MONTHS(hire_date, 12) AS one_year_later FROM employees;

-- Extract year from hire date
SELECT first_name, EXTRACT(YEAR FROM hire_date) AS hire_year FROM employees;

-- ============================================================================
-- 22. AGGREGATE FUNCTIONS (06_functions)
-- ============================================================================

-- Total payroll by department
SELECT d.dept_name, SUM(e.salary) AS total_payroll
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name;

-- Min and max salary
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM employees;

-- Count by job
SELECT job_id, COUNT(*) AS employee_count FROM employees GROUP BY job_id;

-- ============================================================================
-- 23. NULL HANDLING (06_functions)
-- ============================================================================

-- Using NVL to replace NULL
SELECT first_name, NVL(commission_pct, 0) AS commission FROM employees;

-- Count rows with/without commission
SELECT
  SUM(CASE WHEN commission_pct IS NOT NULL THEN 1 ELSE 0 END) AS with_commission,
  SUM(CASE WHEN commission_pct IS NULL THEN 1 ELSE 0 END) AS without_commission
FROM employees;

-- ============================================================================
-- 24. CASE EXPRESSIONS (06_functions)
-- ============================================================================

-- Classify employees by salary
SELECT first_name, salary,
  CASE
    WHEN salary < 60000 THEN 'Junior Level'
    WHEN salary < 100000 THEN 'Mid Level'
    WHEN salary < 150000 THEN 'Senior Level'
    ELSE 'Executive Level'
  END AS salary_level
FROM employees;

-- ============================================================================
-- 25. DATA DICTIONARY QUERIES (02_ddl)
-- ============================================================================

-- List all tables
SELECT table_name FROM user_tables ORDER BY table_name;

-- List columns in employees table
SELECT column_name, data_type, nullable FROM user_tab_columns
WHERE table_name = 'EMPLOYEES';

-- List all indexes
SELECT index_name, table_name FROM user_indexes WHERE table_name IN ('EMPLOYEES', 'DEPARTMENTS');

-- List all sequences
SELECT sequence_name FROM user_sequences ORDER BY sequence_name;

-- List constraints
SELECT constraint_name, constraint_type, table_name FROM user_constraints
WHERE table_name = 'EMPLOYEES';

-- ============================================================================
-- 26. ADVANCED QUERIES - MULTIPLE JOINS
-- ============================================================================

-- Complete employee record with all details
SELECT
  e.emp_id,
  e.first_name || ' ' || e.last_name AS full_name,
  j.job_title,
  e.salary,
  d.dept_name,
  NVL(m.first_name || ' ' || m.last_name, 'No Manager') AS manager_name
FROM employees e
JOIN job_titles j ON e.job_id = j.job_id
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employees m ON e.manager_id = m.emp_id
ORDER BY d.dept_name, e.salary DESC;

-- Project assignments with full details
SELECT
  p.proj_name,
  e.first_name || ' ' || e.last_name AS employee_name,
  a.role_on_project,
  a.hours_allocated,
  j.job_title
FROM projects p
JOIN assignments a ON p.proj_id = a.proj_id
JOIN employees e ON a.emp_id = e.emp_id
JOIN job_titles j ON e.job_id = j.job_id
ORDER BY p.proj_name, a.hours_allocated DESC;

-- ============================================================================
-- 27. SET OPERATIONS
-- ============================================================================

-- All employees who are managers OR project leads
SELECT 'Manager' AS role, emp_id, first_name, last_name FROM employees
WHERE emp_id IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL)
UNION
SELECT 'Project Lead', e.emp_id, e.first_name, e.last_name FROM employees e
WHERE EXISTS (SELECT 1 FROM assignments WHERE emp_id = e.emp_id AND role_on_project LIKE '%Lead%');

-- ============================================================================
-- 28. SUMMARY STATISTICS
-- ============================================================================

-- Company overview
SELECT
  (SELECT COUNT(*) FROM employees) AS total_employees,
  (SELECT AVG(salary) FROM employees) AS avg_salary,
  (SELECT MAX(salary) FROM employees) AS max_salary,
  (SELECT COUNT(DISTINCT dept_id) FROM employees) AS dept_count,
  (SELECT COUNT(*) FROM projects) AS active_projects;

-- ============================================================================
-- PRACTICE CHALLENGES
-- ============================================================================

-- Challenge 1: Find top 3 highest paid employees
-- [Write your query here]

-- Challenge 2: List all employees on leave with their assignments
-- [Write your query here]

-- Challenge 3: Find departments with average salary above company average
-- [Write your query here]

-- Challenge 4: List projects that started more than 60 days ago
-- [Write your query here]

-- Challenge 5: Find employees assigned to multiple projects
-- [Write your query here]
