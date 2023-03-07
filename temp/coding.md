## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive lists of the optimisers, their various arguments that can be tweaked, the default configurations for these arguments, and the outputs.

I have attempted to make such lists for GenSA and DEoptim to start with:

## GenSA

The documentation does not include default values for all the parameters, so they have been taken from the source code.

### GenSA controls

| Argument | Type  | Optimiser agnostic | Default| Description |
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
| seed | integer | Yes | -100377| Negative integer value that can be set to initialize the internal random generator | 

### GenSA outputs

|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| value  | Numeric   | function value at found optimum          |
| par | Numeric vector | Best set of parameters |
| count | Numeric | No. of calls of obj function during optimisation |
| trace.mat | Numeric matrix | history matrix |


### DEoptim controls

| Argument | Type  | Optimiser agnostic | Default| Description |
| :------: | :-------: | :-------: | :----: | :--- |
| VTR | Numeric | Yes | -Inf | Expected objective function value to be reached  |
| strategy | Numeric | No | 2 | defines the Differential Evolution strategy used in the optimization procedure |
| bs | Logical | No | FALSE | F: standard trial vs. target selection T: best of parent and child selection |
| NP | Integer | No | NA | number of population members |
| itermax | Integer  | No | 200 | Maximum no. of iterations     |
| CR | Numeric  \[0, 1] | No | 0.5 | Crossover probability |
| F | Numeric \[0, 2] | 0.8 | differential weighting factor |
| initialpop | Numeric matrix | No | NULL | an initial sample of starting points |
| storepopfrom | Integer | No | itermax + 1 | from which generation should the following intermediate populations be stored in memory |
| storepopfreq | Integer | No | 1 |  frequency with which populations are stored |
| p | Numeric (0, 1] | No | - | When strategy = 6, the top (100 * p)% best solutions are used in the mutation |
| c | Numeric (0, 1] | No | - | Controls the speed of the crossover adaptation|
| reltol | Numeric (0,1] | No | sqrt(.Machine$double.eps) ~ 1e-8 | relative convergence tolerance | 
| steptol | Integer | No | itermax | No. of steps after which reltol is checked |
| trace | verbose | whether printing of progress occurs at each iteration |

We can instead choose to have one central wrapper that takes the user command and in turn sends it to optimiser specific subwrappers.

In the optimx package, the optimr() function is structured as a self contained wrapper, which makes for a single function running for >1000 LOC and having multiple points of failure, which would make debugging tougher.








