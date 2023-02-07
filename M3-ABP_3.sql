/* AE2_ABP3*/

/* Crear BD */
CREATE DATABASE tienda;

/* Seleccionar BD */
USE tienda;

/* CREAR TABLA fabricante */
CREATE TABLE fabricante (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DOUBLE NOT NULL,
id_fabricante INT UNSIGNED NOT NULL,
FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');
INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/* 1. Lista el nombre de todos los productos que hay en la tabla producto. */
SELECT nombre from producto;

/* 2. Lista los nombres y los precios de todos los productos de la tabla producto. */
SELECT nombre, precio from producto;

/* 3. Lista todas las columnas de la tabla producto. */
SELECT * FROM producto;

/* 4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD) */
SELECT nombre, precio as EUR, (precio * 1.09) AS 'USD'
FROM producto;

/* 5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares. */
SELECT nombre as 'Nombre de Producto', precio as euros, (precio * 1.09) as dólares
FROM producto;

/* 6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los
nombres a mayúscula. */
SELECT UPPER(nombre), precio
FROM producto;

/* 7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los
nombres a minúscula */
SELECT LOWER(nombre), precio
FROM producto;

/* 8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en
mayúsculas los dos primeros caracteres del nombre del fabricante. */
SELECT nombre, UPPER(LEFT (NOMBRE, 2)) AS INICIALES
FROM fabricante;

/* 9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor
del precio. */
SELECT nombre, round(precio)
FROM producto;

/* 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del
precio para mostrarlo sin ninguna cifra decimal. */
SELECT nombre, truncate(precio,0)
FROM producto;

/* 11. Lista el identificador de los fabricantes que tienen productos en la tabla producto. */
SELECT id_fabricante
FROM producto;

/* 12. Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los
identificadores que aparecen repetidos. */
SELECT DISTINCT id_fabricante
FROM producto;

/* 13. Lista los nombres de los fabricantes ordenados de forma ascendente. */
SELECT nombre
FROM fabricante order by nombre asc;

/* 14. Lista los nombres de los fabricantes ordenados de forma descendente */
SELECT nombre
FROM fabricante order by nombre desc;

/* 15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente
y en segundo lugar por el precio de forma descendent */
SELECT nombre, precio
FROM producto order by nombre asc, precio desc;

/* 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante. */
SELECT *
FROM fabricante
LIMIT 5;

/* 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también
se debe incluir en la respuesta.*/
SELECT *
FROM fabricante
LIMIT 3, 2;

/* 18. Lista el nombre y el precio del producto más barato (Utilice solamente las clásulas ORDERY BY y LIMIT */
SELECT * 
FROM producto order by precio asc
LIMIT 1;

/* 19. Lista el nombre y precio del producto más caro (Utilice solamente las cláusulas ORDERY BY Y LIMIT*/
SELECT *
FROM producto order by precio desc
LIMIT 1;

/* 20. Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2 */
SELECT *
FROM producto
WHERE id_fabricante = 2;

/* 21. Lista el nombre de los productos que tienen precio menor o igual a 120 Euros */
SELECT nombre
FROM producto
WHERE precio <= 120;

/* 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400 EUR*/
SELECT nombre
FROM producto
WHERE precio >= 400;

/* 23. Lista el nombre de los producto que no tienen un precio mayor o igual a 400 EUR*/
SELECT nombre
FROM producto
WHERE NOT precio >= 400;

/* 24. Lista todos los productos que tengan un precio entre 80EUR y 300EUR. Sin utilizar el operador BETWEEN */
SELECT *
FROM producto
WHERE precio >= 80 AND precio <= 300;

/* 25. Lista todos los productos que tentan un precio entre los 60EUR y 200EUR. Utilizan el operador BETWEEN */
SELECT *
FROM producto
WHERE precio between 60 AND 200;

/* 26. Lista todos los productos que tengan un precio mayor que 200 EUR y que el identificador de fabricante sea igual a 6 */
SELECT *
FROM producto
WHERE precio > 200
AND id_fabricante = 6;

/* 27. Lista todos los productos donde el identificador de fabricante sea 1,3 o 5. Sin utilizar el operador IN.*/
SELECT *
FROM producto
WHERE id_fabricante = 1
OR id_fabricante = 3
OR id_fabricante = 5;

/* 28. Lista todos los productos donde el identificador de fabricante sea 1,3 o 5. Utilizando el operador IN */
SELECT *
FROM producto
WHERE id_fabricante IN(1,3,5);

/* 29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio).  Cree un alias para la columna que contiene el precio que se llame céntimos */
SELECT nombre, precio, (precio *100) AS 'Céntimos'
FROM producto;

/* 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S. */
SELECT nombre
FROM fabricante
WHERE nombre LIKE 'S%';

/* 31. Lista los nombres de los fabricantes cuyo nombre termine con la vocal e. */
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%e';

/* 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w. */
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%w%';

/* 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres. */
SELECT nombre
FROM fabricante
WHERE length(nombre) = 4;

/* 34. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre */
SELECT nombre
FROM producto 
WHERE nombre like "%Portátil%";

/* 35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 EUR */
SELECT nombre
FROM producto
WHERE nombre LIKE '%Monitor%' AND precio < 215;

/* 36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180 EUR. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente) */
SELECT nombre, precio
FROM producto
WHERE precio >= 180 order by precio desc, nombre asc;

/* CONSULTAS MULTITABLA (COMPOSICION INTERNA)*/

/* 1. Devuelve una lista con el nombre de producto, precio y nombre de fabricante de todos los productos de la base de datos */
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto LEFT JOIN fabricante
ON fabricante.id = producto.id_fabricante;

/* 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
ORDER BY fabricante.nombre;

/* 3. Devuelve una lista con el identificador del producto, nombre del producto, identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos. */
SELECT producto.id, producto.nombre, producto.id_fabricante, fabricante.nombre
FROM producto
INNER JOIN fabricante;

/* 4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
ORDER BY producto.precio ASC
LIMIT 1;

/* 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro. */
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
ORDER BY producto.precio DESC
LIMIT 1;

/* 6. Devuelve una lista de todos los productos del fabricante Lenovo. */
SELECT producto.nombre, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
HAVING fabricante.nombre = 'Lenovo';

/* 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que
200€. */
SELECT producto.nombre, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
HAVING fabricante.nombre = 'Crucial';

/* 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate.
Sin utilizar el operador IN. */
SELECT fabricante.nombre, producto.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
HAVING fabricante.nombre = 'Asus'
	OR fabricante.nombre = 'Hewlett-Packard'
    OR fabricante.nombre = 'Seagate'
;
    
/* 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate.
Utilizando el operador IN. */
SELECT fabricante.nombre, producto.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
HAVING fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate')
;

/* 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo
nombre termine por la vocal e. */
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
HAVING fabricante.nombre LIKE '%e'
;

/* 11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante
contenga el carácter w en su nombre.*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
HAVING fabricante.nombre LIKE '%w%'
;

/* 12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los
productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el
precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente) */
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
HAVING producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC
;

/* 13.Devuelve un listado con el identificador y el nombre de fabricante, solamente de aquellos
fabricantes que tienen productos asociados en la base de dato */
SELECT producto.id_fabricante, fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY producto.id_fabricante
;



/* CONSULTAS MULTITABLAS (COMPOSICION EXTERNA) */
/* Resuelva todas las consultas utilizando LEFT JOIN y RIGHT JOIN */

/* 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos.  El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados */
SELECT fabricante.nombre as 'FABRICANTE', producto.nombre AS 'PRODUCTO'
FROM fabricante
LEFT JOIN producto
ON fabricante.id = producto.id_fabricante
;

/* 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto
asociado */
/* OPCION A */
SELECT COUNT(id_fabricante) AS Cuenta, fabricante.nombre
FROM producto
RIGHT JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.nombre
HAVING Cuenta = 0;

/* OPCION B */
SELECT f.nombre, p.nombre
from fabricante f left join producto p
on f.id = p.id_fabricante
where p.nombre is null;

/* 3.  ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta. */
/* Primero vamos a intentar agregar un registro con un id_fabricante INVÁLIDO */
INSERT INTO producto
(nombre, precio, id_fabricante)
VALUES
("POLLO CON PAPAS", 2000, 11);
/*RESPUESTA: No es posible que haya un producto SIN fabricante ya que en la tabla producto en el campo id_fabricante está establecido como NOT NULL, sin embargo esta no es la única restricción ya que también se encuentra definida como LLAVE FORÁNEA con la tabla fabricante que impedirá el ingreso de un registro sin un id_fabricante válido (QUE EXISTE UN ID  EN LA TABLA FABRICANTE*/



/* CONSULTAS RESUMEN */
/* 1. Calcula el número total de productos que hay en la tabla productos. */
SELECT COUNT(*) AS 'TOTAL PRODUCTOS'
FROM producto
;

/* 2. Calcula el número total de productos que hay en la tabla productos.*/
SELECT COUNT(*)
FROM producto
;

/* 3. Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos. */
SELECT COUNT(DISTINCT(id_fabricante)) AS 'Q DE FAB.'
FROM producto
;

/* 4. Calcula la media del precio de todos los productos */
SELECT avg(precio) AS 'Media de Precios'
FROM producto
;

/* 5. Calcula el precio más barato de todos los productos */
SELECT MIN(precio) as 'MIN PRECIO'
FROM producto
;

/*  6. Calcula el precio más caro de todos los productos. */
SELECT MAX(precio) as 'MAX PRECIO'
FROM producto


/* 7. Lista el nombre y el precio del producto más barato. */
SELECT nombre, precio
FROM producto
ORDER BY precio asc
LIMIT 1
;

/* 8. Lista el nombre y el precio del producto más caro. */
SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1
;

/* 9. Calcula la suma de los precios de todos los productos. */
SELECT sum(precio) AS 'Suma'
FROM producto
;

/* 10. Calcula el número de productos que tiene el fabricante Asus. */
SELECT count(producto.id_fabricante) AS 'Q', fabricante.nombre AS 'FABRICANTE'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
WHERE fabricante.nombre = 'Asus'
;

/* 11. Calcula la media del precio de todos los productos del fabricante Asus */
SELECT AVG(producto.precio) AS 'MEDIA', fabricante.nombre AS 'FABRICANTE'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
WHERE fabricante.nombre = 'Asus'
;

/* 12. Calcula el precio más barato de todos los productos del fabricante Asus */
SELECT MIN(producto.precio) AS 'MIN', fabricante.nombre AS 'FABRICANTE'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
WHERE fabricante.nombre  = 'Asus'
;

/* 13. Calcula el precio más caro de todos los productos del fabricante Asus */
SELECT MAX(producto.precio) AS 'MAX', fabricante.nombre AS 'FABRICANTE'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
WHERE fabricante.nombre = 'Asus'
;

/* 14. Calcula la suma de todos los productos del fabricante Asus. */
SELECT SUM(producto.precio) as 'SUM', fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
WHERE fabricante.nombre = 'Asus'
;

/* 15. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene
el fabricante Crucial */
SELECT MAX(producto.precio) AS 'MAX', MIN(producto.precio) AS 'MIN', AVG(producto.precio) 'AVG', COUNT(producto.id_fabricante) AS 'Q', fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
WHERE fabricante.nombre = 'Crucial'
;

/* 16. Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también
debe incluir los fabricantes que no tienen ningún producto. El resultado mostrará dos columnas,
una con el nombre del fabricante y otra con el número de productos que tiene. Ordene el
resultado descendentemente por el número de productos */
SELECT fabricante.nombre, COUNT(producto.id_fabricante) AS 'Q'
FROM producto
RIGHT JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.nombre
ORDER BY Q DESC
;

/* 17. Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los
fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se solicitan. */
SELECT MAX(producto.precio) AS 'MAX', MIN(producto.precio) AS 'MIN', AVG(producto.precio) AS 'AVG', fabricante.nombre AS 'FABRICANTE'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.nombre
;

/* 18. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los
fabricantes que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del
fabricante, con el identificador del fabricante es suficiente */
SELECT MAX(producto.precio) AS 'MAX', MIN(producto.precio) AS 'MIN', AVG(producto.precio) 'AVG', COUNT(producto.id_fabricante) AS 'Q PROD', fabricante.id AS 'ID', fabricante.nombre AS 'FABRICANTE'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.id ,fabricante.nombre
HAVING AVG > 200
;

/* 19. Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y
el número total de productos de los fabricantes que tienen un precio medio superior a 200€. Es
necesario mostrar el nombre del fabricante. */
SELECT fabricante.nombre AS 'FABRICANTE', MAX(producto.precio) AS 'MAX', MIN(producto.precio) AS 'MIN', AVG(producto.precio) AS 'AVG', COUNT(producto.id_fabricante) AS 'Q'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.nombre
HAVING AVG > 200
;

/* 20. Calcula el número de productos que tienen un precio mayor o igual a 180€ */
SELECT count(*) AS 'Q'
FROM producto
WHERE precio >= 180
;

/* 21. Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€ */
SELECT COUNT(producto.id_fabricante) AS 'Q', fabricante.nombre
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
WHERE producto.precio >= 180
GROUP BY fabricante.nombre
;

/* 22. Lista el precio medio los productos de cada fabricante, mostrando solamente el identificador del
fabricante. */
SELECT fabricante.id, avg(producto.precio) AS 'AVG'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.id
;

/* 23. Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del
fabricante */
SELECT fabricante.nombre AS 'FABRICANTE', avg(producto.precio) AS 'AVG'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.nombre
;

/* 24. Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€ */
SELECT fabricante.nombre AS 'FABRICANTE'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.nombre
HAVING AVG(producto.precio) >=150
;

/* 25. Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos */
SELECT fabricante.nombre AS 'FABRICANTE'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
GROUP BY fabricante.nombre
HAVING COUNT(producto.id_fabricante)>2
;

/* 26. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada
uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes
que no tienen productos que cumplan la condición. */
SELECT fabricante.nombre AS 'FABRICANTE', COUNT(producto.id_fabricante) AS 'Q'
FROM producto
INNER JOIN fabricante
ON producto.id_fabricante = fabricante.id
WHERE producto.precio >= 220
GROUP BY fabricante.nombre
;
