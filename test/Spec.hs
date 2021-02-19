import TOML (parse)

main :: IO ()
main = print $ parse $ unlines [ "# just a simple one-line comment"
                               , ""
                               , "answer = 42" ]
