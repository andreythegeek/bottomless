module TOML.Parser.TokenStream (Source, Token, TokenStream, translate) where

import Data.Char (isAlpha)

type Source = String

data Token = Key | Assignment | Input deriving (Show, Eq)

type TokenStream = [Token]

data State = Waiting | ReadKey | ReadInput deriving (Show, Eq)

type Accumulator = Source

type Mask = (State, Accumulator, TokenStream)

type CurrentInput = Char 

type Event = (CurrentInput, Mask)

translate :: Source -> TokenStream
translate source = walk source emptyMask

walk :: Source -> Mask -> TokenStream
walk input mask =
    if null input then
        result mask
    else
        walk rest $ handle event 
            where current = head input
                  rest    = tail input
                  event   = (current, mask)

mask :: State -> Accumulator -> TokenStream -> Mask
mask state accumulator tokenStream = (state, accumulator, tokenStream)

emptyMask :: Mask
emptyMask = mask state accumulator tokenStream
    where state       = Waiting
          accumulator = ""
          tokenStream = []

result :: Mask -> TokenStream
result (_, _, result) = result

handle :: Event -> Mask
handle event =
    case input of
        '#' -> takeComment event
        '=' -> takeAssignment event
        '"' -> takeString event
        '[' -> mask 
        ']' -> mask
        '.' -> mask
        '{' -> mask
        '}' -> mask
        ' ' -> takeSpace event 
        _   -> takeAny event
    where (input, mask) = event

takeComment :: Event -> Mask
takeComment (_, mask) = mask

takeAssignment :: Event -> Mask
takeAssignment (_, (_, _, tokenStream)) =
    mask state accumulator result
        where state       = Waiting
              accumulator = ""
              result      = tokenStream ++ [Assignment]

takeString :: Event -> Mask
takeString (_, mask) = mask

takeSpace :: Event -> Mask
takeSpace (_, mask) =
    case state of
        Waiting -> mask
        ReadKey -> (Waiting, "", tokenStream ++ [Key])
    where (state, _, tokenStream) = mask

takeAny :: Event -> Mask
takeAny (input, (state, accumulator, tokenStream)) =
    case state of
        Waiting -> (ReadKey, accumulator ++ [input], tokenStream)
        ReadKey -> (ReadKey, accumulator ++ [input], tokenStream)
