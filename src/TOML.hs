module TOML (Source, Document, parse) where

import TOML.Parser (Source, run)
import TOML.Document (Document, render)

parse :: Source -> Document
parse = render . run 
