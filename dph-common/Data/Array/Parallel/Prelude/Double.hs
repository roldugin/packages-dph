{-# LANGUAGE ParallelArrays #-}
{-# OPTIONS_GHC -fvectorise #-}
  -- NB: Cannot use any parallel array syntax except the type constructor

module Data.Array.Parallel.Prelude.Double (
  Double,
  
  -- Ord
  (==), (/=), (<), (<=), (>), (>=), min, max,

  minimumP, maximumP, minIndexP, maxIndexP,

  -- Num
  (+), (-), (*), negate, abs,

  sumP, productP,

  -- Fractional
  (/), recip,

  -- Floating
  pi, exp, sqrt, log, (**), logBase,
  sin, tan, cos, asin, atan, acos,
  sinh, tanh, cosh, asinh, atanh, acosh,

  -- RealFrac and similar
  fromInt,

  truncate, round, ceiling, floor,
) where

import Data.Array.Parallel.VectDepend ()  -- see Note [Vectoriser dependencies] in the same module

import Data.Array.Parallel.PArr
import Data.Array.Parallel.Lifted.Scalar
import Data.Array.Parallel.Lifted.Closure

import Prelude (Double, Int, Bool)
import qualified Prelude as P

infixr 8 **
infixl 7 *, /
infixl 6 +, -
infix 4 ==, /=, <, <=, >, >=

(==), (/=), (<), (<=), (>), (>=) :: Double -> Double -> Bool
(==) = (P.==)
{-# VECTORISE SCALAR (==) #-}
(/=) = (P./=)
{-# VECTORISE SCALAR (/=) #-}
(<=) = (P.<=)
{-# VECTORISE SCALAR (<=) #-}
(<)  = (P.<)
{-# VECTORISE SCALAR (<) #-}
(>=) = (P.>=)
{-# VECTORISE SCALAR (>=) #-}
(>)  = (P.>)
{-# VECTORISE SCALAR (>) #-}

min, max :: Double -> Double -> Double
min = P.min
{-# VECTORISE SCALAR min #-}
max = P.max
{-# VECTORISE SCALAR max #-}

minimumP, maximumP :: [:Double:] -> Double
{-# NOINLINE minimumP #-}
minimumP a = a `indexPArr` 0
{-# VECTORISE minimumP
  = closure1 (scalar_fold1 P.min) (scalar_fold1s P.min) :: PArray Double :-> Double #-}
{-# NOINLINE maximumP #-}
maximumP a = a `indexPArr` 0
{-# VECTORISE maximumP
  = closure1 (scalar_fold1 P.max) (scalar_fold1s P.max) :: PArray Double :-> Double #-}

minIndexP :: [:Double:] -> Int
{-# NOINLINE minIndexP #-}
minIndexP _ = 0   -- FIXME: add proper implementation
{-# VECTORISE minIndexP = minIndexPA #-}

minIndexPA :: PArray Double :-> Int
{-# INLINE minIndexPA #-}
minIndexPA = closure1 (scalar_fold1Index min') (scalar_fold1sIndex min')
{-# NOVECTORISE minIndexPA #-}

min' (i,x) (j,y) | x P.<= y    = (i,x)
                 | P.otherwise = (j,y)
{-# NOVECTORISE min' #-}

maxIndexP :: [:Double:] -> Int
{-# NOINLINE maxIndexP #-}
maxIndexP _ = 0   -- FIXME: add proper implementation
{-# VECTORISE maxIndexP = maxIndexPA #-}

maxIndexPA :: PArray Double :-> Int
{-# INLINE maxIndexPA #-}
maxIndexPA = closure1 (scalar_fold1Index max') (scalar_fold1sIndex max')
{-# NOVECTORISE maxIndexPA #-}

max' (i,x) (j,y) | x P.>= y    = (i,x)
                 | P.otherwise = (j,y)
{-# NOVECTORISE max' #-}

(+), (-), (*) :: Double -> Double -> Double
(+) = (P.+)
{-# VECTORISE SCALAR (+) #-}
(-) = (P.-)
{-# VECTORISE SCALAR (-) #-}
(*) = (P.*)
{-# VECTORISE SCALAR (*) #-}

negate, abs :: Double -> Double
negate = P.negate
{-# VECTORISE SCALAR negate #-}
abs = P.abs
{-# VECTORISE SCALAR abs #-}

sumP, productP :: [:Double:] -> Double
{-# NOINLINE sumP #-}
sumP a = a `indexPArr` 0
{-# VECTORISE sumP 
  = closure1 (scalar_fold (+) 0) (scalar_folds (+) 0) :: PArray Double :-> Double #-}
{-# NOINLINE productP #-}
productP a = a `indexPArr` 0
{-# VECTORISE productP 
  = closure1 (scalar_fold (*) 1) (scalar_folds (*) 1) :: PArray Double :-> Double #-}

(/) :: Double -> Double -> Double
(/) = (P./)
{-# VECTORISE SCALAR (/) #-}

recip :: Double -> Double
recip = P.recip
{-# VECTORISE SCALAR recip #-}

pi :: Double
pi = P.pi
{-# NOVECTORISE pi #-}

exp, sqrt, log, sin, tan, cos, asin, atan, acos, sinh, tanh, cosh,
  asinh, atanh, acosh :: Double -> Double
exp = P.exp
{-# VECTORISE SCALAR exp #-}
sqrt = P.sqrt
{-# VECTORISE SCALAR sqrt #-}
log = P.log
{-# VECTORISE SCALAR log #-}
sin = P.sin
{-# VECTORISE SCALAR sin #-}
tan = P.tan
{-# VECTORISE SCALAR tan #-}
cos = P.cos
{-# VECTORISE SCALAR cos #-}
asin = P.asin
{-# VECTORISE SCALAR asin #-}
atan = P.atan
{-# VECTORISE SCALAR atan #-}
acos = P.acos
{-# VECTORISE SCALAR acos #-}
sinh = P.sinh
{-# VECTORISE SCALAR sinh #-}
tanh = P.tanh
{-# VECTORISE SCALAR tanh #-}
cosh = P.cosh
{-# VECTORISE SCALAR cosh #-}
asinh = P.asinh
{-# VECTORISE SCALAR asinh #-}
atanh = P.atanh
{-# VECTORISE SCALAR atanh #-}
acosh = P.acosh
{-# VECTORISE SCALAR acosh #-}

(**), logBase :: Double -> Double -> Double
(**) = (P.**)
{-# VECTORISE SCALAR (**) #-}
logBase = P.logBase
{-# VECTORISE SCALAR logBase #-}

fromInt :: Int -> Double
fromInt = P.fromIntegral
{-# VECTORISE SCALAR fromInt #-}

truncate, round, ceiling, floor :: Double -> Int
truncate = P.truncate
{-# VECTORISE SCALAR truncate #-}
round = P.round
{-# VECTORISE SCALAR round #-}
ceiling = P.ceiling
{-# VECTORISE SCALAR ceiling #-}
floor = P.floor
{-# VECTORISE SCALAR floor #-}
