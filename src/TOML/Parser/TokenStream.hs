module TOML.Parser.TokenStream (Source, TokenStream, translate) where

type Source = String
type TokenStream = [String]

translate :: Source -> TokenStream
translate source = tokenStream where tokenStream = [source]
