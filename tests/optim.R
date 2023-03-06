# set starting points
n <- 5

set.seed(1)
init <- matrix(runif(n = 2*n, -5.12, 5.12), nrow = n, ncol = 2)

vals <- numeric(n)
opt <- matrix(0, n, 3)

# implement optim on all starting points and output dataframe with coordinates and function value

for(i in 1:n){
  vals[i] <- rastrigin(init[i,])
  optimum <- optim(par = init[i,], fn = rastrigin)
  opt[i, 1] <- optimum$par[1]
  opt[i, 2] <- optimum$par[2]
  opt[i, 3] <- optimum$value
}

mat <- cbind(init, vals, opt)
df <- as.data.frame(mat)
colnames(df) <- c("p1_init", "p2_init", "value_init", "p1_optim", "p2_optim", "value_optim")
df

# Varying the method keeping point constant

p <- init[1,]
mat <- as.data.frame(matrix(0,6,4))
mat[1,1:3] <- df[1,1:3]

j <-2

for(i in c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN"))
{
  optimum <- optim(par = p, fn = rastrigin, method = i)
  foo <- cbind(optimum$par[1], optimum$par[2], optimum$value)
  time <- benchmark(optim(par = p, fn = rastrigin, method = i), columns = "elapsed", replications =10)
  
  mat[j,1:3] <- foo
  mat[j,4] <- time
  j <- j+1
}

rownames(mat) <- c("initial","Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN")
colnames(mat) <- c("p1", "p2", "value", "time") 
mat


# using ucminf on all five starting points

library(ucminf)
vals2 <- numeric(n)
opt2 <- matrix(0, n, 3)

for(i in 1:n){
  vals2[i] <- rastrigin(init[i,])
  optimum <- ucminf(par = init[i,], fn = rastrigin)
  opt2[i, 1] <- optimum$par[1]
  opt2[i, 2] <- optimum$par[2]
  opt2[i, 3] <- optimum$value
  
}

mat2 <- cbind(init, vals2, opt2)
df2 <- as.data.frame(mat2)
colnames(df2) <- c("p1_init", "p2_init", "value_init", "p1_optim", "p2_optim", "value_optim")
df2

# Using optmix to implement multiple methods using less LOC

library(optimx)
methods <- c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B","ucminf", "nlm", "nlminb")
optimx(par = init[1,] , rastrigin, method = methods)[, c(-4, -5,-6,-7,-8,-9)]



# usin
