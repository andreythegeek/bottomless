import TOML (parse)

main :: IO ()
main = print $ parse "answer = 42"
