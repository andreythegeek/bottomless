module TOML.Scanner (Token, scan) where

type Token = String

scan :: String -> [Token] 
scan source 
    | null source = []
    | otherwise   = scan rest
  where
    rest = tail source
