module Main (main) where

import Data.List (isSuffixOf)
import Control.Monad
import qualified System.Directory as D

import qualified Data.ByteString.Lazy as BSL

outputDir = "data"
rawExt = ".xml"

processFileContent :: BSL.ByteString -> Int
processFileContent = fromIntegral . BSL.length

getBugs :: IO [Int]
getBugs = do
        files <- D.getDirectoryContents outputDir
        let xmlFiles = map (\n -> outputDir ++ "/" ++ n) $
                       filter (isSuffixOf rawExt) files
        forM xmlFiles $ \n -> do
            str <- BSL.readFile n
            let l = processFileContent str
            l `seq` return l

main :: IO ()
main = do
	x <- getBugs
	putStrLn (show x)


