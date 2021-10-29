module Parser where

import CommonParserUtil
import Token
import Expr

noAction = \rhs -> ()

parserSpec :: ParserSpec Token AST
parserSpec = ParserSpec
  {
    startSymbol = "Start",
    
    parserSpecList =
    [
      ("Start -> AdditiveExpr", noAction),

      ("AdditiveExpr -> AdditiveExpr + PrimaryExpr", noAction),

      ("AdditiveExpr -> AdditiveExpr - PrimaryExpr", noAction),

      ("AdditiveExpr -> PrimaryExpr", noAction),

      ("PrimaryExpr -> integer_number", noAction),

      ("PrimaryExpr -> ( AdditiveExpr )", noAction)
    ],
    
    baseDir = "./",
    actionTblFile = "action_table.txt",  
    gotoTblFile = "goto_table.txt",
    grammarFile = "prod_rules.txt",
    parserSpecFile = "mygrammar.grm",
    genparserexe = "yapb-exe"
  }


parserSpec1 :: ParserSpec Token AST
parserSpec1 = ParserSpec
  {
    startSymbol = "Start",
    
    parserSpecList =
    [
      ("Start -> MultiplicativeExpr", noAction),   -- Changed

      ("MultiplicativeExpr -> MultiplicativeExpr * AdditiveExpr", noAction),   -- New

      ("MultiplicativeExpr -> MultiplicativeExpr / AdditiveExpr", noAction),   -- New

      ("MultiplicativeExpr -> AdditiveExpr", noAction),            -- New
      
      ("AdditiveExpr -> AdditiveExpr + PrimaryExpr", noAction),

      ("AdditiveExpr -> AdditiveExpr - PrimaryExpr", noAction),

      ("AdditiveExpr -> PrimaryExpr", noAction),

      ("PrimaryExpr -> integer_number", noAction),

      ("PrimaryExpr -> ( MultiplicativeExpr )", noAction)      -- Changed: MultiplicativeExpr
    ],
    
    baseDir = "./",
    actionTblFile = "action_table.txt",  
    gotoTblFile = "goto_table.txt",
    grammarFile = "prod_rules.txt",
    parserSpecFile = "mygrammar.grm",
    genparserexe = "yapb-exe"
  }


