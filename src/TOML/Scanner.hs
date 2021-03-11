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

data Mask = Mask [State] Scope [Token]

type Transition = Mask -> Char -> Mask

scan :: String -> [Token]
scan = walk event 
  where
    event = Mask [Idle] "" []

walk :: Mask -> String -> [Token]
walk mask []             = terminate mask
walk mask [input]        = terminate $ process mask input
walk mask (input : rest) = walk (process mask input) rest

process :: Transition 
process mask input = 
  case state of
    Idle    -> fromIdle mask input
    Comment -> fromComment mask input
  where
    state = last history
    (Mask history _ _) = mask
  
fromIdle :: Transition
fromIdle mask input = mask

fromComment :: Transition 
fromComment mask input = mask

terminate :: Mask -> [Token]
terminate (Mask _ _ stream) = stream
