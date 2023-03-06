# rastrigin function

rastrigin <- function(X, A = 10, n= 2){
  n*A + sum(X^2 - A*cos(2*pi*X))
}


# plotting rastrigin function in 3D

x <- seq(-5.12, 5.12, length.out = 100)
y <- seq(-5.12, 5.12, length.out = 100)
z <- matrix(0,100,100)

for(i in 1:length(x)){
  for(j in 1:length(y)){
    z[i,j] = rastrigin(c(x[i],y[j]))
  }
}

persp(x, y, z, theta = 30, phi = 30, expand = 0.5, main = "Rastrigin function 3D plot", cex.main =.8, col = "lightblue")
