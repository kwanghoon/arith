module Parser where

import CommonParserUtil
import Token
import Expr

import ParserTime

-- | Utility
rule prodRule action              = (prodRule, action, Nothing  )
ruleWithPrec prodRule action prec = (prodRule, action, Just prec)
ruleWithNoAction prodRule         = (prodRule, noAction, Nothing)

noAction = \rhs -> return ()

parserSpec :: ParserSpec Token AST IO ()
parserSpec = ParserSpec
  {
    startSymbol = "Start",
    
    tokenPrecAssoc = [],

    parserSpecList =
    [
      ruleWithNoAction "Start -> MultiplicativeExpr",   -- Changed

      ruleWithNoAction "MultiplicativeExpr -> MultiplicativeExpr * AdditiveExpr",   -- New

      ruleWithNoAction "MultiplicativeExpr -> MultiplicativeExpr / AdditiveExpr",   -- New

      ruleWithNoAction "MultiplicativeExpr -> AdditiveExpr",            -- New
      
      ruleWithNoAction "AdditiveExpr -> AdditiveExpr + PrimaryExpr",

      ruleWithNoAction "AdditiveExpr -> AdditiveExpr - PrimaryExpr",

      ruleWithNoAction "AdditiveExpr -> PrimaryExpr",

      ruleWithNoAction "PrimaryExpr -> integer_number",

      ruleWithNoAction "PrimaryExpr -> ( MultiplicativeExpr )" -- Changed: MultiplicativeExpr
    ],
    
    baseDir = "./",
    actionTblFile = "action_table.txt",  
    gotoTblFile = "goto_table.txt",
    grammarFile = "prod_rules.txt",
    parserSpecFile = "mygrammar.grm",
    genparserexe = "yapb-exe",

    synCompSpec = Nothing,
    parserTime = ParserTime {
                   pa_startTime=startTime,
                   pa_finishTime=finishTime
                 }
  }


