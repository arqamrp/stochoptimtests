## Control setting functions:

For every solver, we will define a controls setting function that takes in the control parameters as arguments and outputs a list containing the user defined values for inputed parameters and default values for the rest. This ensures that the controls actually conform to a valid set of controls for a solver. The common control options (like itermax and trace) will also given consistent names in the arguments across solvers to alleviate confusion, and will be translated to the solver specific nomenclature in the function. This will also allow the user to easily explore the control parameters by using the control function's ? Documentation.  

```
# using custom controls
DE1 <- control.DEoptim(NP = 10, maxit = 300, strategy = 1)
DE2 <- control.DEoptim(NP = 12)
pso1 <- control.psoptiim(maxit = 2000)
pso2 <- control.psoptim(strategy = "SPSO2011")
```

The contents of the list DE1 will look like this:
```
$method
[1] "DEoptim"

$control
$control$VTR
[1] -Inf

$control$strategy
[1] 1

$control$NP
[1] 10

$control$itermax
[1] 300

$control$CR
[1] 0.5

$control$F
[1] 0.8

$control$bs
[1] FALSE

$control$trace
[1] FALSE

$control$initialpop
NULL

$control$storepopfrom
[1] 201

$control$storepopfreq
[1] 1

$control$p
[1] 0.2

$control$c
[1] 0

$control$reltol
[1] 1.490116e-08

$control$steptol
[1] 200

$control$parallelType
[1] "none"

$control$cluster
NULL

$control$packages
NULL

$control$parVar
NULL

$control$foreachArgs
list()

$control$parallelArgs
NULL

```


## Main wrapper soptim:


```
soptim(fn = rastrigin, lower = c(-5, -5), upper = c(5, 5), method = "DEoptim")
soptim(fn = rastrigin, lower = c(-5, -5), upper = c(5, 5), control = DE1)
```

The central wrapper `soptim` would in turn make function calls to the specific optimiser, e.g. `DEoptim`, along with the optimisation problem parameters and the control parameters. The control setting functions would allow us to bypass the need for wrapping functions for each solver, since we can ensure the conformity of control options. So, we can directly structure the central wrapper as a logic flow of solver function calls with the control argument set to the control list (e.g. `DE1`).

### Arguments defining optimisation problem:

| argument | description |
| -- | :-- |
|fn | objective function to be optimised |
|lower, upper| bounds for optimisation |
|minimize| Boolean indicating whether it is to be minimised (Default = TRUE)|

### Arguments giving solver-agnostic control options:
| parameter | description |
| -- | :-- |
|maxf| maximum number of objective function calls|
|maxtime| maximum time or which algorithm can run|
|abstol | targeted optimum value (default - -Inf for minimize = TRUE); The method converges once the best fitness obtained is less than or equal to target.|
| trace | Boolean indicating whether progress should be printed at each iteration |

The control lists containing solver specific control options (e.g. DE1) will be modified in the function scope with the values of these at the time of the function call.

### Passing methods to be used
method = "DEoptim": using default controls

OR

control = DE1: using custom controls

### Outputs

A list containing the following should be output:
| Element | Description | 
| -- | :-- |
| value | objective function value |
| par | parameters |
| fevals | no. of function calls to objective function |
| niter | number of iterations of algorithm |
| convergence | exit code indicating reason for termination (e.g. 0: target reached, 1: maxf reached, 2: maxiter reached)|

## Comparison wrapper soptimx:

The comparison wrapper would make calls to the central wrapper for each method, and then tabulate the results it receives.

### Arguments defining optimisation problem:

| argument | description |
| -- | :-- |
| fn | objective function to be optimised|
| lower, upper | bounds for optimisation|
| minimize | Boolean indicating whether it is to be minimised (Default = TRUE)|

### Arguments giving solver-agnostic control options:
| parameter | description |
| -- | :-- |
| maxf| maximum number of objective function calls|
| maxtime| maximum time or which algorithm can run|
| abstol | targeted optimum value (default - -Inf for minimize = TRUE); The method converges once the best fitness obtained is less than or equal to target.|
| trace | whether progress should be printed at each step for each method |

### Passing methods to be used
methods: vector of methods to be applied (using default controls)

OR

control: list of custom, solver-specific control setting lists defined using control setting functions.

### Arguments customising fields to output

| argument | description |
| -- | :-- |
| time | Boolean indicating whether the time taken should be output |
| fevals | Boolean indicating whether the no. of function calls taken should be output |
| niter | Boolean indicating whether the number of iterations of algorithm should be output|
| convergence | whether exit code should be output |

### Outputs:

A dataframe containing tabulated values of the selected fields for each method:
value: optimum value found
| Column | Description | 
| -- | :-- |
| value | objective function value |
| par | parameters |
| time | time taken |
| fevals | no. of function calls to objective function |
| niter | number of iterations of algorithm |
| convergence | exit code indicating reason for termination (e.g. 0: target reached, 1: maxf reached, 2: maxiter reached)|

```
##                        p1            p2        value  time
## default      2.611627e-10  1.622116e-09 0.000000e+00 1.834
## maxit = 100  1.156110e-05 -2.148004e-07 2.652605e-08 0.181
## maxit = 500 -2.022985e-09 -1.094271e-10 0.000000e+00 0.903
## s = 3       -1.031261e-09  9.949586e-01 9.949591e-01 0.529
## s = 6        8.316656e-10  4.021507e-10 0.000000e+00 0.961
## SPSO2011     3.185646e-09 -9.572976e-11 0.000000e+00 7.426
```


An analogous function soptimx.constr() can be constructed for constrained optimisation if time permits.



```
# default controls
soptimx(fn = rastrigin, lower = c(-5, -5), upper = c(5, 5), methods = c("DEoptim", "psoptim"))
```

```
# custom controls
soptimx(fn = rastrigin, lower = c(-5, -5), upper = c(5, 5), controls = list(DE1, DE2, pso1, pso2 ))
```



Help functions:

soptim.available()

Lists all available methods.























