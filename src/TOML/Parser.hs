module TOML.Parser (AST, translate) where

import TOML.Scanner (Token)

type AST = [Token]

translate :: [Token] -> AST
translate stream = stream 
