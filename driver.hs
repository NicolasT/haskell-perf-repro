module Main (main) where

import Data.List (isSuffixOf)
import qualified System.Directory as D

import qualified Data.ByteString as BS

import System.IO

import Pipes
import qualified Pipes.Prelude as P
import qualified Pipes.ByteString as PB

import Control.Concurrent.Async (mapConcurrently)

outputDir = "data"
rawExt = ".xml"

processFileContent :: Monad m => Producer BS.ByteString m () -> m Int
processFileContent p = P.sum (p >-> P.map BS.length)

getBugs :: IO [Int]
getBugs = do
        files <- D.getDirectoryContents outputDir
        let xmlFiles = map (\n -> outputDir ++ "/" ++ n) $
                       filter (isSuffixOf rawExt) files
            handle n = withFile n ReadMode (runEffect . processFileContent . PB.fromHandle)
        mapConcurrently handle xmlFiles

main :: IO ()
main = do
	x <- getBugs
	putStrLn (show x)
