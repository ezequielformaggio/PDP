module Library
    ( nombre,
    cantidadParciales,
    materiaCopada,
    tieneProblemasDeCupo
    ) where

import PdePreludat

type Nombre = String
type CantidadInscriptos = Number

type Materia = (Nombre, CantidadInscriptos)

nombre :: Materia -> Nombre
nombre = fst

cantidadParciales :: Materia -> CantidadInscriptos
cantidadParciales = snd

--Saber si una materia es copada, esto implica que su nombre tiene una cantidad de letras par:

nombreEsPar :: String -> Bool
nombreEsPar nombre = (even . length ) nombre

materiaCopada :: Materia -> Bool
materiaCopada  =  nombreEsPar . nombre 

-- Esto se da cuando la cantidad de inscriptos supera el 50% de los 5.000 alumn@s regulares que hoy tiene la facultad:


cuposLlenos :: Number -> Bool
cuposLlenos numero = numero > 2500

tieneProblemasDeCupo :: Materia -> Bool
tieneProblemasDeCupo = cuposLlenos . cantidadParciales
