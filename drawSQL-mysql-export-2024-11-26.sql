

CREATE DATABASE online_store;

CREATE TABLE `customers`(
    `id` INT UNSINED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL
);

CREATE TABLE `orders`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `customer_id` BIGINT NOT NULL,
    `order_date` DATE NOT NULL,
    `total_amount` BIGINT NOT NULL
);
CREATE TABLE `products`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `price` INT NOT NULL,
    `description` BIGINT NOT NULL
);

-- 1.Retrieve all customers who have placed an order in the last 30 days.

SELECT customer.customer_id, customers.name 
FROM customers
JOIN orders ON customers.customers_id = orders.customer_id
WHERE orders.orders_date >= CURDATE() - INTERVAL 30 DAY;

-- 2.Get the total amount of all orders placed by each customer.

SELECT customers.id, customers.name,  SUM(orders.total_amount) AS total_spent
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id, customers.name, customers.email;

-- 3.Update the price  of the headphone  (product c) to 45.00

UPDATE products
set price = 45.00
WHERE product ='headephones';

-- 4. add a new column discount to the product table

ALTER TABLE product
ADD discount DECIMAL (5, 2) DEFAULT 0.00;

-- 5. Retrieve top 3 products with highesst price

SELECT id, name, price
FROM products
ORDER BY price DESC
LIMIT 3;

-- 6. Get the name of customers who have ordered product A (Laptop)
SELECT DISTINCT customers.name
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
WHERE products.name = 'Product A';

--7.Join the orders and customers tables to retrieve the customer’s name and order date for each order
SELECT customers.name, orders.order_date
FROM orders
JOIN customers ON orders.customer_id = customers.id;

--8.Retrieve the orders with a total amount greater than 150.00
SELECT id, customer_id, order_date, total_amount
FROM orders
WHERE total_amount > 150.00;

--9.Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table.

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,                   
    product_id INT NOT NULL,                   
    quantity INT NOT NULL,                     
    price DECIMAL(10, 2) NOT NULL,             
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, CURDATE(), 85.00),
(2, CURDATE(), 40.00);

---10.Retrieve the average total of all orders

SELECT AVG(total_amount) AS average_order_total
FROM orders;




