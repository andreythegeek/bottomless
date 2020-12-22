module TOML (Source, Document, parse) where

import TOML.Parser (Source, scan)
import TOML.Document (Document, create)

parse :: Source -> Document
parse = create . scan 
