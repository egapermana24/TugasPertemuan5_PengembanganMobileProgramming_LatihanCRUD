CREATE TABLE employees (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    salary INT NOT NULL
);

INSERT INTO employees (name, address, salary) VALUES
('Purnama', 'Kota Cirebon', 2500000),
('Dewi Risma', 'Kab Kuningan', 3000000),
('Kankan', 'Kab Cirebon', 2750000);
