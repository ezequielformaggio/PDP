import PdePreludat
import Library
import Test.Hspec
import Control.Exception (evaluate)

main :: IO ()
main = hspec $ do
   describe "Dado un grupo de personas" $ do
      it "las que quieren ser presidente son ambiciosas" $ do
          personas `shouldSatisfy` elem "gogo" . map nombre . ambiciosas

      it "las que quieren gobernar son ambiciosas" $ do
          personas `shouldSatisfy` elem "daenerys" . map nombre . ambiciosas

      it "las otras personas no son ambiciosas" $ do
          ((length . ambiciosas) personas) `shouldBe` 2
