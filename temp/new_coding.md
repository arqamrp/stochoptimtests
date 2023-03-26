## Control setting functions:

For every solver, we will define a controls setting function that takes in the control parameters as arguments and outputs a list containing the user defined values for inputed parameters and default values for the rest. These would ensure that the controls are actually conform to a valid set of controls for a solver. The common control options (like niter and trace) will also given consistent names in the arguments across solvers to alleviate confusion, and will be translated to the solver specific nomenclature in the function. This will also allow the user to easily explore the control parameters by using the control function's ? Documentation.

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
[1] TRUE

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

The central wrapper `soptim` would in turn make function calls to the specific subwrappers , e.g. `soptim.DEoptim`, along with the optimisation problem parameters and the control parameters if specified.

### Arguments defining optimisation problem:

| argument | description |
| -- | :-- |
|fn | objective function to be optimised |
|lower, upper| bounds for optimisation |
|minimize| Boolean indicating whether it is to be minimised (Default = TRUE)|

### Arguments giving global control options:
| parameter | description |
| -- | :-- |
|maxf| maximum number of objective function calls|
|maxtime| maximum time or which algorithm can run|
|abstol | targeted optimum value (default - -Inf for minimize = TRUE); The method converges once the best fitness obtained is less than or equal to target.|
| trace | Boolean indicating whether progress should be printed at each iteration |

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

## Subwrappers
### soptim.DEoptim

This would 



## Comparison wrapper soptimx:

The comparison wrapper would make calls to the central wrapper for each method, and then tabulate the results it receives.

### Arguments defining optimisation problem:

| argument | description |
| -- | :-- |
| fn | objective function to be optimised|
| lower, upper | bounds for optimisation|
| minimize | Boolean indicating whether it is to be minimised (Default = TRUE)|

### Arguments giving global control options:
| parameter | description |
| -- | :-- |
| maxf| maximum number of objective function calls|
| maxtime| maximum time or which algorithm can run|
| abstol | targeted optimum value (default - -Inf for minimize = TRUE); The method converges once the best fitness obtained is less than or equal to target.|

### Passing methods to be used
methods: vector of methods to be applied (using default controls)

OR

control: list of custom, solver-specific control setting lists defined using control setting functions.

### Outputs:

A dataframe containing tabulated values for each method:
value: optimum value found
| Column | Description | 
| -- | :-- |
| value | objective function value |
| par | parameters |
| time | time taken |
| fevals | no. of function calls to objective function |
| niter | number of iterations of algorithm |
| convergence | exit code indicating reason for termination (e.g. 0: target reached, 1: maxf reached, 2: maxiter reached)|

An analogous function soptimx.constr() can be constructed for constrained optimisation if time permits.


```
# default controls
soptimx(methods = c("DEoptim", "psoptim"))
```

```
# custom controls
soptimx(fn = rastrigin, lower = c(-5, -5), upper = c(5, 5), controls = list(DE1, DE2, pso1, pso2 ))
```



Help functions:

soptim.available()

Lists all available methods.























