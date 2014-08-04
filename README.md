# OneOrMore

In many cases, a list type is desired, but it is expected that the list will not be empty. Rather than throwing runtime errors when empty lists are encountered, we can use Haskell's type system to create a type which is guaranteed to have at least one element:

```haskell
data OneOrMore a = One a
                 | More a (OneOrMore a)
```

`OneOrMore`s are intended to be incredibly simple to use, and there are no dependencies outside of `base`. To use it, run `cabal install oneormore`, and then put `import Data.OneOrMore` in your source. That's it!

We have included a few useful type class instances for `OneOrMore`, such as `Functor`, `Applicative`, `Foldable` and `Traversable`. We also include an instance of `IsList`, so that `OneOrMore`s can be written as list literals:

```haskell
>>> :set -XOverloadedLists
>>> [1,2,3] :: OneOrMore Int
More 1 (More 2 (One 3))
```

Interestingly, we *cannot* make an instance of `Monoid`, because there is no sensible representation of `mempty`.

The `Operators` module has some useful functions. Notably, `head` and `last` are always safe (`tail` and `init` are not). Many of whose names are common to `Prelude` functions on lists, so it might be desirable to import `qualified`.