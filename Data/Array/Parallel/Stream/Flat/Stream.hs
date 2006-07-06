-----------------------------------------------------------------------------
-- |
-- Module      : Data.Array.Parallel.Stream.Flat.Stream
-- Copyright   : (c) 2006 Roman Leshchinskiy
-- License     : see libraries/base/LICENSE
-- 
-- Maintainer  : Roman Leshchinskiy <rl@cse.unsw.edu.au>
-- Stability   : internal
-- Portability : non-portable (existentials)
--
-- Description ---------------------------------------------------------------
--
-- Basic types for stream-based fusion
--

module Data.Array.Parallel.Stream.Flat.Stream (
  Step(..), Stream(..)
) where

data Step s a = Done
              | Skip     !s
              | Yield !a !s

instance Functor (Step s) where
  fmap f Done        = Done
  fmap f (Skip s)    = Skip s
  fmap f (Yield x s) = Yield (f x) s

data Stream a = forall s. Stream (s -> Step s a) !s Int
