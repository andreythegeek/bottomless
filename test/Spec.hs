import TOML (parse)

main :: IO ()
main = print $ parse "key = value"
