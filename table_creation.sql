CREATE TABLE Address (
    address_id INT PRIMARY KEY,
    street_address VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code INT,
    country VARCHAR(50)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(50),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

CREATE TABLE Restaurant (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone_num VARCHAR(20),
    address_id INT,
    cuisine_type VARCHAR(50),
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

CREATE TABLE Menu (   -- Moved Menu table up here
    menu_id INT PRIMARY KEY,
    restaurant_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);

CREATE TABLE Menu_item (
    menu_item_id INT PRIMARY KEY,
    menu_id INT,
    name VARCHAR(50),
    description TEXT,
    price DECIMAL(10, 2),
    FOREIGN KEY (menu_id) REFERENCES Menu(menu_id)
);

CREATE TABLE `Order` (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    delivery_address_id INT,  -- Added new address_id column for delivery address
    status ENUM('Processing', 'Ready For Delivery') NOT NULL,
    order_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (delivery_address_id) REFERENCES Address(address_id)   -- Added foreign key reference
);

CREATE TABLE Order_Items (
    order_id INT,
    menu_item_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (order_id, menu_item_id),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (menu_item_id) REFERENCES Menu_item(menu_item_id)
);

CREATE TABLE Vehicle_Details (
    vehicle_id INT PRIMARY KEY,
    vehicle_type VARCHAR(30),
    vehicle_brand VARCHAR(30),
    vehicle_model VARCHAR(30),
    color VARCHAR(20),
    plate_num VARCHAR(20)
);

CREATE TABLE Driver (
    driver_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone_num VARCHAR(20),
    vehicle_id INT,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle_Details(vehicle_id)
);


CREATE TABLE Deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    driver_id INT,
    delivery_time DATETIME,
    status ENUM('On the Way', 'Delivered') NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    order_id INT,
    card_num VARCHAR(20),  -- Changed from INT to VARCHAR
    sec_num INT(3),
    exp_date VARCHAR(5),
    payment_status ENUM('Processing', 'Declined', 'Approved') NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);

CREATE TABLE RatingReviews (
    review_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    description TEXT,
    rating ENUM('One star', 'Two star', 'Three star', 'Four star', 'Five star'),
    date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);
