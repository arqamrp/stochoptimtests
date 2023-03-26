Main wrapper soptim:



Comparison wrapper soptimx:

Arguments defining optimisation problem:

| argument | description |
| -- | :-- |
|fn | objective function to be optimised|
|lower, upper| bounds for optimisation|
|minimize| Boolean indicating whether it is to be minimised (Default = TRUE)|

Global control options:
| parameter | description |
| -- | :-- |
|maxf| maximum number of objective function calls|
|maxtime| maximum time or which algorithm can run|
|abstol | targeted optimum value (default - -Inf for minimize = TRUE); The method converges once the best fitness obtained is less than or equal to target.|


methods: vector of methods to be applied (using default controls)
OR
control: list of custom, solver-specific control setting lists defined using control setting functions.

Outputs:

A table containing:
value: optimum value found
par: parameters
time: time taken 
fevals: no. of function calls to objective function
niter: number of iterations of algorithm
co : exit code indicating reason for termination (e.g. 0: target reached, 1: maxf reached, 2: maxiter reached)

An analogous function soptimx.constr() can be constructed for constrained optimisation if time permits.



```
# default controls
soptim(methods = c("DEoptim", "psoptim"))
```

Control functions:
For every solver, we will define a controls setting function that takes in the control parameters as arguments and outputs a list containing the user defined values for inputed parameters and default values for the rest. 
This will allow the user to explore the control parameters by using the control function's ? Documentation.

```
# using custom controls
DE1 <- control.DEoptim(NP = 10, )
DE2 <- control.DEoptim(NP = 12)
pso1 <- control.psoptiim(maxiter = 2000)
pso2 <- control.psoptim(type = "SPSO2011")

soptim(fn = rastrigin, lower = c(-5, -5), upper = c(5, 5), controls = list(DE1, ))
```


soptim.available()

Lists


Help functions:
























