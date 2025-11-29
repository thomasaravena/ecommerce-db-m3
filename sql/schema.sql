-- DDL para PostgreSQL

DROP TABLE IF EXISTS inventory_movements;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;

-- 1. TABLA CUSTOMERS
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. TABLA CATEGORIES
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 3. TABLA PRODUCTS
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Restricciones
    CONSTRAINT chk_price CHECK (price > 0),
    CONSTRAINT chk_stock_quantity CHECK (stock_quantity >= 0),
    
    -- Clave Foránea
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. TABLA ORDERS
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    
    -- Restricción
    CONSTRAINT chk_total_amount CHECK (total_amount >= 0),
    
    -- Clave Foránea
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. TABLA ORDER_ITEMS (Resuelve la relación M:N)
CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_sale NUMERIC(10, 2) NOT NULL, -- Precio al momento de la venta
    
    -- Restricción
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    
    -- Claves Foráneas y Primaria Compuesta
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    PRIMARY KEY (order_id, product_id)
);

-- 6. TABLA PAYMENTS (Mock de pagos)
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL UNIQUE, -- 1:1 con orders
    amount NUMERIC(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_date TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Clave Foránea
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 7. TABLA INVENTORY_MOVEMENTS (Para trazabilidad de stock)
CREATE TABLE inventory_movements (
    movement_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    movement_type VARCHAR(3) NOT NULL, -- 'IN' (Entrada) o 'OUT' (Salida)
    quantity INT NOT NULL,
    movement_date TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Restricciones
    CONSTRAINT chk_movement_type CHECK (movement_type IN ('IN', 'OUT')),
    CONSTRAINT chk_quantity_pos CHECK (quantity > 0),
    
    -- Clave Foránea
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 8. ÍNDICES ÚTILES (Mejora la velocidad de búsqueda)
CREATE INDEX idx_products_name ON products (name);
CREATE INDEX idx_products_category ON products (category_id);
CREATE INDEX idx_orders_customer ON orders (customer_id);