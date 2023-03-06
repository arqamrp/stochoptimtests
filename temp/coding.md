## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive list of the optimisers, their various arguments that can be tweaked, and the default configurations for these arguments.



In the optimx package, the optimr() function is structured as a self contained wrapper, which makes for a function running for >1000 LOC and having multiple points of failure, which would make debugging tougher.
We can instead choose to have one central wrapper that takes the user command and in turn sends it to optimiser specific subwrappers.


### DEoptim controls

| Argument | StochOptim analogue | Description |
| :------: | :-----------------: | :---------: |
| itermax  | maxit               | maximum no. of iterations|
