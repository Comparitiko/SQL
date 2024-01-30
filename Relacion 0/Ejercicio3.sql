SET SQL_SAFE_UPDATES = 0;

USE relacion0;

/* a. Mostrar todos los datos introducidos en cada una de las tablas */ 
SELECT * FROM productos;
SELECT * FROM clientes;
SELECT * FROM facturas;
SELECT * FROM detalles;

/* b. Reemplazar la ciudad del cliente con DNI 51664372R por Granada. */
UPDATE clientes
SET ciudad = "Granada"
WHERE nif = "51664372R";

/* c. Actualizar todos los precios de los productos con un aumento del 10% */
UPDATE productos
SET precio = precio * 1.1;

/* d. Aumentar el stock en 20 unidades para todos los productos y disminuir
el precio de los productos en un 30% */

UPDATE productos
SET stock = stock + 20, precio = precio * 0.70;

/*e. A los productos en los que haya un mínimo de 100 unidades, hacerle un
descuento al precio del 50%*/
UPDATE productos
SET precio = precio * 0.5
WHERE stock >= 100;

/*f. Eliminar al cliente cuyo dni sea 51664372R*/
DELETE FROM clientes
WHERE nif = "51664372R";