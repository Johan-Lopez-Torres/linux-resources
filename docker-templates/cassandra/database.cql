-- Crear Keyspace
CREATE KEYSPACE IF NOT EXISTS ecommerce
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

-- Seleccionar el Keyspace
USE ecommerce;

-- Crear la tabla de productos (información básica de productos)
CREATE TABLE IF NOT EXISTS products (
    product_id UUID PRIMARY KEY,               -- ID único del producto
    name TEXT,                                 -- Nombre del producto
    description TEXT,                          -- Descripción del producto
    price DECIMAL,                             -- Precio del producto
    stock INT,                                 -- Cantidad de stock disponible
    category TEXT                              -- Categoría del producto (Ej: Electrónica, Ropa)
);

-- Crear la tabla de clientes (información básica de los clientes)
CREATE TABLE IF NOT EXISTS customers (
    customer_id UUID PRIMARY KEY,              -- ID único del cliente
    first_name TEXT,                           -- Nombre del cliente
    last_name TEXT,                            -- Apellido del cliente
    email TEXT,                                -- Correo electrónico del cliente
    phone TEXT,                                -- Teléfono del cliente
    address TEXT                               -- Dirección del cliente
);

-- Crear la tabla de pedidos (información sobre cada pedido realizado)
CREATE TABLE IF NOT EXISTS orders (
    order_id UUID PRIMARY KEY,                 -- ID único del pedido
    customer_id UUID,                          -- ID del cliente que hizo el pedido
    order_date TIMESTAMP,                      -- Fecha y hora en que se hizo el pedido
    total_amount DECIMAL,                      -- Monto total del pedido
    status TEXT                                -- Estado del pedido (Ej: "pendiente", "enviado", "entregado")
);

-- Crear la tabla de detalles de los pedidos (productos específicos en cada pedido)
CREATE TABLE IF NOT EXISTS order_details (
    order_id UUID,                             -- ID del pedido (clave primaria compuesta)
    product_id UUID,                           -- ID del producto (clave primaria compuesta)
    quantity INT,                              -- Cantidad del producto en ese pedido
    price DECIMAL,                             -- Precio del producto en ese momento
    PRIMARY KEY (order_id, product_id)         -- Clave primaria compuesta
);

-- Crear la tabla de historial de compras (qué productos ha comprado un cliente)
CREATE TABLE IF NOT EXISTS customer_purchase_history (
    customer_id UUID,                          -- ID del cliente
    product_id UUID,                           -- ID del producto comprado
    purchase_date TIMESTAMP,                    -- Fecha de la compra
    quantity INT,                              -- Cantidad de productos comprados
    PRIMARY KEY (customer_id, purchase_date, product_id) -- Clave primaria compuesta
);

-- Ejemplo de inserción de un producto
INSERT INTO products (product_id, name, description, price, stock, category)
VALUES (uuid(), 'Smartphone', 'Smartphone de última generación', 599.99, 50, 'Electrónica');

-- Ejemplo de inserción de un cliente
INSERT INTO customers (customer_id, first_name, last_name, email, phone, address)
VALUES (uuid(), 'Juan', 'Pérez', 'juan@example.com', '555-1234', 'Calle Ficticia 123, Ciudad');

-- Ejemplo de inserción de un pedido
INSERT INTO orders (order_id, customer_id, order_date, total_amount, status)
VALUES (uuid(), 'cliente-uuid', toTimestamp(now()), 1199.98, 'pendiente');

-- Ejemplo de inserción de los detalles de un pedido
INSERT INTO order_details (order_id, product_id, quantity, price)
VALUES ('pedido-uuid', 'producto-uuid', 2, 599.99);

-- Ejemplo de inserción en el historial de compras de un cliente
INSERT INTO customer_purchase_history (customer_id, product_id, purchase_date, quantity)
VALUES ('cliente-uuid', 'producto-uuid', toTimestamp(now()), 2);

-- Consultas de ejemplo

-- Buscar todos los productos de la categoría "Electrónica"
SELECT * FROM products WHERE category = 'Electrónica';

-- Buscar los detalles de un pedido específico
SELECT * FROM order_details WHERE order_id = 'pedido-uuid';

-- Consultar el historial de compras de un cliente
SELECT * FROM customer_purchase_history WHERE customer_id = 'cliente-uuid';

-- Ver el total de ventas por cliente
SELECT customer_id, SUM(total_amount) FROM orders GROUP BY customer_id;
