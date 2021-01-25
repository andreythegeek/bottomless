module TOML.Scanner (Constant(..), Token(..), scan) where

data Constant = AnyInt Int | AnyString String deriving Show -- FIXME Move to place where rules applied.

-- TODO Consider using pattern synonyms for syntax parts and empty strings.

data Token = Key String | Syntax Char | Payload Constant deriving Show

scan :: String -> [Token] 
scan source 
    | null source = []
    | otherwise   = scan rest
  where
    (current : rest) = source 
