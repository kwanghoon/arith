module SyntaxCompletion where

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
import SynCompAlgorithm

import System.IO

maxLevel = 1

-- | computeCand
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

             do let (_,line,column,programTextAfterCursor) = lpStateFrom e
                compCandidates <- chooseCompCandidatesFn

                handleParseError
                  compCandidates
                  (defaultHandleParseError lexerSpec parserSpec) {
                      debugFlag=debug,
                      searchMaxLevel=maxLevel,
                      simpleOrNested=isSimpleMode,
                      postTerminalList=[],    -- terminalListAfterCursor is set to []!
                      nonterminalToStringMaybe=Nothing
                      } e
   )
    
