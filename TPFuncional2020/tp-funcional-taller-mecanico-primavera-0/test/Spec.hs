import PdePreludat
import Library
import Test.Hspec

auto1 = Auto {
 patente = "AT001LN",
 desgasteLlantas = [0.5, 0.1, 0.6, 0.4],
 rpm = 2500,
 temperaturaAgua = 90,
 ultimoArreglo = (20,03,2014)
} 

auto2 = Auto {
 patente = "DJV214",
 desgasteLlantas = [0.51, 0.1, 0.6, 0.4],
 rpm = 2500,
 temperaturaAgua = 90,
 ultimoArreglo = (20,03,2016)
} 

auto3 = Auto {
 patente = "DJV215",
 desgasteLlantas = [0, 0, 0, 0],
 rpm = 1999,
 temperaturaAgua = 90,
 ultimoArreglo = (20,03,2018)
} 

auto4 = Auto {
 patente = "DFH029",
 desgasteLlantas = [0.61, 0.1, 0.6, 0.4],
 rpm = 2500,
 temperaturaAgua = 90,
 ultimoArreglo = (20,03,2015)
} 

auto5 = Auto {
 patente = "DFH234",
 desgasteLlantas =  [0.1, 0.4, 0.6, 0.4],
 rpm = 2500,
 temperaturaAgua = 120,
 ultimoArreglo = (20,03,2018)
} 

auto6 = Auto {
 patente = "DFH234",
 desgasteLlantas =  [0.2, 0.5, 0.6, 0.1],
 rpm = 2500,
 temperaturaAgua = 120,
 ultimoArreglo = (20,03,2018)
}

auto7 = Auto {
 patente = "DFH234",
 desgasteLlantas =  [0.3, 0.5, 0.6, 0.1],
 rpm = 2500,
 temperaturaAgua = 120,
 ultimoArreglo = (20,03,2018)
}

auto8 = Auto {
 patente = "DFH234",
 desgasteLlantas = [0.1, 0.1, 0.1, 0],
 rpm = 2500,
 temperaturaAgua = 120,
 ultimoArreglo = (20,03,2018)
}

auto9 = Auto {
 patente = "DFH234",
 desgasteLlantas =  [0.1, 0.4, 0.2, 0.1],
 rpm = 2500,
 temperaturaAgua = 120,
 ultimoArreglo = (20,03,2018)
} 


listaAutos1 = [auto5, auto6, auto8]
listaAutos2 = [auto5, auto7, auto8]
listaAutos3 = [auto5]
listaAutos4 = [auto9]

auto1Arreglado = tango auto1
auto5Arreglado = zulu auto5
auto2Arreglado = charlie auto2
auto1Reparado = ordenDeReparacion (31, 05, 2020) [zulu, alfa, bravo] auto1
auto2Reparado = ordenDeReparacion (20, 05, 2020) [tango, tango, tango] auto2
auto4Reparado = ordenDeReparacion (15, 05, 2020) [charlie, tango] auto4

autosInfinitos :: [Auto]
autosInfinitos = autosInfinitos' 0


    
main :: IO ()
main = hspec $ do
  describe "Test del punto 1" $ do

-- Test punto 1    
    it "el costo de reparación de un auto cuya patente es AT001LN debe ser 12500" $ do
      costoDeReparacion auto1  `shouldBe` 12500

    it "el costo de reparación de una patente DJV214 debe ser 18000" $ do
      costoDeReparacion auto2  `shouldBe` 18000

    it "el costo de reparación de una patente DJV215 debe ser 20000" $ do
      costoDeReparacion auto3  `shouldBe` 20000

    it "el costo de reparación de una patente DFH029 debe ser 15000" $ do
      costoDeReparacion auto4  `shouldBe` 15000

-- Test punto 2 Integrante A

  describe "Test del punto 2 Integrante A" $ do
    it "Un auto con desgaste de llantas [0.5, 0.1, 0.6, 0.4]" $ do
      autoPeligroso auto3  `shouldBe` False

    it "Un auto con desgaste de llantas [0.51, 0.1, 0.6, 0.4]" $ do
      autoPeligroso auto4  `shouldBe` True

-- Test punto 2 Integrante B

  describe "Test del punto 2 Integrante B" $ do
    it "Un auto cuyo último arreglo fue en el 2016 no debe necesitar revision" $ do
      necesitaRevision auto3  `shouldBe` False

    it "Un auto cuyo último arreglo fue en el 2015 no debe necesitar revision" $ do
      necesitaRevision auto4  `shouldBe` True

-- Test punto 3 Integrante A

  describe "Test del punto 3 Integrante A" $ do
    it "Si Alfa arregla las RPM, deberia dejarlas en 2000" $ do
      (rpm.alfa) auto1  `shouldBe` 2000

    it "Si Bravo cambia las 4 ruedas, deja su desgaste en cero" $ do
      (desgasteLlantas.bravo) auto2  `shouldBe` [0,0,0,0]
    
    it "Si Charlie revisa las rpm del auto y es necesario, las baja a 2000, y cambia las 4 ruedas dejandolas con cero desgaste" $ do
      desgasteLlantas auto2Arreglado  `shouldBe` [0,0,0,0]
      rpm auto2Arreglado `shouldBe` 2000

-- Test punto 3 Integrante B

  describe "Test del punto 3 Integrante B" $ do
    it "Si Tango trabaja en un auto no hace ningún arreglo" $ do
      patente auto1  `shouldBe` patente auto1Arreglado
      desgasteLlantas auto1  `shouldBe` desgasteLlantas auto1Arreglado
      rpm auto1  `shouldBe` rpm auto1Arreglado
      temperaturaAgua auto1  `shouldBe` temperaturaAgua auto1Arreglado
      ultimoArreglo auto1  `shouldBe` ultimoArreglo auto1Arreglado

    it "Si Zulu revisa la temperatura del agua la deja a 90 y cambia las ruedas delanteras y deja su desgaste en cero" $ do
      desgasteLlantas auto5Arreglado `shouldBe` [0, 0, 0.6, 0.4]
      temperaturaAgua auto5Arreglado `shouldBe` 90

    it "Si Lima cambia las ruedas delanteras, deja su desgaste en cero" $ do
      (desgasteLlantas.lima) auto5 `shouldBe` [0, 0, 0.6, 0.4]


-- Test punto 4

  describe "Test del punto 4" $ do
    it "Deberia estar ordenado segun el criterio" $ do
      estaOrdenado listaAutos1  `shouldBe` True

    it "Deberia estar ordenado segun el criterio" $ do
      estaOrdenado listaAutos2  `shouldBe` False

    it "Deberia estar ordenado segun el criterio" $ do
      estaOrdenado listaAutos3  `shouldBe` True

    it "Deberia estar ordenado segun el criterio" $ do
      estaOrdenado listaAutos4  `shouldBe` False


    --  Test Punto 5

  describe "Test del punto 5" $ do
    it "Realizar una reparacion con los tecnicos zulu, bravo, alfa" $ do
      desgasteLlantas auto1Reparado `shouldBe` [0, 0, 0, 0]
      rpm auto1Reparado `shouldBe` 2000
      temperaturaAgua auto1Reparado `shouldBe` 90
      ultimoArreglo auto1Reparado  `shouldBe` (31, 05, 2020)

    it "Realizar una reparacion con los tecnicos [tango, tango, tango]" $ do
      desgasteLlantas auto2Reparado  `shouldBe` [0.51, 0.1, 0.6, 0.4]
      rpm auto2Reparado  `shouldBe` 2500
      temperaturaAgua auto2Reparado  `shouldBe`  90
      ultimoArreglo auto2Reparado  `shouldBe` (20, 05, 2020)

    it "Realizar una reparacion con los tecnicos [charlie, tango]" $ do
      desgasteLlantas auto4Reparado  `shouldBe` [0, 0, 0, 0]
      rpm auto4Reparado  `shouldBe` 2000
      temperaturaAgua auto4Reparado  `shouldBe`  90
      ultimoArreglo auto4Reparado  `shouldBe` (15, 05, 2020)

-- Test punto 6

  -- Test punto 6 integrante A

  describe "Test del punto 6 integrante A" $ do
      it "Si la lista es [alfa, bravo, charly, tango, zulu, lima] y el desgaste es de 0.6" $ do
        length (dejanEnCondiciones listaTecnicos auto4)  `shouldBe` 4

      it "Si la lista es [alfa, bravo, charly, tango, zulu, lima] y el desgaste es de 0.5" $ do
        length (dejanEnCondiciones listaTecnicos auto1) `shouldBe` 6


    -- Test punto 6 integrante B

  describe "Test del punto 6 integrante B" $ do
    it "Dada una lista de autos cuyas patentes son AT001LN, DJV214, DJV215, DFH029, donde AT001LN y DFH029 son los que necesitan revisión" $ do
      totalCostosDeReparacion [auto1, auto2, auto3, auto4] `shouldBe` 27500



-- Test Punto 7

  --Test punto 7 integrante A

  --describe "Test del punto 7 integrante A" $ do
  --  it "Dada una lista de tecnicos infinita, devuelve el primero capaz de dejar el auto en condiciones" $ do
  --    primeroDeListaInfinita listaTecnicosInfinita auto4 `shouldBe` alfa

-- El problema es que las funciones no pueden comprararse, podria comparar los autos resultantes de aplicar cada fuinción
-- pero no podria obtener los datos de quien fue


    -- Test punto 7 integrante B
  describe "Test del punto 7 integrante B" $ do
    it "Saber el costo de reparacion de los 3 primeros autos con lista infinita" $ do
      totalCostosDeReparacionInfinitas autosInfinitos `shouldBe` 45000



