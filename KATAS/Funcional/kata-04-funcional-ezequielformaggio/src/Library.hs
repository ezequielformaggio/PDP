module Library
  ( ambiciosas,
    personas,
    nombre
  ) where

import Data.Char (toLower)
import PdePreludat
import Data.List (isInfixOf) 

data Persona = Persona {
  nombre :: String,
  suenios :: [String]
} deriving Show

type Gente = [Persona]
type ListaSuenios = [String]

gogo :: Persona
gogo = Persona "gogo" ["ser presidente", "manejar una autobomba", "que mi viejo reconozca mis logros"]

daenerys :: Persona
daenerys = Persona "daenerys" ["saber lo que es bueno", "gobeRnar con misericordia", "que Tigre vuelva a primera"]

personas :: Gente
personas = [
  gogo,
  Persona "berta" ["ayudar a conseguir la paz mundial", "ser feliz"],
  Persona "khal" ["ser temido", "casarme con mi alma gemela"],
  daenerys
  ]


-- Las personas ambiciosas tienen suenios ambiciosos:
ambiciosas :: Gente -> Gente
ambiciosas = filter (\persona -> tieneSueniosAmbiciosos persona) 

-- Un sueño es ambicioso si cumple con ciertos requisitos:
tieneSueniosAmbiciosos :: Persona -> Bool 
tieneSueniosAmbiciosos persona = buscaPalabraClave.convertirAMinusculas $ suenios persona

convertirAMinusculas :: ListaSuenios -> ListaSuenios
convertirAMinusculas listaSuenios = foldr ((:).map toLower) [] listaSuenios

buscaPalabraClave :: ListaSuenios -> Bool
buscaPalabraClave listaSuenios =  or (map (isInfixOf "gobernar") listaSuenios) || or (map (isInfixOf "presidente") listaSuenios)

{-
Armar la función que me devuelve el n-ésimo número de la serie de Fibonacci, que se arma
así:
 fib(1) = 1
 fib(2) = 1
 fib(n) = fib(n-1) + fib(n-2) si n > 2
Hacerlo con guardas, y también con pattern matching. 
-}

fib :: Number -> Number
fib numero 
          | numero == 1 = 1
          | numero == 2 = 1
          | numero > 2 = fib (numero - 1) + fib (numero -2)


fiv :: Number -> Number
fiv 1 = 1
fiv 2 = 2
fiv num 

suma [] = 0 -- Caso Base
suma (x:xs) = x + suma xs -- Caso Recursivo 