SELECT nombre, codigoalfa2 
FROM pais 
ORDER BY nombre ASC;



SELECT c.nombre AS ciudad, c.latitud, c.longitud 
FROM ciudad c
JOIN pais p ON c.idpais = p.id
WHERE p.nombre = 'Colombia';


SELECT 
    p.nombre AS pais, 
    c.nombre AS ciudad, 
    r.nombre AS ruta, 
    t.nombre AS tipo_transporte
FROM ruta r
JOIN tipo t ON r.idtipo = t.id
JOIN ciudad c ON r.idciudad = c.id
JOIN pais p ON c.idpais = p.id;