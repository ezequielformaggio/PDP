module Library
    ( Persona(..),
    cuantoPonemosDePrepaga,
    genteCabulera,
    modificacionesLocas,
    alterarEmpleado
    ) where

import PdePreludat

type Elemento = String

data Persona = Persona {
  edad::Number,
  sueldo::Number,
  elementos::[String]
} deriving (Show, Eq)

perderElemento:: String -> Persona -> Persona
perderElemento nombreElemento persona = persona {
  elementos = filter (/=nombreElemento) $ elementos persona
}

cumplirAnios:: Persona -> Persona
cumplirAnios persona = persona { edad = 1 + edad persona }

incrementarSueldo:: Number -> Persona -> Persona
incrementarSueldo factor persona = persona { 
  sueldo = sueldo persona  * factor
}

modificacionesLocas:: [Persona -> Persona]
modificacionesLocas = [perderElemento "teclado", cumplirAnios , incrementarSueldo 1.2]

--aportes de prepaga: 11% de la suma de sueldos de las personas de mas de 26 años
cuantoPonemosDePrepaga:: [Persona] -> Number
cuantoPonemosDePrepaga listaPersonas = ((* 0.11) . sumarSueldos . mayores26) listaPersonas

mayores26 :: [Persona] -> [Persona]
mayores26 listaPersonas  = filter ((> 26) . edad) listaPersonas

sumarSueldos :: [Persona] -> Number
sumarSueldos listaPersonas = sum (map sueldo listaPersonas)

--si todos los elementos que poseen, tienen una longitud par

--dada una lista de personas, conocer el conjunto de personas cuya longitud de todos los nombres de los elementos que poseen sea par. 
--Ejemplo: si una persona tiene "mazo de cartas" y "victorinox", suman 24 => cumple la condición. Si tiene "alhaja" y "piedras", 
--suman 6 + 7 = 13 => no cumple la condición. La cantidad de cosas que posee una persona no es fija, pueden ser 0, 1, 3 ó 77 cosas.

genteCabulera:: [Persona] -> [Persona]
genteCabulera listaPersonas =  filter (even.sumarNombresDeElementos.elementos) listaPersonas

sumarNombresDeElementos :: [Elemento] -> Number
sumarNombresDeElementos listaElemento = (sum.map(\elemento -> length elemento)) listaElemento --lenght.(foldr (++) listaElemento)

-- Aplicar modificaciones locas a una persona
--alterarEmpleado que dado un empleado y una lista de modificacionesLocas las aplica en el empleado.

alterarEmpleado:: Persona -> [Persona -> Persona] -> Persona
alterarEmpleado empleado = (...)

-------------------------------------------------------------------------------------------------------------------------------------

type Int = Number

-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

{-
También necesitaremos modelar los palos de golf que pueden usarse y los obstáculos que deben enfrentar para ganar el juego.

Sabemos que cada palo genera un efecto diferente, por lo tanto elegir el palo correcto puede ser la diferencia entre ganar o 
perder el torneo.

Modelar los palos usados en el juego que a partir de una determinada habilidad generan un tiro que se compone por velocidad, 
precisión y altura.

El putter genera un tiro con velocidad igual a 10, el doble de la precisión recibida y altura 0.

La madera genera uno de velocidad igual a 100, altura igual a 5 y la mitad de la precisión.

Los hierros, que varían del 1 al 10 (número al que denominaremos n), generan un tiro de velocidad igual a la fuerza multiplicada 
por n, la precisión dividida por n y una altura de n-3 (con mínimo 0). Modelarlos de la forma más genérica posible.

Definir una constante palos que sea una lista con todos los palos que se pueden usar en el juego.
-}

type PaloDeGolf = Habilidad -> Tiro
 

-- El putter genera un tiro con velocidad igual a 10, el doble de la precisión recibida y altura 0.

putter :: PaloDeGolf
putter habilidad = UnTiro {
  velocidad = 10,
  precision = precisionJugador habilidad *2,
  altura = 0
}

-- La madera genera uno de velocidad igual a 100, altura igual a 5 y la mitad de la precisión.

data Obstaculo = UnObstaculo {

}