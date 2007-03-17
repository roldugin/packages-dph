-----------------------------------------------------------------------------
-- |
-- Module      : Data.Array.Parallel.Base.Rebox
-- Copyright   : (c) [2006,2007] Roman Leshchinskiy
-- License     : see libraries/ndp/LICENSE
-- 
-- Maintainer  : Roman Leshchinskiy <rl@cse.unsw.edu.au>
-- Stability   : internal
-- Portability : non-portable (existentials)
--
-- Description ---------------------------------------------------------------
--
-- Reboxing support for SpecConstr; should go away eventually.
--


module Data.Array.Parallel.Base.Rebox (
  Rebox(..), Box(..)
) where

import Data.Array.Parallel.Base.Hyperstrict

import GHC.Base   (Int(..))
import GHC.Float  (Float(..), Double(..))

class Rebox a where
  rebox :: a -> a
  dseq  :: a -> b -> b

instance Rebox () where
  {-# INLINE [0] rebox #-}
  rebox () = ()

  {-# INLINE [0] dseq #-}
  dseq = seq

instance Rebox Bool where
  {-# INLINE [0] rebox #-}
  rebox True = True
  rebox False = False

  {-# INLINE [0] dseq #-}
  dseq = seq

instance Rebox Int where
  {-# INLINE [0] rebox #-}
  rebox (I# i#) = id (I# i#)

  {-# INLINE [0] dseq #-}
  dseq = seq

instance Rebox Float where
  {-# INLINE [0] rebox #-}
  rebox (F# f#) = F# f#

  {-# INLINE [0] dseq #-}
  dseq = seq

instance Rebox Double where
  {-# INLINE [0] rebox #-}
  rebox (D# d#) = D# d#

  {-# INLINE [0] dseq #-}
  dseq = seq

instance (Rebox a, Rebox b) => Rebox (a :*: b) where
  {-# INLINE [0] rebox #-}
  rebox (x :*: y) = rebox x :*: rebox y

  {-# INLINE [0] dseq #-}
  dseq (x :*: y) z = dseq x (dseq y z)

instance Rebox a => Rebox (MaybeS a) where
  {-# INLINE [0] rebox #-}
  rebox NothingS  = NothingS
  rebox (JustS x) = JustS (rebox x)

  {-# INLINE [0] dseq #-}
  dseq NothingS  y = y
  dseq (JustS x) y = dseq x y

newtype Box a = Box a

instance Rebox (Box a) where
  {-# INLINE [0] rebox #-}
  rebox (Box a) = Box a

  {-# INLINE [0] dseq #-}
  dseq (Box a) x = x

instance Rebox (Lazy a) where
  {-# INLINE [0] rebox #-}
  rebox (Lazy a) = Lazy a

  {-# INLINE [0] dseq #-}
  dseq (Lazy a) x = x
