module Library where
import PdePreludat
import Text.Show.Functions

-- Primera parte --------------------------------------------------------------------------------------------------------------------------------------------

{-Los chocolates que vamos a hacer pueden tener una combinación de ingredientes que resultará en los distintos sabores que vamos a 
ofrecer a nuestros clientes. Cada ingrediente aporta un determinado nivel de calorías. Por ejemplo agregar naranja aporta 20 calorías.
La gente de marketing de la empresa nos sugirió que los chocolates tengan un nombre fancy para la venta. 
Por ejemplo "chocolate Rap a Niu" o "Roca blanca con almendras".-}

-- Punto 1 (3 puntos) ----------------------------------------------------------------------------------------------------------------------------------------

-- Modelar el chocolate e implementar el cálculo de su precio en base a la descripción anterior.

data Chocolate = UnChocolate {
    nombre :: String,
    peso :: Number,
    ingredientes :: [Ingrediente],
    cantidadDeCacao :: Number,
    gramosDeAzucar :: Number
} deriving (Show)

type Ingrediente = (String, Number)
nombreIngrediente = fst
caloriasIngrediente = snd


chocolatePrueba = UnChocolate {
    nombre = "Chocolate de prueba",
    peso = 50,
    ingredientes = [("papalla", 850)],
    cantidadDeCacao = 65,
    gramosDeAzucar = 20
}
chocolatePrueba2 = UnChocolate {
    nombre = "Chocolate de prueba",
    peso = 50,
    ingredientes = [("papalla", 300)],
    cantidadDeCacao = 65,
    gramosDeAzucar = 20
}
chocolatePrueba3 = UnChocolate {
    nombre = "Chocolate de prueba",
    peso = 50,
    ingredientes = [("papalla", 300)],
    cantidadDeCacao = 65,
    gramosDeAzucar = 20
}
chocolatePrueba4 = UnChocolate {
    nombre = "Chocolate de prueba",
    peso = 50,
    ingredientes = [("papalla", 300)],
    cantidadDeCacao = 65,
    gramosDeAzucar = 20
}

-- Lo que tenemos que determinar en primer lugar es cuánto nos sale cada chocolate: 

-- los chocolates amargos 
-- (que tienen más de un 60% de cacao) se calculan como el gramaje del chocolate multiplicado por el precio premium. 
-- Por el contrario, si tiene más de 4 ingredientes, el precio es de $8 por la cantidad de ingredientes que tiene. 
-- Caso contrario, el costo es de $1,5 por gramo. 
-- El precio premium varía si es apto para diabéticos 
-- (es decir que el chocolate tiene cero gramos de azúcar) en cuyo caso es de $8 por gramo o bien es de $5 por gramo. 

precioDeUnChocolate :: Chocolate -> Number
precioDeUnChocolate chocolate  
        | cantidadDeCacao chocolate > 60 && gramosDeAzucar chocolate == 0        = peso chocolate * 8
        | cantidadDeCacao chocolate > 60 && gramosDeAzucar chocolate > 0         = peso chocolate * 5
        | length (ingredientes chocolate) > 4                                    = length (ingredientes chocolate) * 8
        | otherwise                                                              = peso chocolate * 1.5

-- Punto 2 (3 puntos) ----------------------------------------------------------------------------------------------------------------------------------------

-- Necesitamos saber

-- Cuándo un chocolate esBombonAsesino que ocurre cuando tiene algún ingrediente de más de 200 calorías.
esBombonAsesino :: Chocolate -> Bool
esBombonAsesino chocolate = any (> 200) (map caloriasIngrediente (ingredientes chocolate))

-- También queremos saber el totalCalorias para un chocolate que es la sumatoria de los aportes de cada ingrediente.
totalCalorias :: Chocolate -> Number
totalCalorias chocolate = sum (map caloriasIngrediente (ingredientes chocolate))

-- Y por último, dada una caja de chocolates, queremos tomar los chocolates aptoParaNinios 
--donde separamos 3 chocolates que no sean bombones asesinos, sin importar cuáles.

cajaDeChocolates :: [Chocolate] -> [Chocolate]
cajaDeChocolates listaChocolates = take 3 $ (filter (\chocolate -> aptoParaNinios chocolate )) listaChocolates

aptoParaNinios :: Chocolate -> Bool
aptoParaNinios chocolate = not.esBombonAsesino $ chocolate 

-- Segunda Parte ---------------------------------------------------------------------------------------------------------------------------------------------

-- ¡¡Excelente!! Ahora nos toca pensar qué procesos podemos realizar sobre el chocolate. Si bien hay fanáticos del chocolate amargo (como quien les escribe) 
--también podemos realizar modificaciones o agregados:

-- Punto 3 (3 puntos) ----------------------------------------------------------------------------------------------------------------------------------------

-- Modelar cada uno de los procesos sobre el chocolate. 
-- Tengamos en cuenta que a futuro podemos implementar nuevos procesos para generar chocolates más novedosos. 
-- Evitar la repetición de lógica y código.

type Proceso = Chocolate -> Chocolate

agregarIngrediente :: [Ingrediente] -> Chocolate -> [Ingrediente]
agregarIngrediente ingrediesnteNuevos chocolate = (++) (ingredientes chocolate) ingrediesnteNuevos

agregarAzucar :: Number -> Chocolate -> Number
agregarAzucar cantidadAzucar chocolate = gramosDeAzucar chocolate + cantidadAzucar

-- Por ejemplo el frutalizado permite agregarle como ingrediente una cierta cantidad de gramos de una fruta. 
-- Toda fruta tiene dos calorías por cada gramo.
-- El peso de la fruta no afecta al gramaje del chocolate.

frutalizado :: String -> Number -> Proceso
frutalizado nombreFruta gramosDeFruta chocolate = chocolate {
    ingredientes = agregarIngrediente [(nombreFruta, 2 * gramosDeFruta)] chocolate
}

--Un clásico es el dulceDeLeche que agrega dicho ingrediente el cual siempre aporta 220 calorías. Además al nombre del chocolate le agrega al final la palabra 
--"tentación": Por ejemplo el "Chocolate con almendras" pasa a ser "Chocolate con almendras tentación".

agregarDulceDeLeche :: Proceso
agregarDulceDeLeche chocolate = chocolate {
    ingredientes = agregarIngrediente [("Dulce de leche", 220)] chocolate,
    nombre = (++) (nombre chocolate) (" tentacion")
}

--Otro famoso proceso es la celiaCrucera que dada una cierta cantidad de gramos de azúcar, aumenta el nivel en el chocolate. Este peso tampoco afecta al 
--gramaje del chocolate.

type GramosDeAzucar = Number

celiaCrucera :: GramosDeAzucar -> Proceso
celiaCrucera gramosDeAzucarNuevos chocolate = chocolate {
    gramosDeAzucar = agregarAzucar gramosDeAzucarNuevos chocolate
}
 
--Por último contamos con la embriagadora que para un determinado grado de alcohol aporta como ingrediente Licor con una caloría por cada grado de alcohol, 
--hasta un máximo de 30 calorías. Es decir que si agregamos una bebida con 40 grados, son 30 calorías de licor. En cambio si ponemos una bebida con 20 grados, 
--son 20 calorías aportadas. Además agrega 100 gramos de azúcar.

embriagadora :: Number -> Proceso
embriagadora gradoAlcohol chocolate = chocolate {
    ingredientes = agregarIngrediente [("licor", min gradoAlcohol 30)] chocolate,
    gramosDeAzucar = agregarAzucar 100 chocolate 
} 

-- Punto 4 (1 punto) ---------------------------------------------------------------------------------------------------------------------------------------

-- Dar un ejemplo de una receta que conste de los siguientes procesos: agregar 10 gramos de naranja, dulce de leche y un licor de 32 grados.

recetaPoderosa :: [Proceso] -> Chocolate -> Chocolate
recetaPoderosa listaProcesosEjemplo chocolate = foldr ($) chocolate listaProcesosEjemplo

listaProcesosEjemplo = [frutalizado "Naranja" 10, agregarDulceDeLeche, embriagadora 32]

-- Punto 5 (2 puntos) ---------------------------------------------------------------------------------------------------------------------------------------

-- Implementar la preparación de un chocolate que a partir de un determinado chocolate tomado como base y una serie de procesos nos permite obtener el 
-- chocolate resultante. En este punto NO se puede utilizar recursividad.

preparacionDeUnChocolate :: Chocolate -> [Proceso] -> Chocolate
preparacionDeUnChocolate chocolate listaProcesos = foldr ($) chocolate listaProcesos


-- ¡Última parte! -------------------------------------------------------------------------------------------------------------------------------------------

-- Por otra parte tenemos a las personas, de las cuales se sabe que tienen un límite de saturación para las calorías que consumen y además tienen un 
-- criterio para rechazar ciertos ingredientes. 
-- Por ejemplo a Juan no le gusta la naranja y a Cecilia no le gusta los ingredientes pesados (de más de 200 calorías). 
-- Cada persona podría tener un criterio distinto.

data Persona = UnaPersona {
    limiteDeSaturacion :: Number,
    criterioDeRechazo :: CriterioDeRechazo
}

type CriterioDeRechazo = (Chocolate -> Bool)
type IngredienteARechazar = String

rechazariaChocolate :: Persona -> CriterioDeRechazo 
rechazariaChocolate persona chocolate = criterioDeRechazo persona chocolate


juan :: IngredienteARechazar -> Persona
juan ingredienteARechazar = UnaPersona {
    limiteDeSaturacion = 800,
    criterioDeRechazo = criterioDeRechazoJuan ingredienteARechazar
}

criterioDeRechazoJuan :: IngredienteARechazar -> CriterioDeRechazo
criterioDeRechazoJuan ingredienteARechazar chocolate = elem ("naranja") (map nombreIngrediente (ingredientes chocolate))


{-

Cecilia = UnaPersona {
    limiteDeSaturacion = 800,
    criterioDeRechazo = criterioDeRechazoCecilia
}

criterioDeRechazoCecilia :: CriterioDeRechazo
criterioDeRechazoCecilia chocolate = any (> 200) (map caloriasIngrediente (ingredientes chocolate))
-}

--Punto 6 (2 Puntos) ---------------------------------------------------------------------------------------------------------------------------------------

-- Resolver la función hastaAcaLlegue que dada una persona y una caja de chocolates, devuelve los chocolates que puede comer. 
-- La persona comerá todos los chocolates que pueda hasta que llegue al nivel de saturación de calorías. 
-- Al mismo tiempo debe descartar los chocolates que tengan un ingrediente que rechace por el criterio de la persona.

type CajaDeChocolates = [Chocolate]

hastaAcaLlegue :: Persona -> CajaDeChocolates -> [Chocolate]
hastaAcaLlegue persona (chocolate1:chocolate2:chocolates)
     | personaSaturada persona = []
     | (not.personaSaturada) persona && rechazariaChocolate persona chocolate1 = hastaAcaLlegue persona (chocolate2:chocolates) 
     | (not.personaSaturada) persona && not(rechazariaChocolate persona chocolate1) = chocolate1 : hastaAcaLlegue (comerChocolate persona chocolate1) (chocolate2:chocolates)
     

comerChocolate :: Persona -> Chocolate -> Persona
comerChocolate persona chocolate | limiteDeSaturacion persona - totalCalorias chocolate > 0 = persona { limiteDeSaturacion = limiteDeSaturacion persona - totalCalorias chocolate}
                                 | limiteDeSaturacion persona - totalCalorias chocolate <= 0  = persona { limiteDeSaturacion = 0}

personaSaturada :: Persona -> Bool
personaSaturada persona = limiteDeSaturacion persona <= 0


--Es decir, si tenemos 4 chocolates de 300, 400, 150 y 50 calorías respectivamente, y Juan tiene un límite de 800 calorías, la función debe devolver los 
--tres primeros chocolates (por más que a Juan le hubiera encantado comer el último chocolate). Esto es porque cuando come el tercer chocolate suma 850 
--calorías que es más que el tope de 800 calorías.

--Si tenemos 4 chocolates, todos de 100 calorías, en el segundo chocolate hay naranja y en los otros tres no. Recordemos que a Juan no le gusta la naranja
-- y soporta 800 calorías. Si invocamos la función con Juan y estos 4 chocolates, nos debe devolver una lista con los chocolates que originalmente están en 
-- la posición 1, 3 y 4, descartando el chocolate de naranja y teniendo en cuenta que los tres bombones suman 300 calorías < 800 de tope.

--Tener en cuenta que el criterio de aceptación depende de cada persona.

--Este punto tiene que ser resuelto utilizando recursividad.

-- Punto 7 (1 Punto) ---------------------------------------------------------------------------------------------------------------------------------------

--Dada una caja de chocolates infinitos ¿es posible determinar cuáles son los chocolates aptosParaNinios y el totalCalorias? Justifique su respuesta, 
--relacionándolo con un concepto visto en la materia.

-- Seria posible calcularlos si queremos saber una determinada cantidad (ej.: solo tomar 10 chocolates), pero si no ponemos un limite
-- Haskell trataria de evaluar una lista infinita y es un proceso que no converge, por lo tanto no seria posible.

