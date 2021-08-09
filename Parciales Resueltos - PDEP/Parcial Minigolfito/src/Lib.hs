module Lib where
import Text.Show.Functions
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

-- between n m x = elem x [n .. m]
-- 
-- maximoSegun f = foldl1 (mayorSegun f)
-- 
-- mayorSegun f a b
--   | f a > f b = a
--   | otherwise = b

--Punto 1 -------------------------------------------------------------------------------------------------------------------------------
-- Modelarlos de la forma más genérica posible. 
type UnPalo = Habilidad -> Tiro

-- a)
-- El putter genera un tiro con velocidad igual a 10, el doble de la precisión recibida y altura 0.
putter :: UnPalo
putter habilidad = UnTiro {
  velocidad = 10, 
  precision = precisionJugador (*2), 
  altura = 0
  }

--La madera genera uno de velocidad igual a 100, altura igual a 5 y la mitad de la precisión.
madera :: UnPalo
madera habilidad = UnTiro {
  velocidad = 100, 
  precision = div precisionJugador 2,
  altura = 5
  }

{-Los hierros, que varían del 1 al 10 (número al que denominaremos n), generan un tiro de:
  - velocidad igual a la fuerza multiplicada por n
  - la precisión dividida por n
  - una altura de n-3 (con mínimo 0)-}
hierros :: Int -> UnPalo
hierros n habilidad = (velocidadDelTiro, (\precisionJugador -> (/n) precisionJugador), alturaDelTiro)

-- Velocidad generada con el plalo de hierro
velocidadDelTiro :: Habilidad -> Int -> Int
velocidadDelTiro habilidad n = (*n) fuerzaJugador 

-- Altura generada con el palo de hierro
alturaDelTiro :: Int -> Int
alturaDelTiro n | n <= 3 = 0
                | n > 3 = n - 3 

-- b) Definir una constante palos que sea una lista con todos los palos que se pueden usar en el juego.
palos :: UnPalo
palos = [putter, madera] ++ map hierro [1..10]

-- Definir la función golpe que dados una persona y un palo, obtiene el tiro resultante de usar ese palo con las habilidades de la persona.

golpe :: UnJugador -> UnPalo
golpe jugador palo = palo $ habilidad jugador


-- Lo que nos interesa de los distintos obstáculos es si un tiro puede superarlo, y en el caso de poder superarlo, cómo se ve afectado dicho tiro por el obstáculo. 
-- En principio necesitamos representar los siguientes obstáculos:

type Obstaculo = Tiro -> Tiro

obstaculoNoSuperado :: Tiro -> Tiro
obstaculoNoSuperado tiro = tiro {
  velocidad = 0,
  altura = 0,
  precision = 0
}

-- Un túnel con rampita sólo es superado si la precisión es mayor a 90 yendo al ras del suelo, independientemente de la velocidad del tiro. 
-- Al salir del túnel la velocidad del tiro se duplica, la precisión pasa a ser 100 y la altura 0.

tunel :: Obstaculo
tunel tiro | precision tiro > 90 && altura tiro == 0 = efectoTunel tiro
           | otherwise                               = obstaculoNoSuperado tiro

efectoTunel :: Tiro -> Tiro
efectoTunel tiro = tiro {
  velocidad = velocidad tiro *2,
  precision = 100,
  altura = 0
}

-- Una laguna es superada si la velocidad del tiro es mayor a 80 y tiene una altura de entre 1 y 5 metros. 
-- Luego de superar una laguna el tiro llega con la misma velocidad y precisión, pero una altura equivalente a la altura original dividida por el largo de la laguna.

laguna :: Number -> Obstaculo
tunel largoLaguna tiro | velocidad tiro > 80 && altura tiro > 1 && altura tiro < 5 = efectoLaguna largoLaguna tiro
                       | otherwise                                                 = obstaculoNoSuperado tiro

efectoLaguna :: Number -> Obstaculo
efectoTunel tiro largoLaguna = tiro {
  altura = altura tiro / largoLaguna
}

Un hoyo se supera si la velocidad del tiro está entre 5 y 20 m/s yendo al ras del suelo con una precisión mayor a 95. Al superar el hoyo, el tiro se detiene, 
quedando con todos sus componentes en 0.


hoyo :: Obstaculo
hoyo tiro | precision tiro > 95 && altura tiro == 0 && velocidad tiro > 5 && velocidad tiro < 20 = efectoHoyo tiro
          | otherwise                                                                            = obstaculoNoSuperado tiro

efectoHoyo :: Obstaculo
efectoHoyo tiro = tiro {
  velocidad = 0,
  precision = 0,
  altura = 0
}

superaObstaculo :: Tiro -> Obstaculo
superaObstaculo tiro obstaculo = obstaculo tiro