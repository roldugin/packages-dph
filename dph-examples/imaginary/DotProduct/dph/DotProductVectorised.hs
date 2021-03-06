{-# LANGUAGE ParallelArrays #-}
{-# OPTIONS -fvectorise #-}
module DotProductVectorised ( dotPA ) where

import Data.Array.Parallel
import Data.Array.Parallel.Prelude.Double as D

import qualified Prelude

dotPA :: PArray Double -> PArray Double -> Double
{-# NOINLINE dotPA #-}
dotPA v w = dotp' (fromPArrayP v) (fromPArrayP w)

dotp' :: [:Double:] -> [:Double:] -> Double
dotp' v w = D.sumP (zipWithP (*) v w)
