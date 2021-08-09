module Library where
import PdePreludat

{-Enunciado general
El fondo monetario internacional nos solicitó que modelemos su negocio, basado en realizar préstamos a países en apuros financieros. Sabemos de cada 
país el "ingreso per cápita" que es el promedio de lo que cada habitante necesita para subsistir, también conocemos la población activa en el sector 
público y la activa en el sector privado, la lista de recursos naturales (ej: "Minería", "Petróleo", "Industria pesada") y la deuda que mantiene con el FMI. -}

data Pais = Pais {
    ingresoPerCapita :: Number,
    poblacionActivaSectorPublico :: Number,
    poblacionActivaSectorPrivado :: Number,
    recursosNaturales :: [String],
    deudaConElFMI :: Number
}

-- El FMI es especialista en dar recetas. Cada receta combina una o más estrategias que se describen a continuación: 

type Receta = Pais -> Pais

-- ● prestarle n millones de dólares al país, esto provoca que el país se endeude en un 150% de lo que el FMI le presta (por los intereses)

prestamo :: Number -> Receta
prestamo numero pais = pais {
    deudaConElFMI = deudaConElFMI pais + (numero * 1.5)
}

{-● reducir x cantidad de puestos de trabajo del sector público, lo que provoca que se reduzca la cantidad de activos en el sector público y además 
que el ingreso per cápita disminuya en 20% si los puestos de trabajo son más de 100 ó 15% en caso contrario-}

recetaMaligna :: Number -> Receta
recetaMaligna numero pais = pais {
    ingresoPerCapita = reduccionPerCapita $ ingresoPerCapita pais,
    poblacionActivaSectorPublico = reducirPuestosDeTrabajo (poblacionActivaSectorPublico pais)  numero
}

reducirPuestosDeTrabajo :: Number -> Number -> Number
reducirPuestosDeTrabajo poblacionActivaSectorPublico numero = poblacionActivaSectorPublico - numero

reduccionPerCapita :: Number -> Number
reduccionPerCapita ingresopercapita | ingresopercapita > 100 = ingresopercapita - (ingresopercapita * 0.2)
                                    | otherwise              = ingresopercapita - (ingresopercapita * 0.15)

{-● darle a una empresa afín al FMI la explotación de alguno de los recursos naturales, esto disminuye 2 millones de dólares la deuda que el país mantiene
con el FMI pero también deja momentáneamente sin recurso natural a dicho país. No considerar qué pasa si el país no tiene dicho recurso.-}

cederRecursosNaturales :: Receta
cederRecursosNaturales pais = pais {
    deudaConElFMI = deudaConElFMI pais - 2000000,
    recursosNaturales = drop 1 (recursosNaturales pais)
}

{-● establecer un “blindaje”, lo que provoca prestarle a dicho país la mitad de su Producto Bruto Interno (que se calcula como el ingreso per cápita 
multiplicado por su población activa, sumando puestos públicos y privados de trabajo) y reducir 500 puestos de trabajo del sector público. 
Evitar la repetición de código.-}

blindaje :: Receta
blindaje pais = pais{
    poblacionActivaSectorPublico = reducirPuestosDeTrabajo (poblacionActivaSectorPublico pais) 500,
    deudaConElFMI = ((ingresoPerCapita pais) * (poblacionActivaSectorPrivado pais) + (poblacionActivaSectorPublico pais)) / 2
}



-- Se pide implementar en Haskell los siguientes requerimientos explicitando el tipo de cada función:

-- 1. (2 puntos)

-- a. Representar el TAD País.

-- b. Dar un ejemplo de cómo generar al país Namibia, cuyo ingreso per cápita
-- es de 4140 u$s, la población activa del sector público es de 400.000, la
-- población activa del sector privado es de 650.000, su riqueza es la minería
-- y el ecoturismo y le debe 50 (millones de u$s) al FMI.

naimbia = Pais {
    ingresoPerCapita = 4140,
    poblacionActivaSectorPublico = 400000,
    poblacionActivaSectorPrivado = 650000,
    recursosNaturales = ["mineria, ecoturismo"],
    deudaConElFMI = 50000000
}

-- 2. (4 puntos) Implementar las estrategias que forman parte de las recetas del FMI.

recetas = [prestamo 200, recetaMaligna 200, cederRecursosNaturales, blindaje]

implementarRecetas :: Pais -> [Receta] -> Pais
implementarRecetas pais recetas = foldr ($) pais recetas

-- 3. (2 puntos)

-- a. Modelar una receta que consista en prestar 200 millones, y darle a una
-- empresa X la explotación de la “Minería” de un país.

recetaPerdedora ::

-- b. Ahora queremos aplicar la receta del punto 3.a al país Namibia (creado en
-- el punto 1.b). Justificar cómo se logra el efecto colateral.

-- 4. (3 puntos) Resolver todo el punto con orden superior, composición y aplicación
-- parcial , no puede utilizar funciones auxiliares.

-- a. Dada una lista de países conocer cuáles son los que pueden zafar,
-- aquellos que tienen "Petróleo" entre sus riquezas naturales.

-- b. Dada una lista de países, saber el total de deuda que el FMI tiene a su
-- favor.

-- c. Indicar en dónde apareció cada uno de los conceptos (solo una vez) y
-- justificar qué ventaja tuvo para resolver el requerimiento.

-- 5. (2 puntos) Debe resolver este punto con recursividad : dado un país y una lista de
-- recetas, saber si la lista de recetas está ordenada de “peor” a “mejor”, en base al
-- siguiente criterio: si aplicamos una a una cada receta, el PBI del país va de menor
-- a mayor. Recordamos que el Producto Bruto Interno surge de multiplicar el
-- ingreso per cápita por la población activa (privada y pública).

-- 6. (1 punto) Si un país tiene infinitos recursos naturales, modelado con esta función
-- recursosNaturalesInfinitos :: [String]
-- recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos

-- a. ¿qué sucede evaluamos la función 4a con ese país?

-- b. ¿y con la 4b?

-- Justifique ambos puntos relacionándolos con algún concepto.

-- RECURSIVIDAD SOLO PARA EL 5b-}