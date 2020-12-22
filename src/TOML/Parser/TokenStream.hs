module TOML.Parser.TokenStream (Source, Token, Stream, translate) where

type Source = String

data Token = Key | Assign deriving (Eq, Show)

type Stream = [Token]

data State = Idle | ReadKey deriving (Show, Eq)

type Accumulator = Source

type Mask = (State, Accumulator, Stream)

type CurrentInput = Char 

type Event = (CurrentInput, Mask)

translate :: Source -> Stream 
translate source = walk source emptyMask

walk :: Source -> Mask -> Stream 
walk source mask =
    if null source then
        result mask
    else
        walk rest $ handle $ generate current mask 
            where
                current = head source 
                rest    = tail source 

emptyMask :: Mask
emptyMask = mask state accumulator stream  
    where
        state       = Idle
        accumulator = ""
        stream      = []

mask :: State -> Accumulator -> Stream-> Mask
mask state accumulator tokenStream = (state, accumulator, tokenStream)

generate :: CurrentInput -> Mask -> Event
generate input mask = (input, mask)

result :: Mask -> Stream 
result (_, _, result) = result

handle :: Event -> Mask
handle event =
    case source of
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
    where
        (source, mask) = event

takeComment :: Event -> Mask
takeComment (_, mask) = mask

takeAssignment :: Event -> Mask
takeAssignment (_, (_, _, tokenStream)) =
    mask state accumulator result
        where
            state       = Idle
            accumulator = ""
            result      = tokenStream ++ [Assign]

takeString :: Event -> Mask
takeString (_, mask) = mask

takeSpace :: Event -> Mask
takeSpace (_, mask) =
    case state of
        Idle    -> mask
        ReadKey -> (Idle, "", tokenStream ++ [Key])
    where
        (state, _, tokenStream) = mask

takeAny :: Event -> Mask
takeAny (source , (state, accumulator, tokenStream)) =
    case state of
        Idle    -> (ReadKey, accumulator ++ [source ], tokenStream)
        ReadKey -> (ReadKey, accumulator ++ [source ], tokenStream)
