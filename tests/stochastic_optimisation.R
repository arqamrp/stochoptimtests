library(DEoptim)
library(GenSA)
library(pso)
library(rbenchmark)

rastrigin <- function(X, A = 10, n= 2){
  n*A + sum(X^2 - A*cos(2*pi*X))
}

# running all 3 and comparing performance

replications = 10
df3 <- as.data.frame(matrix(0, 3, 4), row.names = c("DEoptim", "GenSA", "psoptim"))

df3[,4] <- benchmark(deoptim <- DEoptim(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = DEoptim.control(trace = F)), gensa <- GenSA(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12)), pso <- psoptim(fn = rastrigin, lower = c(-5.12, -5.12), upper = c(5.12, 5.12), par = c(NA,NA)), columns = "elapsed", replications = replications)

DEopt <- deoptim$optim

colnames(df3) = c("p1", "p2", "value", "time")

df3[1,1:3] <- c(DEopt$bestmem[1], DEopt$bestmem[2], DEopt$bestval) 
df3[2,1:3] <- c(gensa$par[1], gensa$par[2], gensa$value)
df3[3,1:3] <- c(pso$par[1], pso$par[2], pso$value)
df3

