DROP DATABASE IF EXISTS ski_resort;
CREATE DATABASE ski_resort;
USE ski_resort;

CREATE TABLE zones(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE slopes(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    length INT,
    snow_depth INT,
    altitude INT,
    difficulty VARCHAR(50),
    zone_id INT,
    FOREIGN KEY (zone_id) REFERENCES zones(id)
);

CREATE TABLE slope_status(
	id INT AUTO_INCREMENT PRIMARY KEY,
    slope_id INT,
    status VARCHAR(50),
    date DATE,
    FOREIGN KEY (slope_id)REFERENCES slopes(id)
);

CREATE TABLE lifts(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    number INT,
    type VARCHAR(50),
    length INT,
    capacity INT
);

CREATE TABLE lift_status(
	id INT AUTO_INCREMENT PRIMARY KEY,
    lift_id INT,
    status VARCHAR(50),
    date DATE,
    FOREIGN KEY(lift_id) REFERENCES lifts(id)
);

CREATE TABLE pass_types(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50)
);

CREATE TABLE ski_times(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE passes(
	id INT AUTO_INCREMENT PRIMARY KEY,
    ski_time_id INT,
    pass_type_id INT,
    FOREIGN KEY (ski_time_id) REFERENCES ski_times(id),
    FOREIGN KEY (pass_type_id)REFERENCES pass_types(id)
);

CREATE TABLE day_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE pass_prices(
	id INT AUTO_INCREMENT PRIMARY KEY,
    pass_id INT,
    price DECIMAL(10,2),
    valid_from DATE,
    valid_to DATE,
    day_type_id INT,
    FOREIGN KEY(pass_id)REFERENCES passes(id),
	FOREIGN KEY (day_type_id) REFERENCES day_types(id)
);

CREATE TABLE pass_lifts(
	pass_id INT,
    lift_id INT,
    PRIMARY KEY(pass_id,lift_id),
    FOREIGN KEY(pass_id)REFERENCES passes(id),
    FOREIGN KEY(lift_id)REFERENCES lifts(id)
);

CREATE TABLE weather (
	id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    temperature DECIMAL(5,2),
    snow_depth INT,
    wind_speed INT
);

CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR (100),
    email VARCHAR(100)
); 

CREATE TABLE employees(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE employee_assignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    lift_id INT,
    shift_start DATETIME,
    shift_end DATETIME,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (lift_id) REFERENCES lifts(id)
);

CREATE TABLE purchases(
	id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    pass_id INT,
    purchase_date DATE,
    price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (pass_id) REFERENCES passes(id)
);

CREATE TABLE incidents(
	id INT AUTO_INCREMENT PRIMARY KEY,
    slope_id INT,
    description TEXT,
    incident_date DATE,
    severity VARCHAR(50),
    employee_id INT,
    FOREIGN KEY (slope_id) REFERENCES slopes(id),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE lift_usage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lift_id INT,
    usage_time DATETIME,
    people_count INT,
    FOREIGN KEY (lift_id) REFERENCES lifts(id)
);

INSERT INTO day_types (name) VALUES
('weekday'), ('weekend'), ('holiday');

INSERT INTO ski_times (name) VALUES 
('сутрешно'), ('следобедно'), ('нощно');

INSERT INTO pass_types (name) VALUES 
('детска'), ('студентска'), ('нормална');


INSERT INTO lifts (name, number, type, length, capacity) VALUES
('Lift A', 1, 'седалков', 1200, 200),
('Lift B', 2, 'кабинков', 2000, 300),
('Lift C', 3, 'влек', 800, 100),
('Lift D', 4, 'седалков', 1500, 250);

INSERT INTO passes (ski_time_id, pass_type_id) VALUES
(1,1),
(2,2),
(3,3),
(1,2),
(2,3),
(3,1);

INSERT INTO pass_lifts VALUES
(1,1),
(1,2),
(2,1),
(3,2),
(4,3),
(5,4),
(6,1);

INSERT INTO zones (name) VALUES
('Централна зона'),
('Северна зона'),
('Южна зона');

INSERT INTO slopes (name, length, snow_depth, altitude, difficulty, zone_id) VALUES
('Vitosha Run', 1500, 80, 1800, 'medium', 1),
('Black Peak', 2000, 100, 2200, 'hard', 2),
('Easy Ride', 800, 60, 1500, 'easy', 3),
('Snow Rider', 1200, 75, 1700, 'medium', 1),
('Ice Track', 1800, 90, 2100, 'hard', 2),
('Family Slope', 600, 50, 1400, 'easy', 3),
('Extreme Line', 2200, 110, 2300, 'hard', 2),
('Sunny Path', 900, 65, 1600, 'easy', 1),
('Forest Run', 1300, 85, 1750, 'medium', 3);

INSERT INTO weather (date, temperature, snow_depth, wind_speed) VALUES
('2026-01-10', -5, 90, 20),
('2026-01-11', -3, 85, 15),
('2026-01-12', -6, 95, 18),
('2026-01-13', -2, 80, 12),
('2026-01-14', 0, 70, 10),
('2026-01-15', 2, 60, 8),
('2026-01-16', -4, 85, 22),
('2026-01-17', -7, 100, 25),
('2026-01-18', -3, 90, 15),
('2026-01-19', 1, 65, 9),
('2026-01-20', -5, 88, 20);

INSERT INTO slope_status (slope_id, status, date) VALUES
(1, 'open', '2026-01-10'),
(2, 'closed', '2026-01-10'),
(3, 'open', '2026-01-10'),
(1, 'closed', '2026-01-12'),
(2, 'open', '2026-01-12'),
(3, 'closed', '2026-01-12');

INSERT INTO customers (first_name, last_name, email) VALUES
('Ivan', 'Ivanov', 'ivan@mail.com'),
('Maria', 'Petrova', 'maria@mail.com'),
('Stoyan', 'Dimitrov', 'stoyan@mail.com'),
('Elena', 'Georgieva', 'elena@mail.com'),
('Nikola', 'Kolev', 'nikola@mail.com');

INSERT INTO employees (name, role, salary) VALUES
('Georgi Georgiev', 'operator', 1500),
('Petar Petrov', 'rescue', 1800),
('Ivan Petrov', 'operator', 1600),
('Maria Ivanova', 'cashier', 1400),
('Dimitar Stoyanov', 'technician', 2000),
('Nikolay Kolev', 'rescue', 1900),
('Elena Dimitrova', 'manager', 2500),
('Georgi Ivanov', 'operator', 1550),
('Petya Petrova', 'cashier', 1450),
('Hristo Georgiev', 'technician', 2100); 

INSERT INTO employee_assignments (employee_id, lift_id, shift_start, shift_end) VALUES
(1, 1, '2026-01-11 08:00:00', '2026-01-11 16:00:00'),
(2, 2, '2026-01-11 09:00:00', '2026-01-11 17:00:00'),
(3, 3, '2026-01-11 10:00:00', '2026-01-11 18:00:00');

INSERT INTO purchases (customer_id, pass_id, purchase_date, price) VALUES

(1, 2, '2026-01-15', 70),

(2, 1, '2026-01-16', 50),
(2, 4, '2026-01-22', 50),

(3, 2, '2026-01-18', 70),
(3, 5, '2026-01-25', 70),
(3, 3, '2026-01-28', 80),

(4, 3, '2026-01-19', 80),
(4, 6, '2026-01-26', 60),
(4, 1, '2026-02-01', 50),
(4, 2, '2026-02-05', 70),

(5, 1, '2026-01-21', 50),
(5, 2, '2026-01-27', 70),
(5, 3, '2026-02-02', 80),
(5, 4, '2026-02-08', 50),
(5, 5, '2026-02-10', 70);

INSERT INTO incidents (slope_id, description, incident_date, severity) VALUES
(2, 'Сблъсък между двама скиори', '2026-01-10', 'medium'),
(1, 'Падане без травма', '2026-01-11', 'low'),
(3, 'Леко подхлъзване', '2026-01-12', 'low'),
(2, 'Сериозно падане със счупване', '2026-01-13', 'high');

INSERT INTO lift_status (lift_id, status, date) VALUES
(1, 'working', '2026-01-10'),
(2, 'maintenance', '2026-01-10'),
(3, 'working', '2026-01-11'),
(4, 'working', '2026-01-11'),
(2, 'working', '2026-01-12');


INSERT INTO pass_prices (pass_id, price, valid_from, valid_to, day_type_id) VALUES
(1, 50, '2026-01-01', '2026-03-01', 1),
(1, 70, '2026-01-01', '2026-03-01', 2),
(2, 80, '2026-01-01', '2026-02-01', 2),
(3, 45, '2026-01-01', '2026-02-01', 1),
(4, 60, '2026-01-01', '2026-02-01', 3);

INSERT INTO lift_usage (lift_id, usage_time, people_count) VALUES
(1, '2026-01-10 10:00:00', 120),
(1, '2026-01-10 11:00:00', 180),
(2, '2026-01-11 12:00:00', 200),
(3, '2026-01-11 13:00:00', 150),
(4, '2026-01-11 14:00:00', 90);


-- 2 SELECT (всички лофтовве, които имат капацитет над 150 и в момента работят) --
SELECT l.name, l.capacity, ls.status, ls.date
FROM lifts l
JOIN lift_status ls ON l.id = ls.lift_id
WHERE l.capacity > 150
AND ls.status = 'working';

-- 3 (брой инциденти по тежест) --
SELECT severity, COUNT(*) AS total_incidents
FROM incidents
GROUP BY severity;

-- 4 (Покажи покупки + клиент + тип карта)  --
SELECT c.first_name, c.last_name,
pt.name AS pass_type, st.name AS ski_time, pu.price, pu.purchase_date
FROM purchases pu
JOIN customers c ON pu.customer_id = c.id
JOIN passes p ON pu.pass_id = p.id
JOIN pass_types pt ON p.pass_type_id = pt.id
JOIN ski_times st ON p.ski_time_id = st.id;

-- 5(Всички лифтове + дали имат използване) --
SELECT l.name, lu.people_count
FROM lifts l
LEFT JOIN lift_usage lu ON l.id = lu.lift_id;

-- 6(Писти, които имат инциденти)--
SELECT name
FROM slopes
WHERE id IN (
    SELECT slope_id
    FROM incidents
);

-- 7 (Най-натоварени лифтове)--
SELECT l.name, SUM(lu.people_count) AS total_people
FROM lifts l
JOIN lift_usage lu ON l.id = lu.lift_id
GROUP BY l.name
ORDER BY total_people DESC;

-- 8 (Освен проверка → правим и автоматична защита) --
DELIMITER //

CREATE TRIGGER check_capacity
BEFORE INSERT ON lifts
FOR EACH ROW
BEGIN
    IF NEW.capacity < 0 THEN
        SET NEW.capacity = 0;
    END IF;
END //

DELIMITER ;

-- 9 (Процедура за показване на най-активни клиентиПроцедура за показване на най-активни клиенти) --
DELIMITER //

CREATE PROCEDURE top_customers()
BEGIN
    SELECT 
        c.first_name,
        c.last_name,
        COUNT(pu.id) AS total_purchases
    FROM customers c
    JOIN purchases pu ON c.id = pu.customer_id
    GROUP BY c.id
    ORDER BY total_purchases DESC;
END //

DELIMITER ;

CALL top_customers();

-- ДОПЪЛНИТЕЕЛНИ ЗАЯВКИ --

-- ПРОВЕРКА НА СТАТУС НА ЛИФТОВЕ--
USE ski_resort;
SELECT l.name, ls.status
FROM lifts l
JOIN lift_status ls ON l.id = ls.lift_id
WHERE ls.date = '2026-01-10';

-- ПРИХОДИ ОТ ПРОДАЖБИ  -- 
SELECT l.name, SUM(pu.price) AS revenue
FROM lifts l
JOIN pass_lifts pl ON l.id = pl.lift_id
JOIN purchases pu ON pl.pass_id = pu.pass_id
GROUP BY l.name;

-- Приходи по ден --
SELECT purchase_date, SUM(price) AS total_revenue
FROM purchases
GROUP BY purchase_date;SELECT purchase_date, SUM(price) AS total_revenue
FROM purchases
GROUP BY purchase_date;

-- Най-опасни писти--
SELECT s.name, COUNT(i.id) AS incidents
FROM slopes s
JOIN incidents i ON s.id = i.slope_id
GROUP BY s.name
ORDER BY incidents DESC;

