module Main where

import CommonParserUtil

import TokenInterface
import Token
import Expr
import Lexer
import Parser
import SyntaxCompletion

import EmacsServer
import SynCompInterface
import Control.Exception
import Data.Typeable
import SynCompAlgorithm

import System.IO

main :: IO ()
main = do
  emacsServer (computeCand True)

-- Todo: The following part should be moved to the library.
--       Arguments: lexerSpec, parserSpec
--                  isSimpleMode
--                  programTextUptoCursor, programTextAfterCursor

