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
    startSymbol = "E'",
    
    tokenPrecAssoc = [],

    parserSpecList =
    [
      ruleWithNoAction "E' -> E",

      ruleWithNoAction "E -> E + M",

      ruleWithNoAction "E -> E - M",

      ruleWithNoAction "E -> M",
      
      ruleWithNoAction "M -> M * A",

      ruleWithNoAction "M -> M / A",

      ruleWithNoAction "M -> A",

      ruleWithNoAction "A -> num",

      ruleWithNoAction "A -> ( E )" -- Changed: MultiplicativeExpr
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


