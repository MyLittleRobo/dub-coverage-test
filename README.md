This demonstrates unexpected behavior with coverage tests running via dub.

## See what happens

There're two libraries: **dependency** and **dependent**. The second depends on the first. To do locally run:

    dub add-local dependency 1.0.0

Go to dependency and run coverage test:

    dub test -b unittest-cov

The created file (*source-dependency.lst*) should report 100% coverage. That's great!

Go to dependent and run coverage test on it:

    dub test -b unittest-cov

This time two files should be created: source-dependent.lst and ..-dependency-source-dependency.lst.
So as you see dub runs tests for the dependency too. 

Ok, open *..-dependency-source-dependency.lst.* it still should have 100%, right? 
It's the same module, and function is ran with same template parameter (string) after all.
Aaaand we see many zeros, like if function was not called at all. Note how unittest has 1 call per each line though. Some magic.

## Why does it happen

I'm not sure. Probably because both dependency and dependent instantiate template function, and they appear to be different for each unittest.

## Why is it bad

1. It's unexpected and weird.
2. It seems to affect results reported by doveralls to coveralls.io, so you can't have this cool 100% coverage badge on your repo.

I can ignore the 1. After all we usually look only at the reports for current library, not dependencies.
But regarding 2 we probably need doveralls not to include tests of dependencies in the result.

