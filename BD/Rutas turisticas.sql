-- Insertar rutas para todas las ciudades
INSERT INTO ruta (nombre, descripcion, idciudad, idtipo)
SELECT v.RutaNombre, v.Descripcion, c.id, t.id
FROM (
    VALUES
        -- París (ya tiene Crucero Histórico por el Sena)
        ('Montmartre y Sacré-Cœur',     'Recorrido por el barrio bohemio y artístico de París.',                          'París',           'Terrestre'),

        -- Madrid (ya tiene Madrid de los Austrias)
        ('Ruta del Retiro',              'Paseo por el gran parque central de Madrid.',                                    'Madrid',          'Terrestre'),

        -- Barcelona
        ('Las Ramblas y el Gótico',      'Recorrido por la icónica avenida y el barrio gótico de Barcelona.',              'Barcelona',       'Terrestre'),
        ('Ruta Modernista Gaudí',        'Visita a las obras más representativas del arquitecto Antoni Gaudí.',            'Barcelona',       'Terrestre'),

        -- Nueva York
        ('Manhattan a Pie',              'Recorrido por los puntos más emblemáticos del corazón de Nueva York.',           'Nueva York',      'Terrestre'),
        ('Crucero por el Hudson',        'Navegación por el río Hudson con vistas al skyline de Manhattan.',               'Nueva York',      'Fluvial'),

        -- Roma
        ('Roma Antigua',                 'Ruta por el Coliseo, el Foro Romano y la Roma imperial.',                        'Roma',            'Terrestre'),
        ('Vaticano y Trastevere',        'Visita al Vaticano y paseo por el pintoresco barrio de Trastevere.',             'Roma',            'Terrestre'),

        -- Venecia
        ('Gran Canal en Vaporetto',      'Recorrido en barco por el Gran Canal, la arteria principal de Venecia.',         'Venecia',         'Fluvial'),
        ('Venecia a Pie',                'Paseo por los callejones y plazas más encantadoras de Venecia.',                 'Venecia',         'Terrestre'),

        -- Ciudad de México
        ('Centro Histórico CDMX',        'Ruta por el Zócalo, la Catedral y el Palacio Nacional.',                        'Ciudad de México', 'Terrestre'),
        ('Xochimilco en Trajinera',      'Paseo en trajinera por los canales declarados Patrimonio de la Humanidad.',      'Ciudad de México', 'Fluvial'),

        -- Cancún
        ('Zona Hotelera Cancún',         'Recorrido por la famosa franja turística frente al Mar Caribe.',                 'Cancún',          'Terrestre'),

        -- Tokio
        ('Shibuya y Harajuku',           'Ruta por los barrios más modernos y culturales de Tokio.',                       'Tokio',           'Terrestre'),
        ('Crucero por el río Sumida',    'Navegación por el río Sumida con vistas a templos y rascacielos.',               'Tokio',           'Fluvial'),

        -- Kioto
        ('Templos y Geishas de Kioto',   'Recorrido por Fushimi Inari, Gion y los templos más icónicos de Kioto.',        'Kioto',           'Terrestre'),

        -- Bogotá
        ('La Candelaria',                'Ruta por el centro histórico y cultural de Bogotá.',                             'Bogotá',          'Terrestre'),

        -- Medellín
        ('El Poblado y Laureles',        'Recorrido por los barrios más modernos y vibrantes de Medellín.',                'Medellín',        'Terrestre'),

        -- Cusco
        ('Cusco Colonial e Inca',        'Ruta por la Plaza de Armas, el Qorikancha y los barrios incas de Cusco.',        'Cusco',           'Terrestre'),

        -- El Cairo
        ('Pirámides de Guiza',           'Ruta al complejo de pirámides más famoso del mundo.',                            'El Cairo',        'Terrestre'),
        ('Crucero por el Nilo',          'Navegación por el río Nilo con vistas a templos y paisajes del antiguo Egipto.', 'El Cairo',        'Fluvial')

) AS v(RutaNombre, Descripcion, CiudadNombre, TipoNombre)
JOIN ciudad c ON c.nombre = v.CiudadNombre
JOIN tipo t ON t.nombre = v.TipoNombre
ON CONFLICT (idciudad, nombre) DO NOTHING;


-- Insertar paradas para todas las rutas nuevas
INSERT INTO parada (nombre, descripcion, latitud, longitud, tiempo, orden, idruta)
SELECT v.ParadaNombre, v.Descripcion, v.Latitud, v.Longitud, v.Tiempo, v.Orden, r.id
FROM (
    VALUES
        -- Montmartre y Sacré-Cœur (París)
        ('Plaza del Tertre',            'Centro artístico del barrio, lleno de pintores y galerías.',   48.8863,  2.3389, 30, 1, 'Montmartre y Sacré-Cœur'),
        ('Basílica del Sacré-Cœur',     'Imponente basílica blanca con vistas panorámicas de París.',   48.8867,  2.3431, 25, 2, 'Montmartre y Sacré-Cœur'),
        ('Moulin Rouge',                'El famoso cabaret parisino en las faldas de Montmartre.',       48.8842,  2.3323, 20, 3, 'Montmartre y Sacré-Cœur'),

        -- Ruta del Retiro (Madrid)
        ('Puerta de Alcalá',            'Monumental arco neoclásico a la entrada del parque.',           40.4194, -3.6883, 15, 1, 'Ruta del Retiro'),
        ('Estanque del Retiro',         'Lago artificial donde se puede pasear en barca.',               40.4153, -3.6845, 30, 2, 'Ruta del Retiro'),
        ('Palacio de Cristal',          'Hermosa estructura de hierro y vidrio dentro del parque.',      40.4137, -3.6824, 20, 3, 'Ruta del Retiro'),

        -- Las Ramblas y el Gótico (Barcelona)
        ('Fuente de Canaletas',         'Punto de inicio tradicional del paseo por Las Ramblas.',        41.3817,  2.1734, 10, 1, 'Las Ramblas y el Gótico'),
        ('Mercado de La Boqueria',      'Colorido mercado cubierto con productos frescos y tapas.',      41.3816,  2.1719, 40, 2, 'Las Ramblas y el Gótico'),
        ('Catedral de Barcelona',       'Catedral gótica del siglo XIII en el corazón del barrio.',      41.3836,  2.1762, 30, 3, 'Las Ramblas y el Gótico'),

        -- Ruta Modernista Gaudí (Barcelona)
        ('Sagrada Família',             'La obra maestra inacabada de Gaudí, símbolo de Barcelona.',     41.4036,  2.1744, 60, 1, 'Ruta Modernista Gaudí'),
        ('Park Güell',                  'Parque con mosaicos y terrazas diseñadas por Gaudí.',           41.4145,  2.1527, 45, 2, 'Ruta Modernista Gaudí'),
        ('Casa Batlló',                 'Edificio modernista con fachada de colores en el Paseo de Gracia.', 41.3916, 2.1650, 30, 3, 'Ruta Modernista Gaudí'),

        -- Manhattan a Pie (Nueva York)
        ('Times Square',                'El cruce más famoso del mundo, lleno de luces y pantallas.',    40.7580, -73.9855, 20, 1, 'Manhattan a Pie'),
        ('Central Park',                'El gran pulmón verde de Manhattan.',                            40.7851, -73.9683, 60, 2, 'Manhattan a Pie'),
        ('Empire State Building',       'Rascacielos icónico con vistas de 360 grados a la ciudad.',    40.7484, -73.9857, 40, 3, 'Manhattan a Pie'),

        -- Crucero por el Hudson (Nueva York)
        ('Muelle 17',                   'Punto de embarque en el sur de Manhattan.',                     40.7063, -74.0041, 10, 1, 'Crucero por el Hudson'),
        ('Estatua de la Libertad',      'Vista desde el agua de la famosa estatua en la bahía.',         40.6892, -74.0445, 30, 2, 'Crucero por el Hudson'),
        ('Puente de Brooklyn',          'Vista panorámica del puente más emblemático de Nueva York.',    40.7061, -73.9969, 20, 3, 'Crucero por el Hudson'),

        -- Roma Antigua (Roma)
        ('Coliseo Romano',              'El anfiteatro más grande del mundo antiguo.',                    41.8902,  12.4922, 60, 1, 'Roma Antigua'),
        ('Foro Romano',                 'Corazón político y social de la antigua Roma.',                  41.8925,  12.4853, 45, 2, 'Roma Antigua'),
        ('Palatino',                    'La colina más antigua de Roma con ruinas imperiales.',           41.8892,  12.4875, 30, 3, 'Roma Antigua'),

        -- Vaticano y Trastevere (Roma)
        ('Plaza de San Pedro',          'Inmensa plaza rodeada de columnas frente a la Basílica.',        41.9022,  12.4568, 30, 1, 'Vaticano y Trastevere'),
        ('Museos Vaticanos',            'Hogar de la Capilla Sixtina y miles de obras de arte.',          41.9065,  12.4536, 90, 2, 'Vaticano y Trastevere'),
        ('Barrio de Trastevere',        'Encantador barrio medieval con callejones y restaurantes.',      41.8897,  12.4697, 45, 3, 'Vaticano y Trastevere'),

        -- Gran Canal en Vaporetto (Venecia)
        ('Estación Santa Lucía',        'Punto de partida del recorrido por el Gran Canal.',              45.4414,  12.3196, 10, 1, 'Gran Canal en Vaporetto'),
        ('Puente de Rialto',            'El puente más antiguo y famoso sobre el Gran Canal.',            45.4380,  12.3359, 20, 2, 'Gran Canal en Vaporetto'),
        ('Plaza de San Marcos',         'La plaza principal de Venecia con la famosa basílica.',          45.4341,  12.3388, 40, 3, 'Gran Canal en Vaporetto'),

        -- Venecia a Pie (Venecia)
        ('Basílica de San Marcos',      'Joya del arte bizantino en el corazón de Venecia.',              45.4345,  12.3397, 45, 1, 'Venecia a Pie'),
        ('Palacio Ducal',               'Antiguo centro del poder de la República de Venecia.',           45.4337,  12.3405, 40, 2, 'Venecia a Pie'),
        ('Puente de los Suspiros',      'Famoso puente que conecta el palacio con las prisiones.',        45.4338,  12.3412, 15, 3, 'Venecia a Pie'),

        -- Centro Histórico CDMX (Ciudad de México)
        ('El Zócalo',                   'La plaza central más grande de América Latina.',                 19.4326, -99.1332, 20, 1, 'Centro Histórico CDMX'),
        ('Catedral Metropolitana',      'La catedral más grande de América construida sobre el templo azteca.', 19.4352, -99.1335, 40, 2, 'Centro Histórico CDMX'),
        ('Palacio de Bellas Artes',     'El recinto cultural más importante de México.',                  19.4352, -99.1413, 30, 3, 'Centro Histórico CDMX'),

        -- Xochimilco en Trajinera (Ciudad de México)
        ('Embarcadero Nuevo Nativitas',  'Principal embarcadero para abordar las trajineras.',            19.2634, -99.0982, 15, 1, 'Xochimilco en Trajinera'),
        ('Isla de las Muñecas',         'Enigmática isla decorada con muñecas colgantes.',                19.2567, -99.0952, 25, 2, 'Xochimilco en Trajinera'),
        ('Chinampas de Xochimilco',     'Jardines flotantes prehispánicos Patrimonio de la Humanidad.',   19.2698, -99.1021, 30, 3, 'Xochimilco en Trajinera'),

        -- Zona Hotelera Cancún (Cancún)
        ('Playa Delfines',              'La playa más emblemática y menos comercial de Cancún.',          21.0566, -86.7823, 30, 1, 'Zona Hotelera Cancún'),
        ('El Rey Ruinas Mayas',         'Zona arqueológica maya dentro de la zona hotelera.',             21.0892, -86.7721, 40, 2, 'Zona Hotelera Cancún'),
        ('Laguna Nichupté',             'Laguna de aguas tranquilas paralela a la zona hotelera.',        21.1167, -86.8167, 20, 3, 'Zona Hotelera Cancún'),

        -- Shibuya y Harajuku (Tokio)
        ('Cruce de Shibuya',            'El cruce peatonal más concurrido del mundo.',                    35.6595, 139.7004, 20, 1, 'Shibuya y Harajuku'),
        ('Takeshita Street Harajuku',   'Calle icónica de la moda alternativa y juvenil de Tokio.',       35.6715, 139.7028, 30, 2, 'Shibuya y Harajuku'),
        ('Santuario Meiji',             'Santuario sintoísta rodeado de un frondoso bosque.',             35.6763, 139.6993, 40, 3, 'Shibuya y Harajuku'),

        -- Crucero por el río Sumida (Tokio)
        ('Muelle de Asakusa',           'Punto de partida junto al famoso templo Senso-ji.',              35.7148, 139.7967, 15, 1, 'Crucero por el río Sumida'),
        ('Puente Kiyosu',               'Uno de los puentes más elegantes sobre el Sumida.',              35.6882, 139.7954, 20, 2, 'Crucero por el río Sumida'),
        ('Muelle de Odaiba',            'Llegada a la isla artificial con vistas al Monte Fuji.',         35.6263, 139.7756, 30, 3, 'Crucero por el río Sumida'),

        -- Templos y Geishas de Kioto (Kioto)
        ('Fushimi Inari',               'Miles de torii naranjas forman un túnel hasta la cima del monte.', 34.9671, 135.7727, 60, 1, 'Templos y Geishas de Kioto'),
        ('Barrio de Gion',              'El barrio de las geishas con casas de té tradicionales.',        35.0037, 135.7752, 40, 2, 'Templos y Geishas de Kioto'),
        ('Kinkaku-ji Pabellón de Oro',  'Templo zen con fachada cubierta de pan de oro junto a un lago.', 35.0394, 135.7292, 35, 3, 'Templos y Geishas de Kioto'),

        -- La Candelaria (Bogotá)
        ('Plaza de Bolívar',            'El corazón histórico y político de Bogotá.',                      4.5981, -74.0758, 20, 1, 'La Candelaria'),
        ('Museo del Oro',               'El museo con la mayor colección de orfebrería precolombina.',     4.6018, -74.0725, 60, 2, 'La Candelaria'),
        ('Cerro de Monserrate',         'Cerro emblemático con santuario y vistas panorámicas de Bogotá.', 4.6058, -74.0560, 45, 3, 'La Candelaria'),

        -- El Poblado y Laureles (Medellín)
        ('Parque El Poblado',           'El parque central del barrio más moderno de Medellín.',           6.2086, -75.5659, 20, 1, 'El Poblado y Laureles'),
        ('Parque Lineal La Presidenta', 'Corredor verde que conecta El Poblado con Laureles.',             6.2173, -75.5746, 30, 2, 'El Poblado y Laureles'),
        ('Jardín Botánico',             'Espacio verde con colecciones de flora colombiana.',              6.2676, -75.5665, 40, 3, 'El Poblado y Laureles'),

        -- Cusco Colonial e Inca (Cusco)
        ('Plaza de Armas del Cusco',    'La plaza principal rodeada de arquitectura colonial e inca.',    -13.5170, -71.9785, 25, 1, 'Cusco Colonial e Inca'),
        ('Qorikancha',                  'El templo del sol más importante del Imperio Inca.',             -13.5222, -71.9762, 40, 2, 'Cusco Colonial e Inca'),
        ('Sacsayhuamán',                'Fortaleza inca con enormes bloques de piedra sobre Cusco.',      -13.5088, -71.9820, 50, 3, 'Cusco Colonial e Inca'),

        -- Pirámides de Guiza (El Cairo)
        ('Gran Pirámide de Keops',      'La única maravilla del mundo antiguo que aún existe.',           29.9792,  31.1342, 60, 1, 'Pirámides de Guiza'),
        ('Esfinge de Guiza',            'La escultura monolítica más grande del mundo.',                  29.9753,  31.1376, 30, 2, 'Pirámides de Guiza'),
        ('Pirámide de Kefrén',          'La segunda pirámide más grande con su cima de caliza original.', 29.9763,  31.1309, 25, 3, 'Pirámides de Guiza'),

        -- Crucero por el Nilo (El Cairo)
        ('Muelle de Maadi',             'Punto de embarque en el sur de El Cairo.',                       29.9602,  31.2500, 15, 1, 'Crucero por el Nilo'),
        ('Isla de Roda',                'Isla histórica con el antiguo nilómetro para medir las crecidas.',29.9989, 31.2249, 25, 2, 'Crucero por el Nilo'),
        ('Corniche del Nilo',           'Paseo ribereño con vistas a los puentes y la ciudad iluminada.', 30.0444,  31.2357, 30, 3, 'Crucero por el Nilo')

) AS v(ParadaNombre, Descripcion, Latitud, Longitud, Tiempo, Orden, RutaNombre)
JOIN ruta r ON r.nombre = v.RutaNombre
ON CONFLICT (idruta, nombre) DO NOTHING;