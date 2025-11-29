-- Consultar Queries - 
-- Buscar productos que contengan 'Camisa' en el nombre y pertenezcan a la categoría 'Ropa'
SELECT 
    p.name, 
    p.price, 
    c.name AS category_name,
    p.stock_quantity
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE p.name ILIKE '%Camisa%' -- ILIKE para búsqueda insensible a mayúsculas/minúsculas (PostgreSQL)
  AND c.name = 'Ropa';

  -- Obtener los 3 productos más vendidos por cantidad total
SELECT 
    p.name AS product_name, 
    SUM(oi.quantity) AS total_sold_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold_quantity DESC
LIMIT 3;

-- Calcular el total de ventas agrupado por año, mes y categoría
SELECT
    EXTRACT(YEAR FROM o.order_date) AS sale_year,
    EXTRACT(MONTH FROM o.order_date) AS sale_month,
    c.name AS category_name,
    SUM(oi.quantity * oi.price_at_sale) AS monthly_sales_amount
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY 1, 2, 3
ORDER BY sale_year DESC, sale_month DESC, monthly_sales_amount DESC;

-- Calcular el ticket promedio (monto total / número de órdenes) para el último mes
SELECT 
    AVG(total_amount) AS ticket_promedio
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';

-- Identificar productos que nunca han sido vendidos
SELECT 
    p.product_id, 
    p.name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- Clientes frecuentes (2 o más órdenes)
SELECT 
    c.customer_id, 
    c.name, 
    c.email, 
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email
HAVING COUNT(o.order_id) >= 2 -- Umbral configurable (≥ X órdenes)
ORDER BY total_orders DESC;

-- SIMULACIÓN DE CREACIÓN DE UNA ORDEN COMPLETA CON DESCUENTO DE STOCK

BEGIN;

-- 1. Crear la nueva orden y capturar su ID
WITH new_order AS (
    INSERT INTO orders (customer_id, status)
    VALUES (1, 'PROCESSING')
    RETURNING order_id
),
-- 2. Insertar los ítems de la orden (usando el ID recién creado)
inserted_items AS (
    INSERT INTO order_items (order_id, product_id, quantity, price_at_sale)
    SELECT new_order.order_id, 1, 2, 50.00 FROM new_order -- Producto 1
    UNION ALL
    SELECT new_order.order_id, 2, 1, 150.00 FROM new_order -- Producto 2
    RETURNING order_id, quantity, price_at_sale
)
-- 3. Calcular el total y actualizar la orden en un solo paso
UPDATE orders o
SET 
    total_amount = (SELECT SUM(quantity * price_at_sale) FROM inserted_items)
WHERE o.order_id = (SELECT order_id FROM new_order);

-- Registrar movimientos
INSERT INTO inventory_movements (product_id, movement_type, quantity) VALUES
(1, 'OUT', 2),
(2, 'OUT', 1);

-- 4. Actualizar el stock de los productos
UPDATE products SET stock_quantity = stock_quantity - 2 WHERE product_id = 1;
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 2;

COMMIT;
