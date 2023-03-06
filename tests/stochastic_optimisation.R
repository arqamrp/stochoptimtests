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


# Trying out DEoptim with variations in NP and itermax

set.seed(1)
replications = 10
df4 <- as.data.frame(matrix(0, 5, 4), row.names = c("default", "NP=75", "NP=200","itermax=375", "itermax=1000"))

df4[,4] <- benchmark(deoptim1 <- DEoptim(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = DEoptim.control(trace = F))$optim,
                     deoptim2 <- DEoptim(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = DEoptim.control(trace = F, NP =75))$optim,
                     deoptim3 <- DEoptim(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = DEoptim.control(trace = F, NP =200))$optim,
                     deoptim4 <- DEoptim(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = DEoptim.control(trace = F, itermax = 375))$optim,
                     deoptim5 <- DEoptim(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = DEoptim.control(trace = F, itermax = 1000))$optim,
                     columns = "elapsed", replications = replications)



colnames(df4) = c("p1", "p2", "value", "time")

df4[1,1:3] <- c(deoptim1$bestmem[1], deoptim1$bestmem[2], deoptim1$bestval) 
df4[2,1:3] <- c(deoptim2$bestmem[1], deoptim2$bestmem[2], deoptim2$bestval) 
df4[3,1:3] <- c(deoptim3$bestmem[1], deoptim3$bestmem[2], deoptim3$bestval) 
df4[4,1:3] <- c(deoptim4$bestmem[1], deoptim4$bestmem[2], deoptim4$bestval)
df4[5,1:3] <- c(deoptim5$bestmem[1], deoptim5$bestmem[2], deoptim5$bestval)
df4


# trying out GenSA with variations in temperature and maxit

set.seed(1)
replications = 10
df5 <- as.data.frame(matrix(0, 7, 4), row.names = c("default", "temperature = 1", "temperature = 10", "temperature = 100","maxit = 100", "maxit = 375", "maxit = 1000"))

df5[,4] <- benchmark(siman1 <- GenSA(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list()),
                     siman2 <- GenSA(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(temperature = 1)),
                     siman3 <- GenSA(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(temperature = 10)),
                     siman4 <- GenSA(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(temperature = 100)),
                     siman5 <- GenSA(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(maxit = 100)),
                     siman6 <- GenSA(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(maxit = 375)),
                     siman7 <- GenSA(fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(maxit = 1000)),
                     columns = "elapsed", replications = replications)



colnames(df5) = c("p1", "p2", "value", "time")

df5[1,1:3] <- c(siman1$par[1], siman1$par[2], rastrigin(siman1$par)) 
df5[2,1:3] <- c(siman2$par[1], siman2$par[2], rastrigin(siman2$par)) 
df5[3,1:3] <- c(siman3$par[1], siman3$par[2], rastrigin(siman3$par)) 
df5[4,1:3] <- c(siman4$par[1], siman4$par[2], rastrigin(siman4$par))
df5[5,1:3] <- c(siman5$par[1], siman5$par[2], rastrigin(siman5$par))
df5[6,1:3] <- c(siman6$par[1], siman6$par[2], rastrigin(siman6$par))
df5[7,1:3] <- c(siman7$par[1], siman7$par[2], rastrigin(siman7$par))
df5

# trying out psoptim with variations in maxit and s

set.seed(2)
replications = 10
df6 <- as.data.frame(matrix(0, 6, 4), row.names = c("default", "maxit = 100", "maxit = 500", "s = 3", "s = 6", "SPSO2011"))

df6[,4] <- benchmark(psopt1 <- psoptim(par = c(NA, NA), fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12)),
                     psopt2 <- psoptim(par = c(NA, NA), fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(maxit = 100)),
                     psopt3 <- psoptim(par = c(NA, NA), fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(maxit = 500)),
                     psopt4 <- psoptim(par = c(NA, NA), fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(s = 3)),
                     psopt5 <- psoptim(par = c(NA, NA), fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(s = 6)),
                     psopt6 <- psoptim(par = c(NA, NA), fn = rastrigin, lower = c(-5.12,-5.12), upper = c(5.12, 5.12), control = list(type = "SPSO2011")),
                     columns = "elapsed", replications = replications)



colnames(df6) = c("p1", "p2", "value", "time")

df6[1,1:3] <- c(psopt1$par[1], psopt1$par[2], rastrigin(psopt1$par)) 
df6[2,1:3] <- c(psopt2$par[1], psopt2$par[2], rastrigin(psopt2$par)) 
df6[3,1:3] <- c(psopt3$par[1], psopt3$par[2], rastrigin(psopt3$par)) 
df6[4,1:3] <- c(psopt4$par[1], psopt4$par[2], rastrigin(psopt4$par))
df6[5,1:3] <- c(psopt5$par[1], psopt5$par[2], rastrigin(psopt5$par))
df6[6,1:3] <- c(psopt6$par[1], psopt6$par[2], rastrigin(psopt6$par))
df6

















