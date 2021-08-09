module Library where
import PdePreludat

{-De cada turista nos interesa:
Sus niveles de cansancio y stress
Si está viajando solo
Los idiomas que habla-}

data Turista = UnTurista {
    nivelDeCansancio :: Number,
    nivelDeStress :: Number,
    viajaSolo :: Bool,
    idiomasQueHabla :: [String]
} deriving (Show)

type Excurision = Turista -> Turista

-- Caminar ciertos minutos: aumenta el cansancio pero reduce el stress según la intensidad de la caminad, ambos en la misma cantidad. 
-- El nivel de intensidad se calcula en 1 unidad cada 4 minutos que se caminen.

-- Paseo en barco: depende de cómo esté la marea
    -- si está fuerte, aumenta el stress en 6 unidades y el cansancio en 10.
    -- si está moderada, no pasa nada.
    -- si está tranquila, el turista camina 10’ por la cubierta, aprecia la vista del “mar”, y sale a hablar con los tripulantes alemanes.

{-Nos avisaron que es común que, cada cierto tiempo, se vayan actualizando las 
excursiones que ofrecen, en base a las nuevas demandas que surgen en el mercado turístico. -}


{-Crear un modelo para los turistas y crear los siguientes tres ejemplos:
Ana: está acompañada, sin cansancio, tiene 15 de stress y habla español.
Beto y Cathi, que hablan alemán, viajan solos, y Cathi además habla catalán. Ambos tienen 15 unidades de cansancio y stress.-}

ana = UnTurista {
    nivelDeCansancio = 0,
    nivelDeStress = 21,
    viajaSolo = False,
    idiomasQueHabla = ["Español"]
}

beto = UnTurista {
    nivelDeCansancio = 15,
    nivelDeStress = 15,
    viajaSolo = True,
    idiomasQueHabla = ["Aleman"]
}

cathi = UnTurista {
    nivelDeCansancio = 15,
    nivelDeStress = 15,
    viajaSolo = True,
    idiomasQueHabla = ["Aleman","Catalan"]
}


-- Modelar las excursiones anteriores de forma tal que para agregar una excursión al sistema no haga falta modificar las funciones 
-- existentes. Además:
-- Hacer que un turista haga una excursión. 
-- Al hacer una excursión, el turista además de sufrir los efectos propios de la excursión, reduce en un 10% su stress.

modificarNivelDeStress :: Turista -> (Number -> Number) -> Turista
modificarNivelDeStress turista funcion = turista {
    nivelDeStress = (funcion.nivelDeStress $ turista) - (nivelDeStress turista * (div 10 100))
} 

modificarNivelDeCansancio :: Turista -> (Number -> Number) -> Turista
modificarNivelDeCansancio turista funcion = turista {
    nivelDeStress = funcion.nivelDeStress $ turista
}

estaViajandoSolo :: Turista -> Bool
estaViajandoSolo turista = viajaSolo turista

-- Ir a la playa: si está viajando solo baja el cansancio en 5 unidades, si no baja el stress 1 unidad.

irALaPlaya :: Excurision
irALaPlaya turista | estaViajandoSolo turista = modificarNivelDeStress turista (+(- 5))
                   | otherwise                = modificarNivelDeStress turista (+(-1))

-- Apreciar algún elemento del paisaje: reduce el stress en la cantidad de letras de lo que se aprecia. 
