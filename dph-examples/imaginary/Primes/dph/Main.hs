
import PrimesVect
import Timing
import Randomish
import System.Environment
import Data.Vector.Unboxed		(Vector)
import Data.Array.Parallel.Prelude	as P
import Data.Array.Parallel.PArray	as P
import qualified Data.Vector.Unboxed	as V
import Data.Maybe

main :: IO ()
main 
 = do	args	<- getArgs
	case args of
	  [alg, len]	-> run alg (read len) 
	  _		-> usage

-- | Run the benchmark
run :: String -> Int -> IO ()
run "dph" len
 = do	(vPrimes, tElapsed)
		<- time 
		$  let 	vPrimes	= primesPA len
		   in	vPrimes `seq` return vPrimes
					
	-- Print how long it took.
	putStr $ prettyTime tElapsed
		
run _ _	= usage


-- | Command line usage information.
usage :: IO ()
usage	
 = putStr $ unlines
	[ "Usage: primes alg <length>"
	, "       alg one of " ++ show ["dph", "vector"] ]

