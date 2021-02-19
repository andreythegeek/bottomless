module TOML.Scanner (Constant(..), Token(..), scan) where

data Constant = AnyInt Int | AnyString String deriving Show

data Token = Comment String | Key String | Syntax Char | Payload Constant deriving Show

data State = Idle 

data Mask = Mask State String [Token]

scan :: String -> [Token] 
scan source = walk source $ Mask state accumulator result 
  where
    state       = Idle 
    accumulator = ""
    result      = []

walk :: String -> Mask -> [Token]
walk [] mask             = terminate mask
walk [input] mask        = terminate $ process input mask
walk (input : rest) mask = walk rest $ process input mask

process :: Char -> Mask -> Mask
process input mask = mask

move :: State -> Mask -> Mask
move state (Mask _ _ result) = Mask state accumulator result
  where
    accumulator = ""

terminate :: Mask -> [Token]
terminate mask = result 
  where
    (Mask _ _ result) = mask
