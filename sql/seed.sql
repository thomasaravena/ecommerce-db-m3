/**
 * Archivo: seed.sql
 * Propósito: Insertar datos de prueba para el modelo de e-commerce
 */

-- 1. Insertar datos en CATEGORIES
INSERT INTO categories (name) VALUES
('Electrónica'),
('Ropa'),
('Hogar y Cocina'),
('Libros');


-- 2. Insertar datos en CUSTOMERS (Clientes)
INSERT INTO customers (name, email) VALUES
('Ana García', 'ana.garcia@email.com'),          -- customer_id 1
('Beto Pérez', 'beto.perez@email.com'),          -- customer_id 2 (Cliente frecuente)
('Carla Soto', 'carla.soto@email.com');          -- customer_id 3


-- 3. Insertar datos en PRODUCTS (Productos)
-- Nota: Usamos 4 categorías (IDs 1 al 4)
INSERT INTO products (name, description, price, stock_quantity, category_id) VALUES
-- Electrónica (ID 1)
('Smartphone X', 'Teléfono móvil de alta gama.', 899.99, 50, 1),   -- product_id 1 (Alta Venta)
('Auriculares BT', 'Cancelación de ruido.', 120.50, 150, 1),       -- product_id 2 (Stock alto)
-- Ropa (ID 2)
('Camisa Casual L', 'Camisa de algodón, talla L.', 35.00, 10, 2),  -- product_id 3 (Stock bajo)
('Pantalón Jeans', 'Jeans de corte recto.', 55.00, 75, 2),        -- product_id 4
-- Hogar y Cocina (ID 3)
('Licuadora Pro', 'Motor 1200W, acero inoxidable.', 79.90, 30, 3), -- product_id 5
('Juego de Sartenes', 'Anti-adherentes, 3 piezas.', 45.50, 0, 3),   -- product_id 6 (Stock CERO)
-- Libros (ID 4)
('El Principito', 'Clásico de la literatura.', 15.00, 200, 4),    -- product_id 7 (Sin ventas aún)
('Manual SQL', 'Guía completa de SQL.', 29.99, 100, 4);           -- product_id 8


-- 4. Insertar datos en ORDERS (Órdenes)
-- Nota: Usamos fechas pasadas para simular un historial.
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2025-09-10 14:30:00', 1010.49, 'COMPLETED'), -- order_id 1: Ana (Compra grande)
(2, '2025-09-15 09:15:00', 35.00, 'COMPLETED'),   -- order_id 2: Beto (Cliente frecuente 1)
(2, '2025-10-01 11:00:00', 120.50, 'COMPLETED'),  -- order_id 3: Beto (Cliente frecuente 2)
(3, '2025-10-20 18:45:00', 79.90, 'PENDING');     -- order_id 4: Carla (Orden reciente)


-- 5. Insertar datos en ORDER_ITEMS (Detalles de la Orden)
-- Orden 1 (Ana)
INSERT INTO order_items (order_id, product_id, quantity, price_at_sale) VALUES
(1, 1, 1, 899.99), -- Smartphone X
(1, 2, 1, 120.50); -- Auriculares BT
-- Orden 2 (Beto - Compra 1)
INSERT INTO order_items (order_id, product_id, quantity, price_at_sale) VALUES
(2, 3, 1, 35.00);  -- Camisa Casual L
-- Orden 3 (Beto - Compra 2)
INSERT INTO order_items (order_id, product_id, quantity, price_at_sale) VALUES
(3, 2, 1, 120.50); -- Auriculares BT
-- Orden 4 (Carla)
INSERT INTO order_items (order_id, product_id, quantity, price_at_sale) VALUES
(4, 5, 1, 79.90);  -- Licuadora Pro


-- 6. Insertar datos en PAYMENTS (Pagos)
INSERT INTO payments (order_id, amount, payment_method, payment_date) VALUES
(1, 1010.49, 'Tarjeta Crédito', '2025-09-10 14:35:00'),
(2, 35.00, 'Transferencia', '2025-09-15 09:18:00'),
(3, 120.50, 'Tarjeta Débito', '2025-10-01 11:02:00');
-- Nota: La Orden 4 (Carla) está PENDING, por lo que no tiene pago registrado.


-- 7. Insertar datos en INVENTORY_MOVEMENTS (Movimientos de Stock)
-- Entradas iniciales (Mock de cuando se ingresó stock)
INSERT INTO inventory_movements (product_id, movement_type, quantity) VALUES
(1, 'IN', 100),
(2, 'IN', 200),
(3, 'IN', 50),
(4, 'IN', 100),
(5, 'IN', 50),
(6, 'IN', 10),
(7, 'IN', 200),
(8, 'IN', 100);

-- Salidas por ventas (Corresponde a las order_items)
INSERT INTO inventory_movements (product_id, movement_type, quantity) VALUES
(1, 'OUT', 1), -- Orden 1
(2, 'OUT', 1), -- Orden 1
(3, 'OUT', 1), -- Orden 2
(2, 'OUT', 1), -- Orden 3
(5, 'OUT', 1); -- Orden 4 (pendiente de pago, pero stock descontado)