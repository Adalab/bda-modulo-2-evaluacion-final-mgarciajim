
-- Evaluación Final: Módulo 2 --
-- Mónica García Jiménez --

USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT 
DISTINCT(title) 
FROM film; 

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
-- Mostrar los nombres de las películas
-- Condición : Las películas deben tener una clasificación de "PG-13"

SELECT 
title
FROM film
WHERE rating = "PG-13"; 

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- Encontrar información de las películas
-- Obtener el título y la descripción
-- Contener la palabra "amazing" en su descripción

SELECT
title,
description 
FROM film
WHERE description LIKE "%amazing%"; 

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- Filtrar películas con una duración > 120
-- Obtener lostítulos de las películas 

SELECT
title
FROM film
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores.

SELECT 
first_name,
last_name
FROM actor
ORDER BY first_name ASC; 

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
-- Encontrar actores
-- Condición: Apellidos que tengan "Gibson" 

SELECT
first_name,
last_name
FROM actor
WHERE last_name = "Gibson";

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- Encontrar los nombres
-- Identificar el rango del actor_id entre 10/20

SELECT
actor_id,
first_name,
last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla `film` que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- Encontrar título de películas
-- Condicción: eliminar películas que no sean "R, PG-13"
-- Obtener resultado de películas que no cumplan con dichos requisitos 

SELECT
title
FROM film
WHERE rating NOT IN ("R", "PG-13"); 

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
-- Encontrar la "cantidad total de películas" en cada "clasificación"
-- Mostrar la clasificación

SELECT
rating AS Clasificación,
COUNT(film_id) AS num_pelis 
FROM film
GROUP BY rating; 

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- Contar el número de películas que cada cliente ha alquilado
-- Identificar elementos
-- Buscar tablas relacionadas 

SELECT
c.customer_id AS Cliente,
c.first_name AS Nombre,
c.last_name AS Apellidos,
COUNT(r.rental_id) AS Total_Pelis_Alquiladas
FROM customer AS c 
LEFT JOIN rental AS r 
ON c.customer_id = r.customer_id 
GROUP BY 
c.customer_id, 
c.first_name, 
c.last_name
ORDER BY
Total_Pelis_Alquiladas ASC; 
    
-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
-- Contar cuántas películas han sido alquiladas
-- Agrupar esos alquileres por la categoría de las películas
-- Mostrar el nombre de la categoría junto con el recuento de alquileres
-- Identificar las tablas

SELECT 
c.name AS Categoria_Nombre,
COUNT(r.rental_id) AS Total_Pelis_Alquiladas 
FROM category AS c
INNER JOIN film_category AS f 
ON c.category_id = f.category_id 
INNER JOIN inventory AS i 
ON f.film_id = i.film_id 
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id
GROUP BY c.name; 

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
-- Calcular promedio de películas (tabla film)
-- Mostrar clasificación de las películas

SELECT
AVG(length) AS Clasificación_peliculas,
rating AS Promedio_duración 
FROM film
GROUP BY rating;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- Encontrar Nombre/Apellido actores de la película "Indian Love"
-- Identificar las tablas( actor, film, film_actor(está relacionada con las otras))

SELECT
a.first_name AS Nombre,
a.last_name AS Apellido,
fi.title AS titulo_pelicula
FROM actor AS a
INNER JOIN film_actor AS fa 
ON fa.actor_id = a.actor_id 
INNER JOIN film AS fi 
ON fi.film_id = fa.film_id 
WHERE fi.title = "Indian Love"; 

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
-- Mostrar el título de las películas
-- Condición: palabra "dog" o "cat"

SELECT
title AS Título_Todas_Pelis,
description
FROM film
WHERE description LIKE "%dog%" 
OR description LIKE "%cat%"; 

-- * Nos ayuda a confirmar/saber cuántos títulos de películas disponemos *
SELECT COUNT(title) AS total_peliculas
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- 15. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
-- Encontrar el título de películas
-- Identificar el rango de fechas
-- Buscar la tabla 
 
SELECT
title AS Título_Todas_Pelis
FROM film
WHERE release_year BETWEEN 2005 AND 2010; 

-- * Realizamos una consulta para comprobar los atributos seleccionando las columnas, eligiendo las columnas que corresponden al año y al título de las películas*.
SELECT title, release_year FROM FILM;

-- 16. Encuentra el título de todas las películas que son de la misma categoría que "Family".
-- Encontrar el título de todas las películas
-- Buscar id o nombre de la categoría "Familia"
-- Relaccionar tablas (category + film)

SELECT 
f.title AS Titulo_Familia,
c.name AS Nombre
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name = 'Family'; 

-- Subconsulta --

SELECT f.title  AS Titulo_Familia
FROM film AS f 
WHERE f.film_id IN (
	SELECT fc.film_id
    FROM film_category AS fc
    INNER JOIN category AS c 
    ON fc.category_id = c.category_id
    WHERE c.name = 'Family'
);

-- 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla "film".
-- Encontrar títulos de películas
-- Películas con clasificación "R"
-- Películas con duración mayor a 2 horas.
-- Extraer los elementos claves de la tabla "film"

SELECT title AS titulo,
rating AS Películas,
length AS Duración
FROM film
WHERE rating = 'R' AND  length > 120;

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
-- Mostrar Nombre/Apellido
-- Ver tablas relacionadas

SELECT 
a.first_name AS Nombre,
a.last_name AS Apellido,
COUNT(fa.film_id) AS Total_Películas 
FROM actor AS a
INNER JOIN film_actor  AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) > 10;

-- Subconsulta --

SELECT 
Nombre,
Apellido,
Total_Películas
FROM (
	SELECT
	a.first_name AS Nombre,
	a.last_name AS Apellido,
	COUNT(fa.film_id) AS Total_Películas
	FROM actor AS a
	INNER JOIN film_actor  AS fa
	ON a.actor_id = fa.actor_id
	GROUP BY 
	a.first_name,
	a.last_name
    ) AS Nombres_Apellidos
WHERE Total_Películas > 10;

-- 19. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
-- Identificar los elementos clave
-- Encontrar actores que no estén en la tabla.
-- Identificar las Tablas

-- NOT IT --

SELECT *
FROM actor
WHERE actor_id NOT IN ( 
    SELECT actor_id 
    FROM film_actor
);

-- IS NULL --

SELECT *
FROM actor AS a
LEFT JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
-- Identificar las tablas y las relaciones entre ellas para poder encontrar categorías de películas
-- Calcular el promedio de duración superior a 120 minutos
-- Mostrar el nombre de la categoría y el promedio de duración

SELECT  
c.name AS Nombre_Categoria,
AVG(f.length) AS Promedio_Duración
FROM category AS c
INNER JOIN film_category AS fc 
ON c.category_id = fc.category_id  
INNER JOIN film AS f
ON fc.film_id = f.film_id 
GROUP BY 
c.name
HAVING AVG(f.length) > 120; 

-- Subconsulta --

SELECT *
FROM (
	SELECT
	c.name AS Nombre_Categoria,
	AVG(f.length) AS Promedio_Duración
	FROM category AS c
	INNER JOIN film_category AS fc 
	ON c.category_id = fc.category_id  
	INNER JOIN film AS f
	ON fc.film_id = f.film_id 
	GROUP BY 
	c.name
	HAVING AVG(f.length) > 120
)AS Subconsulta  
ORDER BY Promedio_Duración;

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
-- Encontrar información sobre actores
-- Saber en cuántas películas han actuado los actores
-- Mostrar los actores que han actuado en al menos 5 películas

SELECT  
a.first_name AS Nombre,
a.last_name AS Apellido,
COUNT(DISTINCT fa.film_id) AS Nº_Película
FROM actor AS a
INNER JOIN film_actor AS fa 
ON fa.actor_id = a.actor_id
GROUP BY 
a.actor_id
HAVING COUNT(DISTINCT fa.film_id) >= 5; 

-- Subconsulta con HAVING -- 

SELECT *
FROM (
    SELECT 
	a.first_name AS Nombre,
	a.last_name AS Apellido,
	COUNT(fa.film_id) AS Nº_Película
    FROM actor AS a
    INNER JOIN film_actor AS fa 
    ON fa.actor_id = a.actor_id
    GROUP BY a.actor_id
    HAVING COUNT(fa.film_id) >= 5
) AS subconsulta;

-- Subconsulta con WHERE --

SELECT *
FROM (
    SELECT 
	a.first_name AS Nombre,
	a.last_name AS Apellido,
	COUNT(fa.film_id) AS Nº_Película
    FROM actor AS a
    INNER JOIN film_actor AS fa 
    ON fa.actor_id = a.actor_id
    GROUP BY a.actor_id
) AS subconsulta
WHERE Nº_Película >= 5;

-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza un subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
-- Identificar las películas cuya duración de alquiler (rental_duration) es superior a 5 días.
-- Encontrar los ID de alquiler (rental_ids) de esas películas.
-- Utilizar los ID para seleccionar los títulos de las películas correspondientes.

-- Subconsulta con HAVING --

SELECT 
f.title AS Titulo,
f.rental_duration AS Duracion
FROM film AS f
WHERE f.film_id IN ( 
	SELECT
    i.film_id 
    FROM inventory AS i
    INNER JOIN rental AS r 
    ON r.inventory_id = i.inventory_id
    GROUP BY 
    i.film_id
	HAVING COUNT(r.rental_id) >5 
);

-- Subconsulta con WHERE --

SELECT *
FROM  (
	SELECT
    f.title AS Titulo,
	f.rental_duration AS Duracion,
	COUNT(r.rental_id) AS Rental_ID 
    FROM film AS f
    INNER JOIN inventory AS i 
    ON f.film_id = i.film_id 
    INNER JOIN rental AS r 
    ON i.inventory_id = r.inventory_id
    GROUP BY
	f.title,
    f.rental_duration 
) AS subconsulta
WHERE Rental_ID > 5; 

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
-- Encontrar Actores
-- Excluir Actores de Horror
-- Subconsulta 

SELECT
a.first_name,
a.last_name
FROM actor AS a
WHERE a.actor_id NOT IN ( 
	SELECT 
	fa.actor_id
	FROM film_actor AS fa
	INNER JOIN film_category AS fc
	ON fa.film_id = fc.film_id
	INNER JOIN category AS c
	ON fc.category_id = c.category_id
	WHERE name = "Horror"
);

-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
-- Buscar género película y encontrar aquellas que son "Comedias"
-- Calcular el promedio de duración superior a 180 minutos
-- Mostrar el resutado

SELECT 
film.title AS Título,
film.length AS Duración
FROM film 
INNER JOIN film_category  
ON film.film_id = film_category.film_id 
INNER JOIN category 
ON film_category.category_id = category.category_id 
WHERE category.name = "Comedy" 
AND film.length > 180; 

-- 25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.
-- Encontrar información sobre actores
-- Saber en cuántas películas han actuado los actores
-- Mostrar los actores que han actuado en al menos 5 películas

 
-- ** "He realizado este ejercicio, pero al recibir un poco de asistencia en un aspecto menor, decidió no subirlo.
-- Esa duda que me estaba generando la he logrado visualizar y comprender mejor. 
-- Por lo tanto, prefiero obviarlo en este momento ".**