module TOML.Scanner (Constant(..), Token(..), scan) where

data Constant = AnyInt Int | AnyString String deriving Show

data Token = Key String
           | Syntax Char
           | Payload Constant
           deriving Show

data State = Idle 
           | Comment
           | CommentInput
           deriving (Show, Eq)

type Scope = String

data Mask = Mask State Scope [Token]

scan :: String -> [Token] 
scan source = walk source $ Mask state scope result 
  where
    state  = Idle
    scope  = ""
    result = []

walk :: String -> Mask -> [Token]
walk [] mask             = terminate mask
walk [input] mask        = terminate $ process input mask
walk (input : rest) mask = walk rest $ process input mask

terminate :: Mask -> [Token]
terminate (Mask state scope result) =
  case state of
    Idle         -> result 
    Comment      -> result
    CommentInput -> result 

process :: Char -> Mask -> Mask
process input mask =
  case input of
    '#'  -> processComment mask 
    '='  -> processAny mask
    ' '  -> processSpace mask
    '"'  -> processAny mask
    '\'' -> processAny mask
    '\\' -> processAny mask
    '\n' -> processLineEnd mask
    _    -> processAny mask 

processComment :: Mask -> Mask
processComment (Mask state scope result) 
  | state == Idle = Mask Comment scope result
  | otherwise = Mask state scope result

processCommentInput :: Mask -> Mask
processCommentInput mask = mask

processSpace :: Mask -> Mask
processSpace mask = mask

processLineEnd :: Mask -> Mask
processLineEnd mask = mask

processAny :: Mask -> Mask
processAny mask = mask
