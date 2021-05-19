module Main where

import CommonParserUtil

import TokenInterface
import Token
import Expr
import Lexer
import Parser

import EmacsServer
import SynCompInterface
import Control.Exception
import Data.Typeable

import System.IO

main :: IO ()
main = do
  emacsServer computeCand

-- Todo: The following part should be moved to the library.
--       Arguments: lexerSpec, parserSpec
--                  isSimpleMode
--                  programTextUptoCursor, programTextAfterCursor

-- | computeCand
data ParseErrorWithLineCol token ast = ParseErrorWithLineCol Int Int (ParseError token ast)
  deriving (Typeable, Show)

instance (TokenInterface token, Typeable token, Show token, Typeable ast, Show ast)
  => Exception (ParseErrorWithLineCol token ast)

computeCand :: String -> String -> Bool -> IO [EmacsDataItem]
computeCand programTextUptoCursor programTextAfterCursor isSimpleMode = do
  ((computeCand_ isSimpleMode programTextUptoCursor programTextAfterCursor
    `catch` \e -> case e :: LexError of _ -> handleLexError)
    `catch` \e -> case e :: ParseErrorWithLineCol Token AST of ParseErrorWithLineCol line column e -> do {
        (_, _, terminalListAfterCursor) <- lexing_ lexerSpec line column programTextAfterCursor;
        handleParseError isSimpleMode terminalListAfterCursor e
        })
    
computeCand_ :: Bool -> String -> String -> IO [EmacsDataItem]
computeCand_ isSimpleMode programTextUptoCursor programTextAfterCursor = do
  (line, column, terminalListUptoCursor)  <- lexing_ lexerSpec 1 1 programTextUptoCursor
  
  ast <-
    (parsing parserSpec terminalListUptoCursor
      `catch` \e -> case e :: ParseError Token AST of  _ -> throw (ParseErrorWithLineCol line column e))

  successfullyParsed
