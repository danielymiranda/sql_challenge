-- -- -- -- -- -- -- [PART I] 
-- Creation of tables and list the following details of each employee: 
-- employee number, last name, first name, gender, and salary.

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birthdate" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "gender" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM employees

CREATE TABLE "departments" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

SELECT * FROM departments

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

SELECT * FROM salaries

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

SELECT * FROM titles

CREATE TABLE "dept_employee" (
    "emp_no" int   NOT NULL,
    "dept_no" VARCHAR(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

SELECT * FROM dept_employee	

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

SELECT * FROM dept_manager

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
ALTER TABLE "dept_employee" ADD CONSTRAINT "fk_dept_employee_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
ALTER TABLE "dept_employee" ADD CONSTRAINT "fk_dept_employee_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");
ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");
ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- -- -- -- -- -- -- [PART II] 
-- List employees who were hired in 1986

SELECT * FROM employees

WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--SELECT * FROM employees;
--SELECT hire_date FROM employees
--WHERE hire_date LIKE '1986%'; #not good

-- -- -- -- -- -- -- [PART III] 
-- Primero tenemos que seleccionar la data de las variables que vamos a utilizar
SELECT * FROM departments;
SELECT * FROM dept_manager; 
SELECT * FROM employees; 

SELECT employees.emp_no, dept_manager.dept_no, employees.first_name, employees.last_name,
employees.hire_date, dept_manager.from_date, dept_manager.to_date
FROM employees 
INNER JOIN dept_manager 
ON employees.emp_no = dept_manager.emp_no;

SELECT employees.emp_no, dept_manager.dept_no, departments.dept_name, employees.last_name, 
employees.first_name,employees.hire_date, dept_manager.from_date, dept_manager.to_date
FROM employees 
INNER JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments 
ON dept_manager.dept_no = departments.dept_no;

--SELECT employees.emp_no, dept_manager.dept_no, departments.dept_name, employees.last_name, 
--employees.first_name,employees.hire_date, dept_manager.from_date, dept_manager.to_date
--FROM departments #no 
--Inner JOIN dept_manager #inner out?
--ON employees.emp_no = dept_manager.emp_no
--Inner JOIN employees 
--ON dept_manager.dept_no = departments.dept_no;


-- -- -- -- -- -- -- [PART IV]
-- List the department of each employee with the following information: employee number, 
-- last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees INNER JOIN dept_manager 
ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments 
ON dept_manager.dept_no = departments.dept_no;

--SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
--FROM employees INNER JOIN dept_manager 
--ON employees.emp_no = dept_manager.emp_no
--inner join departments 
--dept_manager.dept_no = departments.dept_no;? NO funciona

-- -- -- -- -- -- -- [PART V]
-- List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE first_name LIKE 'Hercules' 
AND last_name LIKE 'B%';

--SELECT * FROM employees
--From first_name LIKE 'Hercules' #not working
-- + last_name LIKE 'B%'; plus last_name

-- -- -- -- -- -- -- [PART VI]
-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.

SELECT dept_employee.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_employee
JOIN employees
ON dept_employee.emp_no = employees.emp_no
JOIN departments
ON dept_employee.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- -- -- -- -- -- -- [PART VII]
-- List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.

SELECT dept_employee.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_employee
JOIN employees
ON dept_employee.emp_no = employees.emp_no
JOIN departments
ON dept_employee.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- -- -- -- -- -- -- [PART VIII]
-- In descending order, list the frequency count of employee last names, i.e., 
-- how many employees share each last name.

SELECT last_name AS "LAST NAME",
COUNT(last_name) AS "FREQUENCY COUNT OF EMPLOYEE LAST NAMES"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;








