module Data.OneOrMore.Operators where

import Prelude (($), error, Int, Num(..))
import Data.OneOrMore.Definition

(++) :: OneOrMore a -> OneOrMore a -> OneOrMore a
One x ++ ys = More x ys
More x xs ++ ys = More x $ xs ++ ys

length :: OneOrMore a -> Int
length (One _) = 1
length (More _ oom) = 1 + length oom

reverse :: OneOrMore a -> OneOrMore a
reverse (One x) = One x
reverse (More x xs) = go (One x) xs where
  go ys (One y) = More y ys
  go ys (More y ys') = go (More y ys) ys'

head :: OneOrMore a -> a
head (One a) = a
head (More a _) = a

last :: OneOrMore a -> a
last (One a) = a
last (More _ as) = last as

tail :: OneOrMore a -> OneOrMore a
tail (One _) = error "No tail"
tail (More _ as) = as

init :: OneOrMore a -> OneOrMore a
init (One _) = error "No initial"
init (More a as) = reverse $ go (One a) as where
  go as (One _) = as
  go as (More a as') = go (More a as) as'