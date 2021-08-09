module Library where
import PdePreludat

-- Temas a evaluar
-- Composición
-- Aplicación parcial
-- Orden superior
-- Modelado de información
-- Efecto colateral
-- Recursividad
-- Evaluación diferida
-- Sistema de tipos

-- Punto 1 --------------------------------------------------------------------------------------------------------------------------------------------------

-- (2 puntos) Modelar Personaje, Guantelete y Universo como tipos de dato e implementar el chasquido de un universo.


-- Primera parte 

-- Los enanos de Nidavellir nos han pedido 
-- Modelar los guanteletes:
-- Un guantelete está hecho de un material (“hierro”, “uru”, etc.) 
-- y sabemos las gemas que posee.

data Guante = UnGuante {
    material :: String,
    gemas :: [Gema]
}

-- También se sabe de los personajes que tienen:
-- una edad,
-- una energía,
-- una serie de habilidades(como por ejemplo “usar espada”, “controlar la mente”, etc)
-- su nombre 
-- en qué planeta viven

data Personaje = UnPersonaje {
    edad :: Number,
    energia :: Number,
    habilidades :: [String],
    nombre :: String,
    planeta :: String
}

-- definimos algunos personajes

ironMan = UnPersonaje {
    edad = 46,
    energia = 76,
    habilidades = ["volar", "tirar rayos", "conocimientos cientificos"],
    nombre = "Iron Man",
    planeta = "Tierra"
} 

drStrange = UnPersonaje {
    edad = 62,
    energia = 83,
    habilidades = ["levitar", "poderes mentales", "predecir el futuro"],
    nombre = "Dr. Strange",
    planeta = "Tierra"
} 

groot = UnPersonaje {
    edad = 18,
    energia = 35,
    habilidades = ["regenerarse", "cambiar de tamaño"],
    nombre = "Groot",
    planeta = "Arbol"
} 

wolverine = UnPersonaje {
    edad = 43,
    energia = 68,
    habilidades = ["fuerza", "resistencia", "cuchillas"],
    nombre = "Wolverine",
    planeta = "Tierra"
} 

viudaNegra = UnPersonaje {
    edad = 27,
    energia = 42,
    habilidades = ["destreza", "valentia", "inteligencia"],
    nombre = "Viuda Negra",
    planeta = "Tierra"
} 

universo = [ironMan, drStrange, groot, wolverine, viudaNegra]

-- Los fabricantes determinaron que cuando un guantelete está completo -es decir, tiene las 6 gemas posibles- y su material es “uru”, se tiene 
-- la posibilidad de chasquear un universo que contiene a todos sus habitantes y reducir a la mitad la cantidad de dichos personajes. 

type Universo = [Personaje]

chasquearUniverso :: Guante -> Universo -> Universo
chasquearUniverso guante universo | guanteCompleto guante = reducirUniverso universo
                                  | otherwise = universo

guanteCompleto :: Guante -> Bool
guanteCompleto guante = (length (gemas guante) == 6) && (material guante == "uru") 

reducirUniverso :: Universo -> Universo -- reduce a la mitad la lista de personajes
reducirUniverso = take (div (length universo) 2)

-- Por ejemplo si tenemos un universo en el cual existen ironMan, drStrange, groot y wolverine, solo quedan los dos primeros que son ironMan y drStrange. 
-- Si además de los 4 personajes estuviera viudaNegra, quedarían también ironMan y drStrange porque se considera la división entera.


-- Punto 2 ----------------------------------------------------------------------------------------------------------------------------------------------------

-- (3 puntos) Resolver utilizando únicamente orden superior.

-- Saber si un universo es apto para péndex, que ocurre si alguno de los personajes que lo integran tienen menos de 45 años.

aptoParaPendex :: Universo -> Bool
aptoParaPendex universo |(length.filtrarPersonajesEdad) universo > 0 = True
                        |otherwise = False

-- usar any

filtrarPersonajesEdad :: Universo -> Universo
filtrarPersonajesEdad universo = filter (\personaje -> edad personaje < 45) universo

-- Saber la energía total de un universo que es la sumatoria de todas las energías de sus integrantes que tienen más de una habilidad.

energiaTotalUniverso :: Universo -> Number
energiaTotalUniverso universo = (sumarEnergias.filtrarPersonajesHabilidad) universo

filtrarPersonajesHabilidad :: Universo -> Universo
filtrarPersonajesHabilidad universo = filter (\personaje -> (length (habilidades personaje)) > 1 ) universo

sumarEnergias :: Universo -> Number
sumarEnergias universo = sum (map energia universo) 

-- Segunda parte

-- A su vez, aunque el guantelete no se encuentre completo con las 6 gemas, el poseedor puede utilizar el poder del mismo contra un enemigo, es decir que puede 
-- aplicar el poder de cada gema sobre el enemigo. Las gemas del infinito fueron originalmente parte de la entidad primordial llamada Némesis, 
-- un ser todopoderoso del universo anterior quién prefirió terminar su existencia en lugar de vivir como la única conciencia en el universo. 
-- Al morir, dio paso al universo actual, y el núcleo de su ser reencarnó en las seis gemas: 

-- Punto 3 ---------------------------------------------------------------------------------------------------------------------------------------------------

-- (3 puntos) Implementar las gemas del infinito, evitando lógica duplicada.

type Gema = Personaje -> Personaje
type Energia = Number

-- La mente: que tiene la habilidad de debilitar la energía de un usuario en un valor dado.

laMente :: Number -> Gema
laMente numero personaje = personaje {
    energia = quitarEnergia (energia personaje) numero
}

-- Funcion generica para quitar energia

quitarEnergia :: Energia -> Number -> Number
quitarEnergia energia numero = energia - numero

-- El alma: puede controlar el alma de nuestro oponente permitiéndole eliminar una habilidad en particular si es que la posee. 
-- Además le quita 10 puntos de energía.

type HabilidadParaQuitar = String
type Habilidades = [String]

elAlma ::  HabilidadParaQuitar -> Gema
elAlma habilidadParaQuitar personaje = personaje {
    energia = quitarEnergia (energia personaje) 10,
    habilidades = filter (/= habilidadParaQuitar) (habilidades personaje)
}

-- filter (/= algo) lista
-- devuelve la lista sin ese algo

-- El espacio: que permite transportar al rival al planeta x (el que usted decida) y resta 20 puntos de energía.

type Planeta = String
 
elEspacio :: Planeta -> Gema
elEspacio planetaATransportar personaje = personaje {
    energia = quitarEnergia (energia personaje) 20,
    planeta = planetaATransportar
 }

-- El poder: deja sin energía al rival y si tiene 2 habilidades o menos se las quita (en caso contrario no le saca ninguna habilidad).

elPoder :: Gema
elPoder personaje = personaje {
    energia = 0,
    habilidades = quitarHabilidades (habilidades personaje)
}

quitarHabilidades :: Habilidades -> Habilidades
quitarHabilidades listaHabilidades | length listaHabilidades <= 2 = []
                                   |otherwise = listaHabilidades

-- El tiempo: que reduce a la mitad la edad de su oponente pero como no está permitido pelear con menores, no puede dejar la edad del oponente 
-- con menos de 18 años. Considerar la mitad entera, por ej: si el oponente tiene 50 años, le quedarán 25. Si tiene 45, le quedarán 22 (por división entera). 
-- Si tiene 30 años, le deben quedar 18 en lugar de 15. También resta 50 puntos de energía.

type Edad = Number

elTiempo :: Gema
elTiempo personaje = personaje {
    energia = quitarEnergia (energia personaje) 50,
    edad = reducirEdad (edad personaje)
}

reducirEdad :: Edad -> Edad
reducirEdad edad = min 18 (div edad 2)

-- La gema loca: que permite manipular el poder de una gema y la ejecuta 2 veces contra un rival.

laGemaLoca :: Gema -> Gema
laGemaLoca gema personaje= (gema.gema) personaje


-- Punto 4 ---------------------------------------------------------------------------------------------------------------------------------------------------

{-(1 punto) Dar un ejemplo de un guantelete de goma con las gemas tiempo , alma
que quita la habilidad de “usar Mjolnir” y la gema loca que manipula el poder del alma
tratando de eliminar la “programación en Haskell”.-}

guanteleteDeEjemplo = UnGuante {
    material = "goma",
    gemas = [elTiempo, elAlma "usar Mjolnir", laGemaLoca $ elAlma "programación en Haskell"]
}

-- Punto 5 ---------------------------------------------------------------------------------------------------------------------------------------------------

{-(2 puntos). No se puede utilizar recursividad. Generar la función utilizar que
dado una lista de gemas y un enemigo ejecuta el poder de cada una de las gemas que lo
componen contra el personaje dado. Indicar cómo se produce el “efecto de lado” sobre la
víctima.-}

utilizar :: [Gema] -> Personaje -> Personaje
utilizar listaGemas enemigo = foldr ($) enemigo listaGemas

-- En Haskell no hay un efecto de lado, el personaje se ve afectado por la funcion, que devuelve unNuevo personaje con propiedades diferentes

-- Punto 6 ---------------------------------------------------------------------------------------------------------------------------------------------------

{-(2 puntos). Resolver utilizando recursividad . Definir la función
gemaMasPoderosa que dado un guantelete y una persona obtiene la gema del infinito que
produce la pérdida más grande de energía sobre la víctima.-}

gemaMasPoderosa :: Guante -> Personaje -> Gema
gemaMasPoderosa guante personaje = encontrarGemaDelInfinito (gemas guante) personaje


encontrarGemaDelInfinito :: [Gema] -> Personaje -> Gema
encontrarGemaDelInfinito [gema] _ = gema
encontrarGemaDelInfinito (gema1:gema2:gemas) personaje| (energia.gema1) personaje > (energia.gema2) personaje = encontrarGemaDelInfinito (gema2:gemas) personaje
                                                      | otherwise = encontrarGemaDelInfinito (gema1:gemas) personaje                                         

-- Punto 7 ---------------------------------------------------------------------------------------------------------------------------------------------------

-- (1 punto) Dada la función generadora de gemas y un guantelete de locos:

infinitasGemas :: Gema -> [ Gema ]
infinitasGemas gema = gema : ( infinitasGemas gema)

guanteleteDeLocos :: Guante
guanteleteDeLocos = UnGuante "vesconite" ( infinitasGemas elTiempo )

-- Y la función
usoLasTresPrimerasGemas :: Guante -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = ( utilizar . take 3 . gemas) guantelete

{-Justifique si se puede ejecutar, relacionándolo con conceptos vistos en la cursada:

● gemaMasPoderosa punisher guanteleteDeLocos

Respuesta:
No, no podria ejecutarse ya que se trata de una lista infinita, y Haskell intentaria evaluarla en su totalidad, 
comparando todas sus gemas, por lo que la funcion no converge y se produciria un error.

● usoLasTresPrimerasGemas guanteleteDeLocos punisher

Respuesta:
Si, en este caso es posible evaluar 3 gemas tomadas de la lista infinita (gracias al Take 3) por lo cual una vez
evaluadas estas 3 gemas, no es necesario seguir evaluando y el programa se detiene, converge.

2 utilizar es la función pedida en el punto 5
3 es la función del punto 4
4 puede reemplazar punisher por cualquier personaje que haya definido en el punto 1-}