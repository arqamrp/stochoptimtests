## Project info

Project title: StochOptim: 

Project short title (30 characters): 

URL of project idea page: [https://github.com/rstats-gsoc/gsoc2023/wiki/StochOptim-stochastic-optimization-in-R](https://github.com/rstats-gsoc/gsoc2023/wiki/StochOptim-stochastic-optimization-in-R)

## Bio of Contributor 

I am a sophomore undergraduate in Statistics and Data Science at the Indian Institute of Technology, Kanpur.
My introduction to R took place through the course, Data Science Lab I, taught by Dr Dootika Vats. In the course, I learned the fundamentals of R, including things like benchmarking, Rshiny, Rmarkdown and Rcpp. 
I am also currently doing a course, Statistical Computing, which includes optimisation methods and am thus somewhat familiar with the theoretical content of the project.


## Contact Information 

Contributor name: Arqam Patel

Contributor postal address: Hall 5, IIT Kanpur, Kanpur, Uttar Pradesh, india, 208016

Telephone(s): +91 7715863670 

Email(s): 
arqamrp@gmail.com
arqamrp21@iitk.ac.in

Other communications channels: Skype/Google+, etc. : https://instagram.com/arqambhaipatel


## Contributor affiliation

Institution: Indian Institute of Technology, Kanpur

Program: BS, Statistics and Data Science

Stage of completion: 2nd year out of 4

Contact to verify: Dr Dootika Vats, dootika@iitk.ac.in


## Schedule Conflicts:

Classes at my college will resume from July 31.

## Mentors

Evaluating mentor name and email: John C Nash, profjcnash@gmail.com

Co-mentor name(s) and email(s): HW Borchers, hwborchers@gmail.com, Paulo Cortez, pcortez@dsi.uminho.pt

Have you been in touch with the mentors? When and how? 
I have been in touch with the mentors since March 2, and we have corresponded consistently through email.

## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive lists of the optimisers, their arguments, the control parameters that can be tweaked, the default configurations for these parameters, and the forms of the outputs.

I have attempted to make such lists for GenSA, DEoptim and psoptim to start with:

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
- Act as an interface between the user and the various subwrappers by carrying the problem and data to the desired subwrapper.
- Set default configurations for the selected optimiser, in a way that the configurations across optimisers are roughly equivalent and suitable for the given problem.
- Make standardised calls to the subwrapper.
- Collate and return the results from the subwrapper in a standard format.

The subwrappers, in turn, will:
- Receive the standardised call with the problem, data and configurations
- Customise the standardised call to the specific optimiser's requirements
- Run the optimiser
- Convert the results into a standard form and return them


Then, we would need a comparison wrapper which would make calls to all the various optimisers through the centraal wrapper, collect relevant information ie the optimum parameters, optimum value, function calls, time taken, etc. and display those in an easy to read, tabulated form.


Describe in detail your plan for completing the work.  What functions will be written, how and when will you do design, how will you verify the results of your coding?  The sub-section headings below are examples only.  Each project is different, please make your application appropriate to the work you propose.  

Describe perceived obstacles and challenges, and how you plan to overcome them.

The best R GSoC applications tend to be 10+ pages printed.  Planning is a key part of a successful project, and demonstrates to the mentors that you are qualified and engaged.


## Timeline

**Monthly overview of timeline**

May: Review the precursor codebase. Decide on the structure by iterating through some basic prototypes and approaches.

June: Build the central wrapper and various subwrappers

July: Troubleshoot and make the package pass R CMD check. Get started with a prototype of the comparison wrapper

August: Finish the comparison wrapper, make the whole package pass R CMD check.

**Detailed timeline**
| Duration | Task(s)|
| --- | :---|
|  | Community bonding period|
| May 4-10 | Review the source code of the package [optimx](https://cran.r-project.org/web/packages/optimx/index.html) and [last year's project progress](https://github.com/SudoWodo/StochOptim). |
| May 11-15 | Read about and practice object oriented programming in R (from the book Advanced Object-Oriented Programming in R). Learn about S3, S4, R6 classes and decide which approach would be best. |
| May 16-22 | Select possibly 15-20 solvers to initially include from amongst those listed under the "Global and Stochastic Optimization" heading in the [CRAN Task View: Optimization and Mathematical Programming](https://cran.r-project.org/web/views/Optimization.html). Document (in a tabulated form) the arguments, control parameters and outputs of the selected solvers. 
|May 23-28 | Document package dependencies. Decide on nomenclature scheme for functions, solvers, controls etc. Write introductory documentation to the package. |
|| Coding starts|
| May 29-June 9 | Write and document (using text as well as diagrams) the fundamental class structure of the central and subwrappers. Develop a prototype that works with two or three methods with default options and trace set to off. Test it on multiple functions.|
| June 10-18 | Add the rest of the solvers (two per day). Compare by benchmarking the performance of the central wrapper to a loop calling optimisers one by one.|
| June 19-25 | Add custom control parameters and global options for each solver. Document everything added in real time. Test after each addition.|
| June 26-July 3 | Add trace control features for each solver. Test after each addition. Add documentation vignettes and examples for each solver. Compare the performance of the wrapper to a plain loop again.|
| July 3-10 | Build the functions into a package. Write the documentation for installation. Get a prototype package with a central wrapper with all solvers, that passes R CMD check.|
| | Midterm evaluation|
| July 14-20| Initiate comparison wrapper with class structure. Start with 3-4 solver options.|
| July 20-August 3| Add all remaining solvers to the comparison wrapper, in a similar manner to the central wrapper. Document everything added in real time. Test after each addition. Compare performance of comparison wrapper to simple benchmarking.|
| August 4-13| Add examples and documentation. Debug and make sure the package passes R CMD check on all platforms. |
| August 14-21| Buffer week for troubleshooting.|
| August 21-28| Submission. Mentor evaluations.|
|| Final evaluation|

Since I'll be attending classes in the last 4 weeks, from July 31, I might be able to commit a bit less time relatively- I'll be able to manage ~30 hours a week. I plan to compensate for this by getting a maximum of work on the comparison wrapper done before July 31 by spending more time per week (40-45 hours), and leave a buffer for unexpected delays or obstacles in the end.

Write examples 
(consult GSOC schedule)

Provide a detailed timeline of how you plan to spend your summer.  Don't leave testing and documentation for last, as that's almost a guarantee of a failed project. 

Make sure to identify what you plan to accomplish in each month of the project.  Google has asked organizations to be more directive about milestones. Also be sure to identify what you will accomplish between acceptance and the official start of coding. (Hint: establishing your build environment and researching existing work shouldn't wait till project start)

What is your contingency plan for things not going to schedule? We understand things change, but how are you planning to address changes and setbacks?

If you have other time commitments that will interfere with GSoC, we highly recommend explaining how you will front-load the work before coding start or work extra early on to build a cushion!

## Management of Coding Project

**Documentation plan**

I plan to write clear descriptions of the commits I make to the repository and add those to a text/spreadsheet based log file. I also plan to write a detailed weekly blog, starting from the community bonding period itself, describing the progress made, the development choices made (and what the other options were) etc. I will use roxygen2 for creating documentation .Rd files for functions of the package while I also plan to include vignettes created using Rmakrdown that provide a comprehensive guide on the various optimisers available and how the functions can be used.

I will also create a progress tracking spreadsheet with a list of the tasks accomplished daily (along with the corresponding log reference) and the tasks I plan to accomplish in the coming week. 

For testing the overall package state, I plan to run a weekly R CMD check and reinstall the package periodically in my R environment. For testing individual subwrappers, I will compare the subwrapper outputs to the original package function's output using seeds for reproducibility. I will use `rbenchmark` to measure the performance of the central wrapper compared to a simple loop calling the various optimisers. I will also profile each subwrapper using `profvis` to check for potential efficiency improvements.

I plan to push commits at least every two days.

How do you propose to ensure code is submitted / tested?

How often do you plan to commit?  What changes in commit behavior would indicate a problem?



## Test

For the qualification test, I solved five tasks:
### [Rastrigin function](https://github.com/arqamrp/stochoptimtests/blob/main/tests/rastrigin.R):
I implemented the Rastrigin function, a common test function for optimisation, for n-dimensional vectors, using the definition on its Wikipedia page. I then plotted it in three dimensions (for 2D vectors, with the z axis representing fuunction value). I also guessed its global minimum and provided the rationale behind my guess.

![Rastrigin plot](https://github.com/arqamrp/stochoptimtests/blob/main/tests/rastrigin.png)

### [optim()](https://github.com/arqamrp/stochoptimtests/blob/main/tests/optim.R): 

I used the default Nelder-Mead local optimiser on five randomly initialised starting points (setting a seed for reproducibility). Then, fixing the starting point, I used the five different algorithm options within optim() (using separate calls for each method) to compare them on the basis of the minima found and time taken (measured using rbenchmark). 
After this, I used the ucminf function to implement another local optimiser (not available in optim) on those five points, and then the optimx function to run and compare multiple methods with the same initial point using one function call.



### [Stochastic optimisation](https://github.com/arqamrp/stochoptimtests/blob/main/tests/stochastic_optimisation.R) 

I used three different global optimisers: DEoptim, GenSA and psoptim, which are listed under different classes of methods in [^2]. The three are based on different algorithms: Differential Evolutionary optimisation, Generalized Simulated Annealing, and Particle Swarm Optimisation. 
We compare them in terms of precision achieved and time taken for 10 replications (using default function arguments).

### [Other test functions]()



















