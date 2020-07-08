module Expr where

data AST =
    ASTExpr { fromAstExpr :: Expr   }

instance Show AST where
  showsPrec p _ = (++) "AST ..."

toAstExpr :: Expr -> AST
toAstExpr expr = ASTExpr expr

data Expr =
    Lit { fromLit :: Int }
  | Var { fromVar :: String }
  | BinOp { kindFromBinOp :: BinOpKind,
            leftOpFromBinOp :: Expr,
            rightOpFromBinOp :: Expr }
  | Assign { lhsFromAssign :: String,
             rhsFromAssign :: Expr  }

data BinOpKind = ADD | SUB | MUL | DIV

pprintAst :: AST -> String
pprintAst (ASTExpr expr) = pprint expr

pprint :: Expr -> String
pprint (Lit i) = show i
pprint (Var v) = v
pprint (BinOp Expr.ADD left right) =
  "(" ++ pprint left ++ " + " ++ pprint right ++ ")"
pprint (BinOp Expr.SUB left right) =
  "(" ++ pprint left ++ " - " ++ pprint right ++ ")"
pprint (BinOp Expr.MUL left right) =
  "(" ++ pprint left ++ " * " ++ pprint right ++ ")"
pprint (BinOp Expr.DIV left right) =
  "(" ++ pprint left ++ " / " ++ pprint right ++ ")"
pprint (Assign x expr) =   
  "(" ++ x ++ " = " ++ pprint expr ++ ")"
