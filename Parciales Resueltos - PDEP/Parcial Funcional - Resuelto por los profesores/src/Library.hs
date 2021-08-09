module Library where
import PdePreludat

type Nombre = String
type Calorias = Number
type Porcentaje = Number 

type Ingrediente = (Nombre, Calorias)
{-
Otra alternativa es definir un Data

data Ingrediente = Ingrediente {
  nombre:: String,
  calorias :: Calorias
}

Incluso el nombre no es utilizado en los cálculos porque solo dependen de las claorías que aportan. 
Entonces podría ser solamente: 

type Ingrediente = Calorias

-}

data Chocolate = Chocolate {
  nombre :: String,
  porcentajeCacao :: Porcentaje,
  gramaje:: Number,
  azucar ::Number,
  ingredientes :: [Ingrediente]
} deriving (Eq)
{-
El porcentaje de cacao podría modelarse como un ingrediente pero no matchea con lo modelado anteriormente.

El ingrediente es modelado por un nombre y una cantidad de calorías, no por un porcentaje o un gramaje.

Si adaptamos al ingrediente para que acepte un porcentaje o un gramaje y lo agregamos a la lista, 
nos veremos forzados que cuando necesitemos acceder al porcentaje de chocolate, tenemos que hacer un find 
para encontrar el ingrediente chocolate y luego acceder al porcentaje de chocolate.
-}
instance Show Chocolate where
  show choco = nombre choco

-- Punto 1
cantidadDeIngredientes :: Chocolate -> Number
cantidadDeIngredientes = length.ingredientes

precio choco | ((>60).porcentajeCacao) choco = gramaje choco * precioPorGramoPremium choco
 | ((>4).cantidadDeIngredientes) choco = (8 *).cantidadDeIngredientes $ choco
 | otherwise = gramaje choco * 1.5

precioPorGramoPremium:: Chocolate -> Number
precioPorGramoPremium choco | esAptoDiabeticos choco = 8
 | otherwise = 5

esAptoDiabeticos:: Chocolate -> Bool
esAptoDiabeticos = (==0).azucar

{-
Creamos las funciones que nos permiten acceder a la tupla. En caso de optar por 
un data, estas funciónes están implícitas.
-}
caloriasIngrediente ::Ingrediente -> Calorias
caloriasIngrediente = snd

nombreIngrediente ::Ingrediente -> String
nombreIngrediente = fst

-- Punto 2 
type Caja = [Chocolate]

esBombonAsesino :: Chocolate -> Bool
esBombonAsesino = any ((>200).caloriasIngrediente).ingredientes

totalCalorias :: Chocolate -> Calorias
totalCalorias = sum.map caloriasIngrediente.ingredientes 

aptosParaNinios :: Caja -> Caja
aptosParaNinios = take 3.filter (not.esBombonAsesino)


--Punto 3

type Proceso = Chocolate -> Chocolate

{-
Creamos la abstracción de agregarIngrediente para no repetir lógica
en las funciones que modelan los procesos.
-}
agregarIngrediente :: Ingrediente -> Proceso
agregarIngrediente ingrediente chocolate = chocolate {
  ingredientes = ingrediente:ingredientes chocolate
}

frutalizado :: String -> Number -> Proceso
frutalizado fruta gramos = agregarIngrediente  (fruta, gramos * 2)


dulceDeLeche :: Proceso
dulceDeLeche choco = agregarIngrediente ("ddl",220) choco {
  nombre = nombre choco ++ " Tentacion"
}

celiaCrucera :: Number -> Proceso
celiaCrucera gramos chocolate = chocolate {
  azucar = azucar chocolate + gramos
} 

embriagadora :: Number -> Proceso
embriagadora grados = celiaCrucera 100 .agregarIngrediente ("Licor", min 30 grados)

-- Punto 4
type Receta = [Proceso]

recetaPunto4 :: Receta
recetaPunto4 = [frutalizado "naranja" 10, dulceDeLeche, embriagadora 32]

-- Punto 5
prepararChocolate:: Chocolate -> Receta -> Chocolate
prepararChocolate = foldr ($)

--Punto 6
data Persona = Persona {
  noLeGusta:: Ingrediente -> Bool,
  limiteDeSaturacion:: Calorias
}

hastaAcaLlegue:: Persona -> [Chocolate] -> [Chocolate]
hastaAcaLlegue _ [] = [] 
hastaAcaLlegue persona (chocolate:chocolates) | any (noLeGusta persona).ingredientes $ chocolate = hastaAcaLlegue persona chocolates
  -- Alternativa que evalúa después de comer el chocolate
 | (<=0).limiteDeSaturacion.come persona $ chocolate = []
 | otherwise = chocolate:hastaAcaLlegue (come persona chocolate) chocolates
-- Alternativa que evalúa antes de comer el chocolate
-- | (<=0).limiteDeSaturacion persona $ chocolate = []

come :: Persona -> Chocolate -> Persona 
come persona choco = persona {limiteDeSaturacion = limiteDeSaturacion persona - totalCalorias choco }

-- Punto 7
-- aptosParaNinios puede terminar porque toma los 3 primeros bombones, mientras cumpla está todo bien
-- totalCalorias' no converge porque queremos obtener la sumatoria de la lista infinita