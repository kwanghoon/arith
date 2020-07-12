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


