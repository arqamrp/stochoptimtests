#' Computes Rastrigin function for n dimensional vector
#' @param X A numeric vector
#' @param A A number.
#' @param n Number of dimensions.
#' @returns A number
#' @examples
#' rastrigin(c(1, 1))
#' rastrigin(c(0,0,3), A = 11, n = 3 )

rastrigin <- function(X, A = 10, n= 2){
  n <- length(X)
  n*A + sum(X^2 - A*cos(2*pi*X))
}
