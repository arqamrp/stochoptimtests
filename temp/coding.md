## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive lists of the optimisers, their various arguments that can be tweaked, the default configurations for these arguments, and the outputs.



### GenSA controls

| Argument | StochOptim analogue | Description                        | Optimiser agnostic? |
| :------: | :-----------------: | :---------                       | :--- |
| maxit  | max.iter               | Maximum no. of iterations          | No |
| threshold.stop | threshold.stop | Expected objective function value to be reached  | Yes |
| verbose | verbose | whether printing of progress occurs at each iteration| Yes |
| max.call | | | No |
| max.time | | | No |



### DEoptim controls

| Argument | StochOptim analogue | Description                        |
| :------: | :-----------------: | :---------                    |
| itermax  | max.iter               | Maximum no. of iterations          |
| VTR | threshold.stop | Expected objective function value to be reached  |
| NP  |  | number of population members |
| initialpop | | an initial sample of starting points |
| trace | verbose | whether printing of progress occurs at each iteration |

### GenSA outputs

|   Field  | StochOptim analogue | Description                        |
| :------: | :-----------------: | :---------                        |
| value  | value               | function value at found optimum          |
| par | par | Best set of parameters |
| count | count | No. of calls of obj function during optimisation |
| trace.mat |  | history matrix |



In the optimx package, the optimr() function is structured as a self contained wrapper, which makes for a single function running for >1000 LOC and having multiple points of failure, which would make debugging tougher.
We can instead choose to have one central wrapper that takes the user command and in turn sends it to optimiser specific subwrappers.









