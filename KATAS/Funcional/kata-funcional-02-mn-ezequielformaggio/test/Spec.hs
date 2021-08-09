import Library
import PdePreludat
import Test.Hspec

computacion = ("Computación", 2501)
paradigmas = ("Paradigmas de Programación", 2500)

main :: IO ()
main = hspec $ do
   describe "Test Materia copada" $ do
      it "una materia con nombre par es copada" $ do
          paradigmas `shouldSatisfy` materiaCopada

      it "una materia con nombre impar no es copada" $ do
           computacion `shouldNotSatisfy` materiaCopada
  
   describe "Test Problemas de cupo" $ do
      it "materia sin problemas de cupo" $ do
            paradigmas `shouldNotSatisfy` tieneProblemasDeCupo
   
      it "materia con problemas de cupo" $ do
            computacion `shouldSatisfy` tieneProblemasDeCupo
