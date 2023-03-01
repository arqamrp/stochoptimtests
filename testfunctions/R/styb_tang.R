#' Computes Styblinski-Tang function for n dimensional vector
#' @param X A numeric vector
#' @returns A number
#' @examples
#' styb_tang(c(1, 1))
#' styb_tang(c(0,0,3))


styb_tang <- function(X){
  sum(X^4 - 16*X^2 + 5*X)/2
}
