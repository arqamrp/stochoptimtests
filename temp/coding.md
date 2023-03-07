## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive lists of the optimisers, their various arguments that can be tweaked, the default configurations for these arguments, and the outputs.


I have attempted to make such lists for GenSA and DEoptim to start with:

## GenSA {GenSA}

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

### GenSA output

Returned as a list.

|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| value  | Numeric   | Function value at found optimum          |
| par | Numeric vector | Best set of parameters |
| count | Integer | No. of calls of obj function during optimisation |
| trace.mat | Numeric matrix | History matrix |

## DEoptim {DEoptim}

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

### DEoptim output

The output of the function DEoptim is a member of the S3 class DEoptim. It is a list with the following elements (with the elements of those tabulated):

**optim**:
|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| bestval  | Numeric   | Function value at found optimum          |
| bestmem | Numeric vector | Best set of parameters |
| nfeval | Integer | No. of calls of obj function during optimisation |
| iter | Integer | No. of procedure iterations |

**member**:
|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| lower | Numeric vector | Lower boundary |
| upper | Numeric vector | Upper boundary |
| bestvalit | Numeric | Best value of fn at each iteration |
| bestmemit | Numeric | Best member at each iteration |
| pop | matrix | population generated at the last iteration |
| storepop | list | list containing the intermediate populations |

## psoptim {pso}

### psoptim arguments

| Argument | Type  | Default| Description | Optional |
| :------ | :-----: | :---------                 | :--- | :--- |
| par | Numeric vector | - | Initialisation vector with length defining the dimensionality of the optimization problem. Can be c(NA, NA...) | No |
| fn | Function | - | Function to be optimised | No |
| lower | Numeric vector | - | Lower bounds for components | No |
| upper | Numeric vector | - | Upper bounds for components | No |
| control | List | - | List of control parameters | Yes |
| gr | Function | - | A function to return the gradient if local search is BFGS | Yes |


### psoptim controls

| Control | Type  | Optimiser agnostic | Default| Description |
| :------ | :------- | :------- | :---- | :--- |
| type | Character vector | No | "SPSO2007" | Describes which reference implementation of SPSO is followed (2007 or 2011)|
| maxf | Integer | No | Inf | Maximum number of function calls made by algorithm | 
| abstol | Numeric | Yes | -Inf | The absolute convergence tolerance |
| reltol | Numeric | Yes | 0 | The tolerance for restarting |
| maxit | Integer  | No | 1000 | Maximum no. of iterations     |
| s | Integer | No | floor(10+2\*sqrt(length(par))) (“SPSO2007”) or 40 (“SPSO2011”) | Swarm size |
| k | Numeric | No | 1 | The exponent for calculating number of informants |
| p | Numeric | No | 1-(1-1/s)^k | The average proportion of informants for each particle |
| w | numeric(1 or 2) | No | 1/(2\*log(2)) | Exploitation constant. If the length is two, the actual constant used is gradially changed from w\[1] to w\[2] |
| c.p | Numeric | No | .5+log(2) | The local exploration constant |
| c.g | Numeric | No | .5+log(2) | The global exploration constant |
| d | Numeric | No | norm(upper - lower, "2") | The diameter of the search space |
| v.max | Numeric | No | NA | The maximal (euclidean) length of the velocity vector. If specified the actual clamping of the length is v.max\*d |
| rand.order | Logical | No | TRUE | If TRUE the particles are processed in random order. |
| max.restart | Integer | No | Inf | The maximum number of restarts | 
| maxit.stagnate | Integer | No | Inf | The maximum number of iterations without improvement |
| vectorize | Logical | No | FALSE |  If TRUE the particles are processed in a vectorized manner. |
| hybrid | Logical | No | FALSE | If true, each normal PSO position update is followed by an L-BFGS-B search with the provided position as initial guess.|
| hybrid.control | List | No | NULL | List with any additional control parameters to pass on to optim when using L-BFGS-B for the local search |
| trace | Numeric | Yes | 0  | Whether printing of progress occurs |
| REPORT | Numeric | Yes | 1 | The frequency for reports if trace > 0 |
| trace.stats | Logical | ? | FALSE | If TRUE statistics at every reporting step are collected and returned |
| fnscale | Numeric | No | 1 | An overall scaling to be applied to the value of fn and gr (if used) during optimization |

### psoptim outputs

Returned as a list.

|   Field  | Type | Description                        |
| :------: | :-----: | :---------                        |
| value  | Numeric   | Function value at found optimum          |
| par | Numeric vector | Best set of parameters |
| counts | Numeric vector | A three-element vector containing the number of function evaluations, the number of iterations, and the number of restarts |
| convergence | Integer | 	0: reached abstol; 1: maxf reached; 2: maxit reached; 3: max.restart reached; 4: max.stagnate reached |
| message | Character | A descriptive message of the reason for termination |
| stats | Numeric matrix | A list of statistics collected at every reporting step |


## Wrapper structure

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






















