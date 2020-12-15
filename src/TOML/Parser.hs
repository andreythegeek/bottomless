module TOML.Parser (Source, SyntaxTree, run) where

import TOML.Parser.TokenStream (Source, translate)
import TOML.Parser.SyntaxTree (SyntaxTree, restore)

run :: Source -> SyntaxTree
run = restore . translate
