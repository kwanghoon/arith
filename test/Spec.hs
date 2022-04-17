module Main where

import SyntaxCompletion (computeCand)
import SynCompInterface
import Test.Hspec

import Config

import Data.Maybe (isJust)
import System.IO (readFile)

spec = hspec $ do
  describe "Arith expression" $ do
    
    let config_simple = True
    
    let config =
          Configuration
            {
              config_SIMPLE       = config_simple,
              config_R_LEVEL      = 1,
              config_GS_LEVEL     = 3,
              config_DEBUG        = False,
              config_DISPLAY      = False,
              config_PRESENTATION = 0,
              config_ALGORITHM    = 3
            }
    
    let benchmark1 = "./app/example/test1.arith"
    
    it ("[Benchmark1] ") $
      do item benchmark1 config 

    let benchmark2 = "./app/example/test2.arith"
    
    it ("[Benchmark2] ") $
      do item benchmark2 config 

item benchmark_file init_config  = 
      do let test_config = init_config
         putStrLn (show test_config)
         
         configMaybe <- readConfig
         benchmark <- readFile benchmark_file
         case configMaybe of
           Just config ->
             do writeConfig test_config  -- set
                results <- computeCand False benchmark "" (config_SIMPLE test_config)
                writeConfig init_config       -- restore
                
           Nothing -> isJust configMaybe `shouldBe` True

  
main :: IO ()
main = spec
  
