
import DotProductVect
import Timing
import Randomish
import System.Environment
import Data.Vector.Unboxed		(Vector)
import Data.Array.Parallel.Prelude	as P
import Data.Array.Parallel.PArray	as P
import qualified Data.Vector.Unboxed	as V


main :: IO ()
main 
 = do	args	<- getArgs
	case args of
	  [alg, len] 	-> run alg (read len) 
	  _		-> usage
	
run alg len
 = do	let vec1 = randomishDoubles len 0 1 1234
	let vec2 = randomishDoubles len 0 1 12345

	(result, tElapsed) <- runAlg alg vec1 vec2

	putStr	$ prettyTime tElapsed
	putStr	$ (take 12 $ show result) ++ "\n"

runAlg "dph" vec1 vec2 
 = do	let arr1 = fromUArrPA' vec1
	let arr2 = fromUArrPA' vec2
	arr1 `seq` arr2 `seq` return ()

	time	$ let result	= dotPA arr1 arr2
		  in  result `seq` return result

runAlg "vector" vec1 vec2
 = do	vec1 `seq` vec2 `seq` return ()

	time	$ let result	= V.sum $ V.zipWith (*) vec1 vec2
		  in  result `seq` return result
		
usage
 = putStr $ unlines
 	[ "usage: dotp <alg> <length>"
 	, "  alg one of " ++ show ["dph", "vector"] ]

