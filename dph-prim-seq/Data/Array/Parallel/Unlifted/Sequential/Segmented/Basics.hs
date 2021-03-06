-----------------------------------------------------------------------------
-- |
-- Module      : Data.Array.Parallel.Unlifted.Sequential.Segmented.Basics
-- Copyright   : (c) [2001..2002] Manuel M T Chakravarty & Gabriele Keller
--		 (c) 2006         Manuel M T Chakravarty & Roman Leshchinskiy
-- License     : see libraries/ndp/LICENSE
-- 
-- Maintainer  : Roman Leshchinskiy <rl@cse.unsw.edu.au>
-- Stability   : internal
-- Portability : portable
--
-- Description ---------------------------------------------------------------
--
--  Basic segmented operations on unlifted arrays.
--
-- Todo ----------------------------------------------------------------------
--

{-# LANGUAGE CPP #-}

#include "fusion-phases.h"

module Data.Array.Parallel.Unlifted.Sequential.Segmented.Basics (
  replicateSU, replicateRSU, appendSU, indicesSU, indicesSU'
) where

import Data.Array.Parallel.Stream
import Data.Array.Parallel.Unlifted.Sequential.Vector
import Data.Array.Parallel.Unlifted.Sequential.Segmented.USegd

import qualified Data.Vector.Fusion.Stream as S

replicateSU :: Unbox a => USegd -> Vector a -> Vector a
{-# INLINE_U replicateSU #-}
replicateSU segd xs = unstream
                     (replicateEachS (elementsUSegd segd)
                     (S.zip (stream (lengthsUSegd segd)) (stream xs)))

replicateRSU :: Unbox a => Int -> Vector a -> Vector a
{-# INLINE_U replicateRSU #-}
replicateRSU n xs = unstream
                  . replicateEachRS n
                  $ stream xs
                  

appendSU :: Unbox a => USegd -> Vector a -> USegd -> Vector a -> Vector a
{-# INLINE_U appendSU #-}
appendSU xd xs yd ys = unstream
                     $ appendSS (stream (lengthsUSegd xd))
                                (stream xs)
                                (stream (lengthsUSegd yd))
                                (stream ys)

indicesSU' :: Int -> USegd -> Vector Int
{-# INLINE_U indicesSU' #-}
indicesSU' i segd = unstream
                  . indicesSS (elementsUSegd segd) i
                  . stream
                  $ lengthsUSegd segd

indicesSU :: USegd -> Vector Int
{-# INLINE_U indicesSU #-}
indicesSU = indicesSU' 0

