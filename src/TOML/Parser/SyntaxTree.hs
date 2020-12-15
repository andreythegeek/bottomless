module TOML.Parser.SyntaxTree (SyntaxTree, restore) where

import TOML.Parser.TokenStream (TokenStream)

type SyntaxTree = TokenStream

restore :: TokenStream -> SyntaxTree
restore tokenStream = syntaxTree where syntaxTree = tokenStream
