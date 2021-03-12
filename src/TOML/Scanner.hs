module TOML.Scanner ( Token(..)
                    , Constant(..)
                    , scan
                    ) where

data Token = Key String
           | Operator Char
           | Payload Constant
           deriving Show

data Constant = AnyInt Int
              | AnyBool Bool
              | AnyString String
              deriving Show

data State = Idle
           | Comment
           deriving (Show, Eq)

type Scope = String
type ChangeLog = [State]
type Mask = (ChangeLog, Scope, [Token])

type Transition = Mask -> Char -> Mask

scan :: String -> [Token]
scan = terminate . foldr process mask
  where
    mask = ([Idle], "", [])

process :: Char -> Mask -> Mask
process input mask = mask

terminate :: Mask -> [Token]
terminate (_, _, stream) = stream
