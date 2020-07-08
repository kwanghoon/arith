module Parser where

import CommonParserUtil
import Token
import Expr


parserSpec :: ParserSpec Token AST
parserSpec = ParserSpec
  {
    startSymbol = "AdditiveExpr'",
    
    parserSpecList =
    [
      ("AdditiveExpr' -> AdditiveExpr", \rhs -> get rhs 1),

      ("AdditiveExpr -> AdditiveExpr + MultiplicativeExpr",
        \rhs -> toAstExpr (
          BinOp Expr.ADD (fromAstExpr (get rhs 1)) (fromAstExpr (get rhs 3))) ),

      ("AdditiveExpr -> AdditiveExpr - MultiplicativeExpr",
        \rhs -> toAstExpr (
          BinOp Expr.SUB (fromAstExpr (get rhs 1)) (fromAstExpr (get rhs 3))) ),

      ("AdditiveExpr -> MultiplicativeExpr", \rhs -> get rhs 1),

      ("MultiplicativeExpr -> MultiplicativeExpr * PrimaryExpr",
        \rhs -> toAstExpr (
          BinOp Expr.MUL (fromAstExpr (get rhs 1)) (fromAstExpr (get rhs 3))) ),

      ("MultiplicativeExpr -> MultiplicativeExpr / PrimaryExpr",
        \rhs -> toAstExpr (
          BinOp Expr.DIV (fromAstExpr (get rhs 1)) (fromAstExpr (get rhs 3))) ),

      ("MultiplicativeExpr -> PrimaryExpr", \rhs -> get rhs 1),
      
      ("PrimaryExpr -> integer_number",
        \rhs -> toAstExpr (Lit (read (getText rhs 1))) ),

      ("PrimaryExpr -> ( AdditiveExpr )", \rhs -> get rhs 2)
    ],
    
    baseDir = "./",
    actionTblFile = "action_table.txt",  
    gotoTblFile = "goto_table.txt",
    grammarFile = "prod_rules.txt",
    parserSpecFile = "mygrammar.grm",
    genparserexe = "yapb-exe"
  }


