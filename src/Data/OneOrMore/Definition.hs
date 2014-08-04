{-# LANGUAGE LambdaCase, OverloadedLists, TypeFamilies #-}
module Data.OneOrMore.Definition where

import Prelude (($), (.), error, Functor(..), Show, Eq)
import GHC.Exts (IsList(..))
import Control.Applicative
import Data.Foldable (Foldable(..))
import Data.Traversable (Traversable(..))

data OneOrMore a = One a
                 | More a (OneOrMore a)
                 deriving (Show, Eq)

instance IsList (OneOrMore a) where
  type Item (OneOrMore a) = a

  toList (One a) = [a]
  toList (More a rest) = a : toList rest

  fromList [] = error "Empty list"
  fromList [a] = One a
  fromList (a:as) = More a $ fromList as

instance Functor OneOrMore where
  fmap f (One x) = One (f x)
  fmap f (More x xs) = More (f x) $ fmap f xs

instance Foldable OneOrMore where
  foldr a b = foldr a b . toList

instance Applicative OneOrMore where
  pure = One
  functions <*> args = fromList [f x | f <- toList functions, x <- toList args]

instance Traversable OneOrMore where
  {-# INLINE traverse #-}
  traverse f (One x) = One <$> f x
  traverse f (More x xs) = More <$> f x <*> traverse f xs
