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
  emacsServer (computeCand True)

-- Todo: The following part should be moved to the library.
--       Arguments: lexerSpec, parserSpec
--                  isSimpleMode
--                  programTextUptoCursor, programTextAfterCursor

maxLevel = 10000

-- | computeCand
data ParseErrorWithLineCol token ast = ParseErrorWithLineCol Int Int (ParseError token ast ())
  deriving (Typeable, Show)

instance (TokenInterface token, Typeable token, Show token, Typeable ast, Show ast)
  => Exception (ParseErrorWithLineCol token ast)

computeCand :: Bool -> String -> String -> Bool -> IO [EmacsDataItem]
computeCand debug programTextUptoCursor programTextAfterCursor isSimpleMode =
  (
   (
    (do ast <- parsing True
                 parserSpec ((), 1, 1, programTextUptoCursor)
                   (aLexer lexerSpec) (fromToken (endOfToken lexerSpec))
        successfullyParsed)

--      computeCand_ isSimpleMode programTextUptoCursor programTextAfterCursor

     `catch` \e -> case e :: LexError of _ -> handleLexError)

     `catch` \e ->
         case e :: ParseError Token AST () of
           _ ->            

         -- case e :: ParseErrorWithLineCol Token AST of
         --   ParseErrorWithLineCol line column e ->

             do let (_,line,column,programTextAfterCursor) = lpStateFrom e

                handleParseError (
                  defaultHandleParseError {
                      debugFlag=debug,
                      searchMaxLevel=maxLevel,
                      simpleOrNested=isSimpleMode,
                      postTerminalList=[],    -- terminalListAfterCursor is set to []!
                      nonterminalToStringMaybe=Nothing
                      }) e
   )
    
-- computeCand_ :: Bool -> String -> String -> IO [EmacsDataItem]
-- computeCand_ isSimpleMode programTextUptoCursor programTextAfterCursor = do
--   ast <-
--     (parsing True parserSpec ((), 1, 1, programTextUptoCursor)
--       `catch` \e ->
--         case e :: ParseError Token AST () of
--           _ ->
--             do let (_,line,column,programTextAfterCursor) = lpStateFrom e
--                putStrLn (show line)
--                putStrLn (show column)

--                throw (ParseErrorWithLineCol line column e))

--   successfullyParsed
