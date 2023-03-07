## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive lists of the optimisers, their various arguments that can be tweaked, the default configurations for these arguments, and the outputs.

I have attempted to make such lists for GenSA and DEoptim to start with:

## GenSA

The documentation does not include default values for all the parameters, so they have been taken from the source code.

### GenSA controls

| Argument | Type | Description                    | Optimiser agnostic? | Default|
| :------: | :-----: | :---------                 | :--- | :-- |
| maxit  | Integer     | Maximum no. of iterations          | No | 5000 |
| threshold.stop | Numeric | Expected objective function value to be reached  | Yes | NULL |
| nb.stop.improvement | Integer | The program will stop when there is no any improvement in nb.stop.improvement steps.| No | 1e6| 
| smooth | Logical | whether objective function is smooth, or differentiable almost everywhere in the region of par | Yes? | TRUE | 
| max.call | Integer | Maximum number of function calls made by algorithm | No | 1e7 |
| max.time | Numeric | Maximum time for which algorithm runs | No | NULL |
| temperature | Numeric | controls probability of accepting worse solutions during the search process | No | 5230 | 
| visiting_param | Numeric | Parameter for visiting distribution | No | 2.62 |
| acceptance.param | Numeric | Parameter for acceptance distribution | No | -5.0 |
| verbose | Logical | Whether printing of progress should occur at each iteration| Yes | FALSE |
| simple.function | Logical | Whether objective function has only a few local minima. | Yes | FALSE |
| trace.mat | Logical | Whether trace matrix should be available in the returned value | Yes | TRUE |
| seed | integer | Negative integer value that can be set to initialize the internal random generator | Yes | - 100377|

### GenSA outputs

|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| value  | Numeric           | function value at found optimum          |
| par | Numeric vector | Best set of parameters |
| count | Numeric | No. of calls of obj function during optimisation |
| trace.mat | Numeric matrix | history matrix |




### DEoptim controls

| Argument | StochOptim analogue | Description                        |
| :------: | :-----------------: | :---------                    |
| itermax  | max.iter               | Maximum no. of iterations          |
| VTR | threshold.stop | Expected objective function value to be reached  |
| NP  |  | number of population members |
| initialpop | | an initial sample of starting points |
| trace | verbose | whether printing of progress occurs at each iteration |
We can instead choose to have one central wrapper that takes the user command and in turn sends it to optimiser specific subwrappers.

In the optimx package, the optimr() function is structured as a self contained wrapper, which makes for a single function running for >1000 LOC and having multiple points of failure, which would make debugging tougher.








