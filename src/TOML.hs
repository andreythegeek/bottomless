module TOML (Document, parse) where

import TOML.Scanner (scan)
import TOML.Parser (translate)
import TOML.Document (Document, create)

parse :: String -> Document
parse = create . translate .scan
