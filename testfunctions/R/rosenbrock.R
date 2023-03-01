#' Computes Rosenbrock function for n dimensional vector
#' @param X A numeric vector
#' @param a A number.
#' @param b A number.
#' @param n Number of dimensions.
#' @returns A number
#' @examples
#' rosenbrock(c(1, 1))
#' rosenbrock(c(0,0,3), a = 2, b =110, n = 3 )


rosenbrock <- function(X, n = 2,  a = 1, b = 100){
  ans <- 0
  for(i in 1:(n-1)){
    ans <- ans + (a-X[i])^2 + b*(X[i+1] - X[i]^2)^2
  }
  return(ans)
}
