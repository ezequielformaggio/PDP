module Library where
import PdePreludat
-- import Text.Show.Functions
-- Definicion de tipos
type Desgaste = Number
type Patente = String
type Fecha = (Number, Number, Number)
type Tecnico = (Auto -> Auto)

-- Definiciones base
anio :: Fecha -> Number
anio (_, _, year) = year

data Auto = Auto {
 patente :: Patente,
 desgasteLlantas :: [Desgaste],
 rpm :: Number,
 temperaturaAgua :: Number,
 ultimoArreglo :: Fecha
} deriving Show



-- Punto 1 -----------------------------------------------------------------------------------------------------------------------------

-- Saber el costo de reparación de un auto
-- si la patente tiene 7 dígitos, es $ 12.500
-- si la patente tiene 6 dígitos, si la patente está entre las letras "DJ" y "NB", se aplica el calculoPatental
-- que es $ 3.000 * la longitud para las patentes que terminen en 4
-- o $ 20.000 para el resto de las patentes
-- en caso de no ingresar en los puntos anteriores, se le cobra $ 15.000

costoDeReparacion :: Auto -> Number
costoDeReparacion auto | ((== 7).length.patente) auto = 12500
                       | ((== 6).length.patente) auto && (patenteEntreDJyNB.patente) auto= (calculoParental.patente) auto
                       | otherwise = 15000

calculoParental :: Patente -> Number
calculoParental patenteAuto | ((== '4').last) patenteAuto =  ((3000 *).length) patenteAuto
                            | otherwise = 20000

tomarDosCaracteres :: String -> String
tomarDosCaracteres = take 2 

patenteEntreDJyNB :: Patente -> Bool
patenteEntreDJyNB patenteAuto = ((>= "DJ").tomarDosCaracteres) patenteAuto && ((<= "NB").tomarDosCaracteres) patenteAuto


-- PUNTO 2 ----------------------------------------------------------------------------------------------------------------------------

-- Parte 1) Auto peligroso (integrante a)

autoPeligroso::Auto->Bool
autoPeligroso = desgastePeligrosoPrimeraLlanta.desgasteLlantas

desgastePeligrosoPrimeraLlanta::[Desgaste]->Bool
desgastePeligrosoPrimeraLlanta = (>0.5).head

-- Parte 2) Necesita revisión (integrante b)

necesitaRevision :: Auto -> Bool
necesitaRevision = (<= 2015).calcularUltimoArreglo

calcularUltimoArreglo :: Auto -> Number
calcularUltimoArreglo = anio.ultimoArreglo

-- PUNTO 3 -----------------------------------------------------------------------------------------------------------------------------

--Parte 1) Integrante A

-- Alfa: hace que el auto regule a 2.000 vueltas, salvo que esté a menos de 2.000 vueltas, en cuyo caso lo deja como está

type PersonalTecnico = Auto->Auto
alfa :: PersonalTecnico
alfa auto = auto {
  rpm = min (rpm auto) 2000
}

-- Bravo: cambia todas las cubiertas, dejándolas sin desgaste
bravo :: PersonalTecnico
bravo auto = auto {
    desgasteLlantas = [0,0,0,0]
}

-- Charly:  realiza las mismas actividades que Alfa y Bravo
charlie :: PersonalTecnico
charlie = alfa.bravo 


--Parte 2) Integrante B

-- Tango: le gusta decir que hizo muchas cosas pero en realidad no hace ningún arreglo
tango :: Auto -> Auto
tango auto = auto
--tango = id

cambiarLlantasDelanteras :: [Desgaste] -> [Desgaste]
cambiarLlantasDelanteras (x:y:xs) = (0:0:xs)


-- Zulu: revisa la temperatura del agua, la deja a 90 y hace lo mismo que Lima (ver a continuación)
zulu :: Auto -> Auto
zulu = lima.cambiarTemperatura

cambiarTemperatura :: Auto -> Auto
cambiarTemperatura auto = auto {
    temperaturaAgua = 90
}
{- zulu auto = auto { 
    temperaturaAgua = 90,
    desgasteLlantas = (cambiarLlantasDelanteras.desgasteLlantas) auto
} -}


lima :: Auto -> Auto
lima auto = auto {
    desgasteLlantas = (cambiarLlantasDelanteras.desgasteLlantas) auto
}


-- Punto 4 -----------------------------------------------------------------------------------------------------------------------------

{- Dada una serie de autos, saber si están ordenados en base al siguiente criterio:
los autos ubicados en la posición impar de la lista deben tener una cantidad de desgaste impar
los autos ubicados en la posición par deben tener una cantidad de desgaste par
asumimos que el primer elemento está en la posición 1, el segundo elemento en la posición 2, etc.

La cantidad de desgaste es la sumatoria de desgastes de las cubiertas de los autos multiplicada por 
10. Ejemplo: 0.2 + 0.5 + 0.6 + 0.1 = 1.4 * 10 = 14. Para determinar si es par o no (y evitar errores de redondeo) 
es conveniente utilizar la función round. -}

cantidadDeDesgaste:: Auto -> Desgaste
cantidadDeDesgaste  = round.(*) 10.sum.desgasteLlantas

estaOrdenado:: [Auto] -> Bool
estaOrdenado [] = True
estaOrdenado [x] = (odd.cantidadDeDesgaste) x
estaOrdenado (x:y:xs) = (odd.cantidadDeDesgaste) x && (even.cantidadDeDesgaste) y && estaOrdenado xs

-- Punto 5------------------------------------------------------------------------------------------------------------------------------

{- Aplicar una orden de reparación, que tiene
una fecha
una lista de técnicos
y consiste en que cada uno de los técnicos realice las reparaciones que sabe sobre el auto, 
al que además hay que actualizarle la última fecha de reparación. -}

ordenDeReparacion:: Fecha -> [Tecnico] -> Auto -> Auto
ordenDeReparacion fecha listaTecnicos auto = actualizarFecha fecha (foldr ($) auto listaTecnicos)  

actualizarFecha :: Fecha -> Auto -> Auto
actualizarFecha fecha auto =  auto {
    ultimoArreglo = fecha
}

-- Punto 6 ------------------------------------------------------------------------------------------------------------------------

{- 5.1 Parte 1) Integrante a: Técnicos que dejan el auto en condiciones:

Dada una lista de técnicos determinar aquellos técnicos que dejarían el auto en condiciones 
(que no sea peligroso andar, recordar el punto 2.1 del integrante a). -}

dejanEnCondiciones :: [Tecnico] -> Auto -> [Tecnico]
dejanEnCondiciones listaTecnicos auto = filter (not.autoPeligroso.(\tecnico-> tecnico auto)) listaTecnicos

listaTecnicos = [alfa, bravo, charlie, tango, zulu, lima]

{-5.2 Parte 2) Integrante b: Costo de reparación de autos que necesitan revisión
Dada una lista de autos, saber cuál es el costo de reparación de los autos que necesitan revisión. -}

totalCostosDeReparacion :: [Auto] -> Number
totalCostosDeReparacion = sum.map costoDeReparacion.filter necesitaRevision


--Punto 7 -----------------------------------------------------------------------------------------------------------------------------


{- 6.1 Parte 1) Integrante a: Técnicos que dejan el auto en condiciones

 En base al punto “dada una lista de técnicos determinar qué técnicos dejarían el auto en condiciones”
 y considerando una lista de técnicos  infinita, 
 ¿podríamos obtener el primer técnico que deja el auto en condiciones? Muestre un ejemplo y justifique. 

dejanEnCondiciones :: [Tecnico] -> Auto -> [Tecnico]
dejanEnCondiciones listaTecnicos auto = filter (not.autoPeligroso.(\tecnico-> tecnico auto)) listaTecnicos

Si nos basamos concretamente en este ejemplo trabajar con una lista infinita no seria posible por el comportamiento propio de la funcion
filter, ya que esta evalua listas en su totalidad, sinedole imposible evaluar una lista infinita, pero si seria posible si usamos otro 
metodo. 

Metodo por el cual seria posible encontrar al primer tecnico que cumple con esta condicion:
   
Ejemplo:

-}

listaTecnicosInfinita = (bravo:zulu:lima:tango:alfa:charlie:tecnicosInfinitos)

primeroDeListaInfinita :: [Tecnico] -> Auto -> Tecnico
primeroDeListaInfinita listaTecnicosInfinita auto = (!!) listaTecnicosInfinita (posicionTecnico posicion listaTecnicosInfinita auto) 

posicion = 0

posicionTecnico :: Number -> [Tecnico] -> Auto -> Number 
posicionTecnico posicion (tecnico:tecnicos) auto
        | (autoPeligroso.tecnico) auto == True = posicionTecnico (posicion + 1) tecnicos auto
        | otherwise = posicion



{- Parte 2) Integrante b: Costo de reparación de autos que necesitan revisión
En base al punto “Dada una lista de autos, saber cuál es el costo de reparación de los autos que necesitan revisión.”,  
¿podríamos tener una lista infinita de autos? Muestre un ejemplo y justifique. 

-- En totalCostosDeReparacion no acepta listas infinitas porque el filter es una funcion que evalua todos los elementos 
-- de la lista con lo cual no puede terminar de evaluar

Y si tomáramos en cuenta los tres primeros autos que necesitan revisión, 
¿cómo debería cambiar la función? Por otra parte, ¿esta versión aceptaría una lista infinita de autos? 

-- La nueva version totalCostosDeReparacionInfinitas aceptaria una lista infinita de autos porque solo evaluo 
-- los n primeros que cumplan la condicion de filtro. En este caso necesitaRevision.
-- Esto se debe al metodo de lazy evaluation que toma solo los valores que cumplen con cierto criterio sin la necesidad
-- de recorrer toda la lista.

Modifique la función 6.b con otro nombre y justifique sus respuestas. -}

tecnicosInfinitos = zulu:tecnicosInfinitos
 
autosInfinitos' :: Number -> [Auto]
autosInfinitos' n = Auto {
 patente = "AAA000",
 desgasteLlantas = [n, 0, 0, 0.3],
 rpm = 1500 + n,
 temperaturaAgua = 90,
 ultimoArreglo = (20, 1, 2013)
} : autosInfinitos' (n + 1)

filtrarPrimeros :: Number -> (a->Bool) -> [a] -> [a]
filtrarPrimeros nro f (x:xs) 
    | f x && nro > 0 = x : filtrarPrimeros (nro - 1) f xs
    | nro > 0 = filtrarPrimeros nro f xs
    | otherwise = []

totalCostosDeReparacionInfinitas :: [Auto] -> Number
totalCostosDeReparacionInfinitas = sum.map costoDeReparacion.filtrarPrimeros 3 necesitaRevision