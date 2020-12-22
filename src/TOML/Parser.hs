module TOML.Parser (Source, AST, scan) where

import TOML.Parser.TokenStream (Source, translate)
import TOML.Parser.AST (AST, restore)

scan :: Source -> AST 
scan = restore . translate
