-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Array.Parallel.Prelude
-- Copyright   :  (c) [2006..2011] Data Parallel Haskell team
-- License     :  see libraries/dph/LICENSE
-- 
-- Maintainer  :  cvs-ghc@haskell.org
-- Stability   :  experimental
-- Portability :  non-portable (GHC Extensions)
--
-- This module (as well as the type-specific modules 'Data.Array.Parallel.Prelude.*') are a
-- temporary kludge needed as DPH programs cannot directly use the (non-vectorised) functions from
-- the standard Prelude.  It also exports some conversion helpers.
--
-- /This module should not be explicitly imported in user code anymore./  User code should only
-- import 'Data.Array.Parallel' and, until the vectoriser supports type classes, the type-specific
-- modules 'Data.Array.Parallel.Prelude.*'.

module Data.Array.Parallel.Prelude (
  module Data.Array.Parallel.Prelude.Bool,
  module Data.Array.Parallel.Prelude.Tuple,

  PArray, Scalar(..), 
  toUArrPA, 
  fromUArrPA', fromUArrPA_2', fromUArrPA_3, fromUArrPA_3',
  nestUSegdPA'
) where

import Data.Array.Parallel.Prelude.Bool
import Data.Array.Parallel.Prelude.Tuple
import Data.Array.Parallel.Lifted.PArray
-- import Data.Array.Parallel.PArray.PReprInstances        ()
-- import Data.Array.Parallel.PArray.PDataInstances        ()
import Data.Array.Parallel.Lifted.Scalar
