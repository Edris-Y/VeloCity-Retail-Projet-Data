CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25), 
    email VARCHAR(100) NOT NULL,
    street VARCHAR(255) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip_code VARCHAR(10) NOT NULL 
);

CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25) NOT NULL, 
    email VARCHAR(100) NOT NULL,
    street VARCHAR(255) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip_code VARCHAR(10) 
);

CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL 
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL 
);

CREATE TABLE staffs (
    staff_id INT PRIMARY KEY,  
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25) NOT NULL,
    active BOOLEAN,  
    store_id INT NOT NULL,
    manager_id INT, 
    FOREIGN KEY (store_id) REFERENCES stores (store_id) 
);

CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year INT NOT NULL,  
    list_price DECIMAL(10, 2) NOT NULL,  
    FOREIGN KEY (brand_id) REFERENCES brands (brand_id), 
    FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_status INT NOT NULL,
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE,  
    store_id INT NOT NULL,
    staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id), 
    FOREIGN KEY (store_id) REFERENCES stores (store_id),
    FOREIGN KEY (staff_id) REFERENCES staffs (staff_id) 
);

CREATE TABLE order_items (
    order_id INT,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10, 2) NOT NULL, 
    discount DECIMAL(4, 2) NOT NULL DEFAULT 0,  
    PRIMARY KEY (order_id, item_id),  
    FOREIGN KEY (product_id) REFERENCES products (product_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id) 
);

CREATE TABLE stocks (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, product_id), 
    FOREIGN KEY (store_id) REFERENCES stores (store_id), 
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);


-- ==========================================
-- 1. TABLES MAÎTRES (Les Parents)
-- ==========================================
COPY categories FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\categories.csv' DELIMITER ',' CSV HEADER;
COPY brands FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\brands.csv' DELIMITER ',' CSV HEADER;
COPY stores FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\stores.csv' DELIMITER ',' CSV HEADER;
COPY customers FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\customers.csv' DELIMITER ',' CSV HEADER;

-- ==========================================
-- 2. TABLES INTERMÉDIAIRES
-- ==========================================
COPY staffs FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\staffs.csv' DELIMITER ',' CSV HEADER;
COPY products FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\products.csv' DELIMITER ',' CSV HEADER;

-- ==========================================
-- 3. TABLES ENFANTS (Les transactions)
-- ==========================================
COPY orders FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\orders.csv' DELIMITER ',' CSV HEADER;
COPY order_items FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\order_items.csv' DELIMITER ',' CSV HEADER;
COPY stocks FROM 'C:\Users\Edris\Desktop\VeloCity Retail\data\stocks.csv' DELIMITER ',' CSV HEADER;