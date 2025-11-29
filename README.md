PROYECTO BASE DE DATOS E-COMMERCE (Módulo 3)
===========================================

Este proyecto contiene el diseño conceptual (Modelo E-R) y la implementación relacional (DDL) de la base de datos para un MVP de una plataforma de comercio electrónico.

REQUISITOS Y ENLACES
-------------------

* ENLACE DE GITHUB
  
https://github.com/thomasaravena/ecommerce-db-m3

* MODELO ENTIDAD-RELACIÓN (E-R)
  El diagrama ER modela las entidades centrales (customers, products, orders) y la resolución de la relación N:M a través de order_items.
 

ESTRUCTURA DE ARCHIVOS
----------------------

El proyecto utiliza PostgreSQL y consta de los siguientes archivos:

1. sql/schema.sql: Define la estructura de las tablas, PK, FK y restricciones.
2. sql/seed.sql: Provee datos de prueba esenciales.
3. sql/queries.sql: Contiene el análisis de negocio y la lógica transaccional.
4. README.txt: Este documento.

ORDEN DE EJECUCIÓN DE SCRIPTS

1. schema.sql: Crea todas las tablas y restricciones.
2. seed.sql: Rellena las tablas con los datos iniciales.
3. queries.sql: Ejecuta las consultas de análisis y la transacción de prueba.

EVIDENCIAS DE CONSULTAS CLAVE (KPIs)
------------------------------------

A continuación, se presentan las evidencias de 4 consultas que demuestran la funcionalidad de la base de datos.

1. TOP 3 PRODUCTOS VENDIDOS (CANTIDAD)
   Muestra la demanda de los productos.
   Resultado Esperado (Ejemplo):
   - Auriculares BT: 2
   - Smartphone X: 1
   - Camisa Casual L: 1


2. VENTAS POR MES Y CATEGORÍA
   Análisis del rendimiento de ventas por período.
   Resultado Esperado (Ejemplo):
   - 2025/9 - Electrónica: 1020.49
   - 2025/10 - Electrónica: 120.50


3. CLIENTES FRECUENTES (>= 2 ÓRDENES)
   Identificación de clientes de alto valor.
   Resultado Esperado (Ejemplo):
   - Beto Pérez (ID 2): 2 órdenes
   [Insertar captura de la consola con el resultado de esta consulta]

4. TRANSACCIÓN DE CREACIÓN DE ORDEN
   Demostración de la atomicidad (ACID).
   - Comando ejecutado: Transacción BEGIN/COMMIT con inserción de 2 ítems.
   - Validación de Stock: Mostrar la cantidad de stock reducida en los productos afectados.
