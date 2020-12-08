module TOML (Input, Document, parse) where

type Input = String
type Document = String

parse :: Input -> Document
parse source = source
