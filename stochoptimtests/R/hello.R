# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'


rastrigin <- function(X, A = 10, n= 2){
  n*A + sum(X^2 - A*cos(2*pi*X))
}

rosenbrock <- function(X, n = 2,  a = 1, b = 100){
  ans <- 0
  for(i in 1:(n-1)){
    ans <- ans + (a-X[i])^2 + b*(X[i+1] - X[i]^2)^2
  }
  return(ans)
}

styb_tang <- function(X){
  sum(X^4 - 16*X^2 + 5*X)/2
}
