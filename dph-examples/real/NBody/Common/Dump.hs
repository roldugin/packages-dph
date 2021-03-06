{-# LANGUAGE ScopedTypeVariables #-}
module Common.Dump
	(dumpWorld)
where
import Common.Body
import Common.World
import System.IO
import Data.List
import qualified Data.Vector.Unboxed	as V


-- | Dump the bodies in a world to a file.
dumpWorld :: World -> FilePath -> IO ()
dumpWorld world filePath
 = do	h	<- openFile filePath WriteMode
	mapM_ (hWriteBody h)
		$ V.toList 
		$ worldBodies world

-- | Write a single body to a file.
hWriteBody :: Handle -> Body -> IO ()
hWriteBody h ((px, py, mass), (vx, vy), (ax, ay))
 	= hPutStrLn h 
	$ concat 
	$ (  (padRc 8 ' ' $ show mass)
	  :  " " : (intersperse " " $ map (padRc 22 ' ' . show) [ px, py, vx, vy, ax, ay ]))
		

-- | Right justify a doc, padding with a given character.
padRc :: Int -> Char -> String -> String
padRc n c str
	= replicate (n - length str) c ++ str
