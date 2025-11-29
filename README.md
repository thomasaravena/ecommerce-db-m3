

ESTRUCTURA Y EJECUCIÓN



----------------------







El proyecto utiliza PostgreSQL y consta de los siguientes archivos en la carpeta 'sql':







1\\. sql/schema.sql: Define la estructura de las tablas, PK, FK y restricciones.



2\\. sql/seed.sql: Provee datos de prueba esenciales.



3\\. sql/queries.sql: Contiene el análisis de negocio y la lógica transaccional.







ORDEN DE EJECUCIÓN DE SCRIPTS







1\\. schema.sql: Crea todas las tablas y restricciones.



2\\. seed.sql: Rellena las tablas con los datos iniciales.



3\\. queries.sql: Ejecuta las consultas de análisis y la transacción de prueba.







EVIDENCIAS DE CONSULTAS CLAVE (KPIs)



------------------------------------







A continuación, se presentan las evidencias de 4 consultas que demuestran la funcionalidad de la base de datos.







1\\. TOP 3 PRODUCTOS VENDIDOS (CANTIDAD)



\&nbsp;  Muestra la demanda de los productos.



\&nbsp;  Resultado Esperado (Ejemplo):



\&nbsp;  - Auriculares BT: 2



\&nbsp;  - Smartphone X: 1



\&nbsp;  - Camisa Casual L: 1





2\\. VENTAS POR MES Y CATEGORÍA



\&nbsp;  Análisis del rendimiento de ventas por período.



\&nbsp;  Resultado Esperado (Ejemplo):



\&nbsp;  - 2025/9 - Electrónica: 1020.49



\&nbsp;  - 2025/10 - Electrónica: 120.50





3\\. CLIENTES FRECUENTES (>= 2 ÓRDENES)



\&nbsp;  Identificación de clientes de alto valor.



\&nbsp;  Resultado Esperado (Ejemplo):



\&nbsp;  - Beto Pérez (ID 2): 2 órdenes





4\\. TRANSACCIÓN DE CREACIÓN DE ORDEN



\&nbsp;  Demostración de la atomicidad (ACID).



\&nbsp;  - Comando ejecutado: Transacción BEGIN/COMMIT con inserción de 2 ítems.



\&nbsp;  - Validación de Stock: Mostrar la cantidad de stock reducida en los productos afectados.

