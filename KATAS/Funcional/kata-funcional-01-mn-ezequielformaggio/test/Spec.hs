import PdePreludat
import Library
import Test.Hspec
import Control.Exception (evaluate)

main :: IO ()
main = hspec $ do
   describe "Test calcuLoco - dado el primer número mayor que el segundo" $ do
      it "se obtiene la división" $ do
          (calcuLoco 6 2) `shouldBe` 3

      it "si el segundo número es 0 la división debe fallar" $ do
          evaluate (calcuLoco 6 0) `shouldThrow` anyException

   describe "Test calcuLoco - dado el primer número impar y no mayor que el segundo" $ do
      it "se obtiene el segundo número menos cinco" $ do
          (calcuLoco 5 7) `shouldBe` 2.0

   describe "Test calcuLoco - dado el primer número par y no mayor que el segundo" $ do
      it "se obtiene el doble del primer número" $ do
          (calcuLoco 8 10) `shouldBe` 16
