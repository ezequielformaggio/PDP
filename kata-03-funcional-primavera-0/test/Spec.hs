import PdePreludat
import Library
import Test.Hspec

pedro = Persona {
  edad = 25,
  sueldo = 40000,
  elementos = ["teclado","mouse"]
}

pablo = Persona {
  edad = 33,
  sueldo = 80000,
  elementos = ["monitor"]
}

ana = Persona {
  edad = 28,
  sueldo = 120000,
  elementos = ["impresora","laptop"]
}

romina = Persona {
  edad = 38,
  sueldo = 60000,
  elementos = ["router","telefono"]
}

empleados = [pedro,pablo,ana,romina]

main :: IO ()
main = hspec $ do

     describe "Test cuantoPonemosDePrepaga" $ do

         it "dada una lista de empleados, se calcula un porcentaje del sueldo para los empleados mayores a la edad límite" $ do
             cuantoPonemosDePrepaga empleados `shouldBe` 28600

     describe "Test genteCabulera" $ do

         it "dada una lista de empleados, se calcula un porcentaje del sueldo para los empleados mayores a la edad límite" $ do
             genteCabulera empleados `shouldMatchList` [pedro,romina]

     describe "Test alterarEmpleados" $ do
         it "Si aplico la función loca entonces modifico la edad de la persona" $ do
             (edad.alterarEmpleado romina) modificacionesLocas `shouldBe` 39

         it "Si aplico la función loca y tiene un elemento en particular entonces quito ese elemento de la persona" $ do
             (elementos.alterarEmpleado pedro) modificacionesLocas `shouldMatchList` ["mouse"]

         it "Si aplico la función loca y no tiene un elemento en particular entonces la persona conserva sus elementos" $ do
             (elementos.alterarEmpleado romina) modificacionesLocas `shouldMatchList` ["telefono","router"]

         it "Si aplico la función loca entonces modifico el sueldo de la persona en un determinado factor" $ do
             (sueldo.alterarEmpleado romina) modificacionesLocas `shouldBe` 72000