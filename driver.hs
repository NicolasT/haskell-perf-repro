import qualified System.Directory as D
import qualified System.IO.Unsafe as SIU

outputDir = "data"
htmlDir = "html"
rawExt = ".xml"


mapMI :: (a -> IO b) -> [a] -> IO [b]
mapMI _ [] = return [] -- You can play with this case a bit. This will open a file for the head of the list,
-- and then when each subsequent cons cell is inspected. You could probably
-- interleave 'f x' as well.
mapMI f (x:xs) = do y <- SIU.unsafeInterleaveIO (f x) ; ys <- SIU.unsafeInterleaveIO (mapMI f xs) ; return (y:ys)

processFileContent = length


getBugs = do
        files <- D.getDirectoryContents outputDir
        let xmlFiles = map (\n -> outputDir ++ "/" ++ n) $
                       filter (\n -> (reverse . take 4 . reverse) n == rawExt) files
        mapMI (\f -> do {str <- readFile f; return (processFileContent str); }) (xmlFiles)


main = do
	x <- getBugs
	putStrLn (show x)


