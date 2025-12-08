/*
    Title: bacchus_winery.sql
    Author: Colton Stone, Aysa Jordan, and Eric Brown
    Date: December 6, 2025
    Description: Database to depict the logistics of a wine company.
*/;

-- drop database user if exists

DROP USER IF EXISTS 'bacchus_user'@'localhost';

CREATE USER 'bacchus_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'wine';

GRANT ALL PRIVILEGES ON bacchus_winery.* TO 'bacchus_user'@'localhost';

DROP TABLE IF EXISTS distributor;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS wine;

-- EMPLOYEE Table Structure --

CREATE TABLE employee (
   employee_id int NOT NULL AUTO_INCREMENT,
   employee_name varchar(255),
   employee_title varchar(255),
   employee_department varchar(255),
   annual_workhours int,
   PRIMARY KEY (employee_id)
);

-- Employee Records --

INSERT INTO employee(employee_name, employee_title, employee_department, annual_workhours)
VALUES('Davis Bacchus', 'Inventory Co-Manager', 'Supply', 3000);

INSERT INTO employee(employee_name, employee_title, employee_department, annual_workhours)
VALUES('Stan Bacchus', 'Inventory Co-Manager', 'Supply', 3000);

INSERT INTO employee(employee_name, employee_title, employee_department, annual_workhours)
VALUES('Janet Collins', 'Payroll Manager', 'Finances', 2500);

INSERT INTO employee(employee_name, employee_title, employee_department, annual_workhours)
VALUES('Roz Murphy', 'Marketing Manager', 'Marketing', 2500);

INSERT INTO employee(employee_name, employee_title, employee_department, annual_workhours)
VALUES('Bob Ulrich', 'Marketing Assistant', 'Marketing', 2000);

INSERT INTO employee(employee_name, employee_title, employee_department, annual_workhours)
VALUES('Henry Doyle', 'Production Manager', 'Production', 2500);

INSERT INTO employee(employee_name, employee_title, employee_department, annual_workhours)
VALUES('Maria Costanza', 'Distribution Manager', 'Distribution', 2500);

-- SUPPLIER Table Structure --

CREATE TABLE supplier (
  supplier_id int NOT NULL AUTO_INCREMENT,
  supplier_name varchar(255),
  supply_type varchar(255),
  items varchar(255),
  expected_monthly_deliverydates varchar(255),
  actual_monthly_deliverydates varchar(255),
  PRIMARY KEY (supplier_id)
);

-- Supplier Records (case study has only 3) --

INSERT INTO supplier(supplier_name, supply_type, items, expected_monthly_deliverydates, actual_monthly_deliverydates)
VALUES('Green Glass & Packaging', 'Packaging', 'Corks, Bottles',
'01-02, 02-02, 03-02, 04-02, 05-02, 06-02, 07-02, 08-02, 09-02, 10-02, 11-02, 12-02',
'01-02, 02-02, 03-02, 04-02, 05-02, 06-02, 07-02, 08-02, 09-02, 10-02, 11-02, 12-02');

INSERT INTO supplier(supplier_name, supply_type, items, expected_monthly_deliverydates, actual_monthly_deliverydates)
VALUES('Daily Express', 'Shipping', 'Boxes, Labels',
'01-05, 02-05, 03-05, 04-05, 05-05, 06-05, 07-05, 08-05, 09-05, 10-05, 11-05, 12-05',
'01-07, 02-05, 03-05, 04-05, 05-05, 06-05, 07-05, 08-05, 09-05, 10-05, 11-05, 12-08');

INSERT INTO supplier(supplier_name, supply_type, items, expected_monthly_deliverydates, actual_monthly_deliverydates)
VALUES('G3 Industries', 'Industrial', 'Tubing, Vats',
'01-10, 02-10, 03-10, 04-10, 05-10, 06-10, 07-10, 08-10, 09-10, 10-10, 11-10, 12-10',
'01-10, 02-10, 03-10, 04-10, 05-10, 06-10, 07-10, 08-10, 09-10, 10-10, 11-10, 12-10');

-- WINE Table Structure --

CREATE TABLE wine (
  wine_id int NOT NULL AUTO_INCREMENT,
  wine_name varchar(255),
  wine_type varchar(255),
  expected_gallonsales int,
  actual_gallonsales int,
  PRIMARY KEY (wine_id)
);

-- Wine Records (case study has 4 wines) --

INSERT INTO wine(wine_name, wine_type, expected_gallonsales, actual_gallonsales)
VALUES('Cabernet', 'Red Wine', 550000, 550000);

INSERT INTO wine(wine_name, wine_type, expected_gallonsales, actual_gallonsales)
VALUES('Chablis', 'White Wine', 450000, 450000);

INSERT INTO wine(wine_name, wine_type, expected_gallonsales, actual_gallonsales)
VALUES('Chardonnay', 'White Wine', 400000, 370000);

INSERT INTO wine(wine_name, wine_type, expected_gallonsales, actual_gallonsales)
VALUES('Merlot', 'Red Wine', 500000, 460000);

-- DISTRIBUTOR Table Structure --

CREATE TABLE distributor (
    distributor_id int NOT NULL AUTO_INCREMENT,
    distributor_name varchar(255),
    wine_id int NOT NULL,
    PRIMARY KEY (distributor_id),
    CONSTRAINT fk_wine
    FOREIGN KEY (wine_id)
        REFERENCES wine(wine_id)
);

-- Distributor Records (one for each wine) --

INSERT INTO distributor(distributor_name, wine_id)
VALUES('Georgia Vinery', (SELECT wine_id FROM wine WHERE wine_name = 'Merlot'));

INSERT INTO distributor(distributor_name, wine_id)
VALUES('Liquor Warehouse', (SELECT wine_id FROM wine WHERE wine_name = 'Chardonnay'));

INSERT INTO distributor(distributor_name, wine_id)
VALUES('Eastern Wine', (SELECT wine_id FROM wine WHERE wine_name = 'Cabernet'));

INSERT INTO distributor(distributor_name, wine_id)
VALUES('Pacific Exports', (SELECT wine_id FROM wine WHERE wine_name = 'Chablis'));