module TOML.Parser.AST (AST, restore) where

import TOML.Parser.TokenStream (Stream)

type AST = Stream

restore :: Stream -> AST 
restore tokenStream = syntaxTree where syntaxTree = tokenStream
