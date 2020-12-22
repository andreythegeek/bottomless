module TOML.Document (Document, create) where

import TOML.Parser (AST)

type Document = AST

create :: AST -> Document
create syntaxTree = document where document = syntaxTree
