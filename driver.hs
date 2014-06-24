module Main (main) where

import Control.Monad
import qualified System.Directory as D

outputDir = "data"
rawExt = ".xml"

processFileContent :: [a] -> Int
processFileContent = length

getBugs :: IO [Int]
getBugs = do
        files <- D.getDirectoryContents outputDir
        let xmlFiles = map (\n -> outputDir ++ "/" ++ n) $
                       filter (\n -> (reverse . take 4 . reverse) n == rawExt) files
        forM xmlFiles $ \n -> do
            str <- readFile n
            let l = processFileContent str
            l `seq` return l

main :: IO ()
main = do
	x <- getBugs
	putStrLn (show x)


