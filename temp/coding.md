## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive lists of the optimisers, their various arguments that can be tweaked, the default configurations for these arguments, and the outputs.

I have attempted to make such lists for GenSA and DEoptim to start with:

## GenSA

The documentation does not include default values for all the parameters, so they have been taken from the source code.

### GenSA controls

| Argument | Type  | Optimiser agnostic? | Default| Description |
| :------: | :-----: | :---------                 | :--- | :-- |
| maxit  | Integer  | No | 5000 | | Maximum no. of iterations  |
| threshold.stop | Numeric | Yes | NULL | Expected objective function value to be reached |
| nb.stop.improvement | Integer |  No | 1e6|  The program will stop when there is no any improvement in nb.stop.improvement steps.|
| smooth | Logical | Yes | TRUE | whether objective function is smooth, or differentiable almost everywhere in the region of par |  
| max.call | Integer | No | 1e7 | Maximum number of function calls made by algorithm | 
| max.time | Numeric | No | NULL | Maximum time for which algorithm runs | 
| temperature | Numeric | No | 5230 | controls probability of accepting worse solutions during the search process | 
| visiting_param | Numeric | No | 2.62 | Parameter for visiting distribution | 
| acceptance.param | Numeric | No | -5.0 | Parameter for acceptance distribution | 
| verbose | Logical | Yes | FALSE | Whether printing of progress should occur at each iteration| 
| simple.function | Logical | Yes | FALSE | Whether objective function has only a few local minima. | 
| trace.mat | Logical | Yes | TRUE | Whether trace matrix should be available in the returned value | 
| seed | integer | Yes | - 100377| Negative integer value that can be set to initialize the internal random generator | 

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








