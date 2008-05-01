{-# OPTIONS -fvectorise #-}
module Data.Array.Parallel.Prelude.Int (
  P.Int, (+), (-), (*), div, mod, intSquareRoot,
  (==), (/=), (<=), (<), (>=), (>)
) where

import Data.Array.Parallel.Prelude.Base
import Data.Array.Parallel.Prelude.Base.Int

import qualified Prelude as P
import Prelude (Int)

infixl 7 *
infixl 6 +, -
infix 4 ==, /=, <, <=, >, >=

(==), (/=), (<), (<=), (>), (>=) :: Int -> Int -> P.Bool
(==) = eq
(/=) = neq
(<) = lt
(<=) = le
(>) = gt
(>=) = ge

(*) :: Int -> Int -> Int
(*) = mult

(+) :: Int -> Int -> Int
(+) = plus

(-) :: Int -> Int -> Int
(-) = minus

div:: Int -> Int -> Int
div = intDiv

mod:: Int -> Int -> Int
mod = intMod
