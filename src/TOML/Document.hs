module TOML.Document (Document, render) where

import TOML.Parser (SyntaxTree)

type Document = SyntaxTree

render :: SyntaxTree -> Document
render syntaxTree = document where document = syntaxTree
