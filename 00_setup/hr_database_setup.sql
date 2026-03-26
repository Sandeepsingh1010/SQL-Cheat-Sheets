-- ============================================================================
-- HR COMPANY DATABASE SETUP SCRIPT
-- Purpose: Create a complete HR management database for SQL practice
-- Includes: Tables, Sequences, Indexes, and Sample Data
-- ============================================================================

-- ============================================================================
-- STEP 1: DROP EXISTING OBJECTS (CLEANUP)
-- ============================================================================

-- Drop tables in reverse order of dependencies (due to foreign keys)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE salary_history';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE assignments';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE employees';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE projects';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE departments';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE job_titles';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Drop sequences
BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE dept_seq';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE emp_seq';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE proj_seq';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE assign_seq';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE sal_hist_seq';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ============================================================================
-- STEP 2: CREATE SEQUENCES (Auto-incrementing IDs)
-- ============================================================================

CREATE SEQUENCE dept_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999
  NOCYCLE;
/

CREATE SEQUENCE emp_seq
  START WITH 1001
  INCREMENT BY 1
  MAXVALUE 99999
  NOCYCLE;
/

CREATE SEQUENCE proj_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999
  NOCYCLE;
/

CREATE SEQUENCE assign_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 99999
  NOCYCLE;
/

CREATE SEQUENCE sal_hist_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 99999
  NOCYCLE;
/

-- ============================================================================
-- STEP 3: CREATE TABLES
-- ============================================================================

-- TABLE 1: JOB_TITLES
-- Stores different job titles available in the company
CREATE TABLE job_titles (
  job_id VARCHAR2(10) PRIMARY KEY,
  job_title VARCHAR2(30) NOT NULL,
  min_salary NUMBER(10,2) NOT NULL,
  max_salary NUMBER(10,2) NOT NULL,
  created_date DATE DEFAULT SYSDATE,
  CONSTRAINT uk_job_title UNIQUE (job_title),
  CONSTRAINT chk_sal_range CHECK (min_salary > 0 AND max_salary >= min_salary)
);

-- TABLE 2: DEPARTMENTS
-- Stores company departments
CREATE TABLE departments (
  dept_id NUMBER PRIMARY KEY,
  dept_name VARCHAR2(30) NOT NULL,
  location VARCHAR2(30),
  budget NUMBER(12,2),
  manager_id NUMBER,
  created_date DATE DEFAULT SYSDATE,
  CONSTRAINT uk_dept_name UNIQUE (dept_name),
  CONSTRAINT chk_budget CHECK (budget IS NULL OR budget > 0)
);

-- TABLE 3: EMPLOYEES
-- Stores employee information
CREATE TABLE employees (
  emp_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(20) NOT NULL,
  last_name VARCHAR2(20) NOT NULL,
  email VARCHAR2(30) NOT NULL,
  phone_number VARCHAR2(20),
  job_id VARCHAR2(10) NOT NULL,
  salary NUMBER(10,2) NOT NULL,
  commission_pct NUMBER(3,2),
  manager_id NUMBER,
  dept_id NUMBER NOT NULL,
  hire_date DATE NOT NULL,
  status VARCHAR2(10) DEFAULT 'ACTIVE',
  created_date DATE DEFAULT SYSDATE,
  CONSTRAINT uk_email UNIQUE (email),
  CONSTRAINT fk_emp_job FOREIGN KEY (job_id) REFERENCES job_titles(job_id),
  CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
  CONSTRAINT fk_emp_mgr FOREIGN KEY (manager_id) REFERENCES employees(emp_id),
  CONSTRAINT chk_salary CHECK (salary > 0),
  CONSTRAINT chk_status CHECK (status IN ('ACTIVE', 'INACTIVE', 'ONLEAVE'))
);

-- Add foreign key for department manager
ALTER TABLE departments
ADD CONSTRAINT fk_dept_mgr FOREIGN KEY (manager_id) REFERENCES employees(emp_id);

-- TABLE 4: PROJECTS
-- Stores company projects
CREATE TABLE projects (
  proj_id NUMBER PRIMARY KEY,
  proj_name VARCHAR2(50) NOT NULL,
  description VARCHAR2(200),
  budget NUMBER(12,2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  status VARCHAR2(15) DEFAULT 'PLANNING' CHECK (status IN ('PLANNING', 'ACTIVE', 'COMPLETED', 'CANCELLED')),
  dept_id NUMBER NOT NULL,
  created_date DATE DEFAULT SYSDATE,
  CONSTRAINT fk_proj_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
  CONSTRAINT uk_proj_name UNIQUE (proj_name),
  CONSTRAINT chk_proj_dates CHECK (end_date IS NULL OR end_date >= start_date),
  CONSTRAINT chk_proj_budget CHECK (budget > 0)
);

-- TABLE 5: ASSIGNMENTS
-- Tracks which employees are assigned to which projects
CREATE TABLE assignments (
  assign_id NUMBER PRIMARY KEY,
  emp_id NUMBER NOT NULL,
  proj_id NUMBER NOT NULL,
  role_on_project VARCHAR2(30),
  start_date DATE NOT NULL,
  end_date DATE,
  hours_allocated NUMBER(5,2),
  created_date DATE DEFAULT SYSDATE,
  CONSTRAINT fk_assign_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
  CONSTRAINT fk_assign_proj FOREIGN KEY (proj_id) REFERENCES projects(proj_id),
  CONSTRAINT uk_emp_proj UNIQUE (emp_id, proj_id),
  CONSTRAINT chk_assign_dates CHECK (end_date IS NULL OR end_date >= start_date),
  CONSTRAINT chk_hours CHECK (hours_allocated IS NULL OR hours_allocated > 0)
);

-- TABLE 6: SALARY_HISTORY
-- Tracks salary changes over time
CREATE TABLE salary_history (
  sal_hist_id NUMBER PRIMARY KEY,
  emp_id NUMBER NOT NULL,
  old_salary NUMBER(10,2),
  new_salary NUMBER(10,2) NOT NULL,
  change_date DATE DEFAULT SYSDATE,
  reason VARCHAR2(50),
  created_date DATE DEFAULT SYSDATE,
  CONSTRAINT fk_sal_hist_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
  CONSTRAINT chk_sal_hist CHECK (new_salary > 0)
);

-- ============================================================================
-- STEP 4: CREATE INDEXES
-- ============================================================================

-- Performance optimization indexes
CREATE INDEX idx_emp_dept ON employees(dept_id);
CREATE INDEX idx_emp_manager ON employees(manager_id);
CREATE INDEX idx_emp_job ON employees(job_id);
CREATE INDEX idx_emp_status ON employees(status);
CREATE INDEX idx_emp_salary ON employees(salary);
-- NOTE: idx_emp_email not created - email already indexed by UNIQUE constraint

CREATE INDEX idx_proj_dept ON projects(dept_id);
CREATE INDEX idx_proj_status ON projects(status);
CREATE INDEX idx_proj_start_date ON projects(start_date);

CREATE INDEX idx_assign_emp ON assignments(emp_id);
CREATE INDEX idx_assign_proj ON assignments(proj_id);
CREATE INDEX idx_assign_dates ON assignments(start_date, end_date);

CREATE INDEX idx_sal_hist_emp ON salary_history(emp_id);
CREATE INDEX idx_sal_hist_date ON salary_history(change_date);

-- ============================================================================
-- STEP 5: INSERT SAMPLE DATA
-- ============================================================================

-- Insert Job Titles
INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('CEO', 'Chief Executive Officer', 150000, 300000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('VP_SALES', 'Vice President Sales', 100000, 200000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('VP_TECH', 'Vice President Technology', 100000, 200000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('DIRECTOR', 'Director', 80000, 150000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('MANAGER', 'Manager', 60000, 100000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('SENIOR_DEV', 'Senior Developer', 80000, 120000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('DEVELOPER', 'Developer', 60000, 90000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('JUNIOR_DEV', 'Junior Developer', 40000, 65000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('SALES_REP', 'Sales Representative', 50000, 80000);

INSERT INTO job_titles (job_id, job_title, min_salary, max_salary)
VALUES ('ANALYST', 'Business Analyst', 55000, 85000);

COMMIT;

-- Insert Departments
INSERT INTO departments (dept_id, dept_name, location, budget)
VALUES (dept_seq.NEXTVAL, 'Executive', 'New York', 500000);

INSERT INTO departments (dept_id, dept_name, location, budget)
VALUES (dept_seq.NEXTVAL, 'Sales', 'New York', 1000000);

INSERT INTO departments (dept_id, dept_name, location, budget)
VALUES (dept_seq.NEXTVAL, 'Technology', 'San Francisco', 2000000);

INSERT INTO departments (dept_id, dept_name, location, budget)
VALUES (dept_seq.NEXTVAL, 'Marketing', 'Los Angeles', 500000);

INSERT INTO departments (dept_id, dept_name, location, budget)
VALUES (dept_seq.NEXTVAL, 'Human Resources', 'Chicago', 300000);

INSERT INTO departments (dept_id, dept_name, location, budget)
VALUES (dept_seq.NEXTVAL, 'Finance', 'Boston', 400000);

COMMIT;

-- Insert Employees
-- CEO (ID: 1001)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'John', 'Smith', 'john.smith@company.com', '555-0001', 'CEO', 250000,
        1, TRUNC(SYSDATE) - 1826, 'ACTIVE');

-- VP Sales (ID: 1002)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Sarah', 'Johnson', 'sarah.johnson@company.com', '555-0002', 'VP_SALES', 150000,
        1001, 2, TRUNC(SYSDATE) - 1461, 'ACTIVE');

-- VP Tech (ID: 1003)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Michael', 'Chen', 'michael.chen@company.com', '555-0003', 'VP_TECH', 150000,
        1001, 3, TRUNC(SYSDATE) - 1461, 'ACTIVE');

-- Sales Director (ID: 1004)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary, commission_pct,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Lisa', 'Martinez', 'lisa.martinez@company.com', '555-0004', 'DIRECTOR', 120000, 0.15,
        1002, 2, TRUNC(SYSDATE) - 1095, 'ACTIVE');

-- Tech Director (ID: 1005)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'David', 'Kim', 'david.kim@company.com', '555-0005', 'DIRECTOR', 120000,
        1003, 3, TRUNC(SYSDATE) - 1095, 'ACTIVE');

-- Sales Manager (ID: 1006)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary, commission_pct,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Amanda', 'Wilson', 'amanda.wilson@company.com', '555-0006', 'MANAGER', 80000, 0.10,
        1004, 2, TRUNC(SYSDATE) - 730, 'ACTIVE');

-- Sales Rep 1 (ID: 1007)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary, commission_pct,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Robert', 'Taylor', 'robert.taylor@company.com', '555-0007', 'SALES_REP', 65000, 0.08,
        1006, 2, TRUNC(SYSDATE) - 365, 'ACTIVE');

-- Sales Rep 2 (ID: 1008)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary, commission_pct,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Jennifer', 'Anderson', 'jennifer.anderson@company.com', '555-0008', 'SALES_REP', 62000, 0.08,
        1006, 2, TRUNC(SYSDATE) - 300, 'ACTIVE');

-- Senior Developer 1 (ID: 1009)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Thomas', 'Brown', 'thomas.brown@company.com', '555-0009', 'SENIOR_DEV', 110000,
        1005, 3, TRUNC(SYSDATE) - 600, 'ACTIVE');

-- Senior Developer 2 (ID: 1010)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Emily', 'White', 'emily.white@company.com', '555-0010', 'SENIOR_DEV', 105000,
        1005, 3, TRUNC(SYSDATE) - 545, 'ACTIVE');

-- Developer 1 (ID: 1011)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'James', 'Harris', 'james.harris@company.com', '555-0011', 'DEVELOPER', 75000,
        1009, 3, TRUNC(SYSDATE) - 400, 'ACTIVE');

-- Developer 2 (ID: 1012)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Patricia', 'Martin', 'patricia.martin@company.com', '555-0012', 'DEVELOPER', 72000,
        1009, 3, TRUNC(SYSDATE) - 380, 'ACTIVE');

-- Junior Developer (ID: 1013)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Christopher', 'Rodriguez', 'c.rodriguez@company.com', '555-0013', 'JUNIOR_DEV', 52000,
        1010, 3, TRUNC(SYSDATE) - 100, 'ACTIVE');

-- Business Analyst (ID: 1014)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Nancy', 'Lee', 'nancy.lee@company.com', '555-0014', 'ANALYST', 70000,
        1005, 3, TRUNC(SYSDATE) - 200, 'ACTIVE');

-- Business Analyst on leave (ID: 1015)
INSERT INTO employees (emp_id, first_name, last_name, email, phone_number, job_id, salary,
                       manager_id, dept_id, hire_date, status)
VALUES (emp_seq.NEXTVAL, 'Mark', 'Davis', 'mark.davis@company.com', '555-0015', 'ANALYST', 68000,
        1005, 3, TRUNC(SYSDATE) - 180, 'ONLEAVE');

COMMIT;

-- Update department manager_ids after employees are inserted
UPDATE departments SET manager_id = 1002 WHERE dept_id = 2;
UPDATE departments SET manager_id = 1003 WHERE dept_id = 3;
UPDATE departments SET manager_id = 1001 WHERE dept_id = 1;
COMMIT;

-- Insert Projects
INSERT INTO projects (proj_id, proj_name, description, budget, start_date, status, dept_id)
VALUES (proj_seq.NEXTVAL, 'Cloud Migration', 'Migrate systems to cloud infrastructure', 500000,
        TRUNC(SYSDATE) - 90, 'ACTIVE', 3);

INSERT INTO projects (proj_id, proj_name, description, budget, start_date, end_date, status, dept_id)
VALUES (proj_seq.NEXTVAL, 'Mobile App Development', 'Develop new mobile application', 300000,
        TRUNC(SYSDATE) - 180, TRUNC(SYSDATE) - 30, 'COMPLETED', 3);

INSERT INTO projects (proj_id, proj_name, description, budget, start_date, status, dept_id)
VALUES (proj_seq.NEXTVAL, 'CRM Implementation', 'Implement new customer relationship system', 400000,
        TRUNC(SYSDATE) - 60, 'ACTIVE', 3);

INSERT INTO projects (proj_id, proj_name, description, budget, start_date, status, dept_id)
VALUES (proj_seq.NEXTVAL, 'Q2 Sales Campaign', 'Marketing and sales campaign for Q2', 150000,
        TRUNC(SYSDATE) + 30, 'PLANNING', 2);

INSERT INTO projects (proj_id, proj_name, description, budget, start_date, status, dept_id)
VALUES (proj_seq.NEXTVAL, 'Security Audit', 'Complete security audit of infrastructure', 200000,
        TRUNC(SYSDATE) - 45, 'ACTIVE', 3);

INSERT INTO projects (proj_id, proj_name, description, budget, start_date, status, dept_id)
VALUES (proj_seq.NEXTVAL, 'Analytics Platform', 'Build comprehensive analytics dashboard', 250000,
        TRUNC(SYSDATE) + 15, 'PLANNING', 3);

COMMIT;

-- Insert Assignments
INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1005, 1, 'Project Lead', TRUNC(SYSDATE) - 90, 40);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1009, 1, 'Senior Developer', TRUNC(SYSDATE) - 90, 35);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1011, 1, 'Developer', TRUNC(SYSDATE) - 90, 40);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1016, 1, 'Junior Developer', TRUNC(SYSDATE) - 90, 30);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, end_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1009, 2, 'Senior Developer', TRUNC(SYSDATE) - 180, TRUNC(SYSDATE) - 30, 40);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, end_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1012, 2, 'Developer', TRUNC(SYSDATE) - 180, TRUNC(SYSDATE) - 30, 40);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1014, 3, 'Business Analyst', TRUNC(SYSDATE) - 60, 20);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1010, 3, 'Lead Developer', TRUNC(SYSDATE) - 60, 35);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1006, 4, 'Sales Lead', TRUNC(SYSDATE) + 30, 40);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1007, 4, 'Sales Representative', TRUNC(SYSDATE) + 30, 40);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1008, 4, 'Sales Representative', TRUNC(SYSDATE) + 30, 40);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1009, 5, 'Security Lead', TRUNC(SYSDATE) - 45, 20);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1010, 6, 'Analytics Lead', TRUNC(SYSDATE) + 15, 40);

INSERT INTO assignments (assign_id, emp_id, proj_id, role_on_project, start_date, hours_allocated)
VALUES (assign_seq.NEXTVAL, 1011, 6, 'Developer', TRUNC(SYSDATE) + 15, 30);

COMMIT;

-- Insert Salary History
INSERT INTO salary_history (sal_hist_id, emp_id, old_salary, new_salary, change_date, reason)
VALUES (sal_hist_seq.NEXTVAL, 1007, 60000, 65000, TRUNC(SYSDATE) - 60, 'Annual Raise');

INSERT INTO salary_history (sal_hist_id, emp_id, old_salary, new_salary, change_date, reason)
VALUES (sal_hist_seq.NEXTVAL, 1011, 70000, 75000, TRUNC(SYSDATE) - 90, 'Promotion');

INSERT INTO salary_history (sal_hist_id, emp_id, old_salary, new_salary, change_date, reason)
VALUES (sal_hist_seq.NEXTVAL, 1016, 48000, 52000, TRUNC(SYSDATE) - 30, 'Annual Raise');

INSERT INTO salary_history (sal_hist_id, emp_id, old_salary, new_salary, change_date, reason)
VALUES (sal_hist_seq.NEXTVAL, 1009, 100000, 110000, TRUNC(SYSDATE) - 120, 'Annual Raise');

INSERT INTO salary_history (sal_hist_id, emp_id, old_salary, new_salary, change_date, reason)
VALUES (sal_hist_seq.NEXTVAL, 1010, 100000, 105000, TRUNC(SYSDATE) - 100, 'Annual Raise');

COMMIT;

-- ============================================================================
-- STEP 6: VERIFICATION QUERIES
-- ============================================================================

PROMPT
PROMPT ============================================================
PROMPT DATABASE SETUP COMPLETE - VERIFICATION RESULTS
PROMPT ============================================================
PROMPT

SELECT 'Job Titles' AS Object_Type, COUNT(*) AS Record_Count FROM job_titles
UNION ALL
SELECT 'Departments', COUNT(*) FROM departments
UNION ALL
SELECT 'Employees', COUNT(*) FROM employees
UNION ALL
SELECT 'Projects', COUNT(*) FROM projects
UNION ALL
SELECT 'Assignments', COUNT(*) FROM assignments
UNION ALL
SELECT 'Salary History', COUNT(*) FROM salary_history;

PROMPT
PROMPT Employees by Department:
PROMPT
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count,
       ROUND(AVG(e.salary), 2) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY d.dept_name;

PROMPT
PROMPT Active Projects:
PROMPT
SELECT proj_name, status, budget, dept_id
FROM projects
WHERE status IN ('ACTIVE', 'PLANNING')
ORDER BY proj_name;

PROMPT
PROMPT Employees by Salary Range:
PROMPT
SELECT
  CASE
    WHEN salary < 60000 THEN 'Under $60K'
    WHEN salary < 100000 THEN '$60K - $100K'
    WHEN salary < 150000 THEN '$100K - $150K'
    ELSE 'Over $150K'
  END AS salary_range,
  COUNT(*) AS employee_count,
  ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY CASE
    WHEN salary < 60000 THEN 'Under $60K'
    WHEN salary < 100000 THEN '$60K - $100K'
    WHEN salary < 150000 THEN '$100K - $150K'
    ELSE 'Over $150K'
  END
ORDER BY salary_range;

PROMPT
PROMPT ============================================================
PROMPT Setup completed successfully! Database is ready for practice.
PROMPT ============================================================
PROMPT
