## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive lists of the optimisers, their various arguments that can be tweaked, the default configurations for these arguments, and the outputs.


I have attempted to make such lists for GenSA and DEoptim to start with:

## GenSA

### GenSA arguments

| Argument | Type  | Default| Description | Optional |
| :------ | :-----: | :---------                 | :--- | :---- |
| par | Numeric vector | NULL | Initial values for the components to be optimized | Yes |
| fn | Function | - | Function to be optimised | No |
| lower | Numeric vector | - | Lower bounds for components | No |
| upper | Numeric vector | - | Upper bounds for components | No |
| control | List | - | List with controls | Yes |

### GenSA controls
The documentation does not include default values for all the parameters, so they have been taken from the source code.

| Control | Type  | Optimiser agnostic | Default| Description |
| :------ | :-----: | :---------                 | :--- | :-- |
| maxit  | Integer  | No | 5000 | Maximum no. of iterations  |
| threshold.stop | Numeric | Yes | NULL | Expected objective function value to be reached |
| nb.stop.improvement | Integer |  No | 1e6|  The program will stop when there is no any improvement in nb.stop.improvement steps.|
| smooth | Logical | Yes | TRUE | Whether objective function is smooth, or differentiable almost everywhere in the region of par |  
| max.call | Integer | No | 1e7 | Maximum number of function calls made by algorithm | 
| max.time | Numeric | No | NULL | Maximum time for which algorithm runs | 
| temperature | Numeric | No | 5230 | Controls probability of accepting worse solutions during the search process | 
| visiting_param | Numeric | No | 2.62 | Parameter for visiting distribution | 
| acceptance.param | Numeric | No | -5.0 | Parameter for acceptance distribution | 
| verbose | Logical | Yes | FALSE | Whether printing of progress should occur at each iteration| 
| simple.function | Logical | Yes | FALSE | Whether objective function has only a few local minima. | 
| trace.mat | Logical | Yes | TRUE | Whether trace matrix should be available in the returned value | 
| seed | Integer | Yes | -100377| Negative integer value that can be set to initialize the internal random generator | 

### GenSA outputs

|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| value  | Numeric   | Function value at found optimum          |
| par | Numeric vector | Best set of parameters |
| count | Integer | No. of calls of obj function during optimisation |
| trace.mat | Numeric matrix | History matrix |

## DEoptim

### DEoptim arguments

| Argument | Type  | Default| Description | Optional |
| :------ | :-----: | :---------                 | :--- | :--- |
| fn | Function | - | Function to be optimised | No |
| lower | Numeric vector | - | Lower bounds for components | No |
| upper | Numeric vector | - | Upper bounds for components | No |
| control | List | - | List (& member of S3 class DEoptim.control) with controls | Yes |
| fnMap | Function | - | an optional function that will be run after each population is created, but before the population is passed to the objective function | Yes |

### DEoptim controls

| Control | Type  | Optimiser agnostic | Default| Description |
| :------ | :------- | :------- | :---- | :--- |
| VTR | Numeric | Yes | -Inf | Expected objective function value to be reached  |
| strategy | Numeric | No | 2 | Defines the Differential Evolution strategy used in the optimization procedure |
| bs | Logical | No | FALSE | F: standard trial vs. target selection T: best of parent and child selection |
| NP | Integer | No | NA | Number of population members |
| itermax | Integer  | No | 200 | Maximum no. of iterations     |
| CR | Numeric  \[0, 1] | No | 0.5 | Crossover probability |
| F | Numeric \[0, 2] | No | 0.8 | Differential weighting factor |
| initialpop | Numeric matrix | No | NULL | An initial sample of starting points |
| storepopfrom | Integer | No | itermax + 1 | From which generation should the following intermediate populations be stored in memory |
| storepopfreq | Integer | No | 1 |  Frequency with which populations are stored |
| p | Numeric (0, 1] | No | - | When strategy = 6, the top (100 * p)% best solutions are used in the mutation |
| c | Numeric (0, 1] | No | - | Controls the speed of the crossover adaptation|
| reltol | Numeric (0,1] | No | sqrt(.Machine$double.eps) ~ 1e-8 | Relative convergence tolerance | 
| steptol | Integer | No | itermax | No. of steps after which reltol is checked |
| trace | Logical/Numeric | Yes | TRUE  | Whether printing of progress occurs at each iteration (or every `trace` iterations) |

### DEoptim outputs

The output of the function DEoptim is a member of the S3 class DEoptim. It is a list with the following elements (with the elements of those tabulated):

optim:
|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| bestval  | Numeric   | Function value at found optimum          |
| bestmem | Numeric vector | Best set of parameters |
| nfeval | Integer | No. of calls of obj function during optimisation |
| iter | Integer | No. of procedure iterations |

member:
|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| lower | Numeric vector | Lower boundary |
| upper | Numeric vector | Upper boundary |
| bestvalit | Numeric | Best value of fn at each iteration |
| bestmemit | Numeric | Best member at each iteration |
| pop | matrix | population generated at the last iteration |
| storepop | list | list containing the intermediate populations |

In the optimx package, the optimr() function is structured as a self contained wrapper, which makes for a single function running for >1000 LOC and having multiple points of failure, which would make debugging tougher.
We can instead choose to have one central wrapper that takes the user command and in turn sends it to optimiser specific subwrappers.

The central wrapper will:
- Act as an interface between the user and the various subwrappers by carrying the problem and data to the subwrappers.
- Set default configurations for the selected optimisers, in a way that the configurations across optimisers are roughly equivalent and suitable for the given problem.
- Make standardised calls to the subwrappers
- Collate and return the results from the various subwrappers

The subwrappers, in turn, will:
- Receive the standardised call with the problem, data and configurations
- Customise the standardised call to the specific optimiser's requirements
- Run the optimiser
- Convert the results into a standard form and return them

Apart from these two, we would also need a comparison wrapper to benchmark, which could be integrated as an option into the global wrapper e.g. (compare = TRUE).






















