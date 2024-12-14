#-----------------------------------------------------------------------
# Baskara 1.

baskara <- function(a, b, c) {
  delta <- b^2 - 4 * a * c
  x <- (-b + c(-1, 1) * sqrt(delta))/(2 * a)
  return(x)
}

a <- 0.5
b <- -1
c <- -10

root <- baskara(a = a, b = b, c = c)
root

curve(a * x^2 + b * x + c, from = -10, to = 10)
abline(h = 0, col = "red")
abline(v = root, col = "red", lty = 2)

#-----------------------------------------------------------------------
# Área do triângulo.

M <- matrix(c(0, 0, 1, 0, 0, 1),
            byrow = TRUE,
            nrow = 3,
            ncol = 2)

plot(M, col = "red", pch = 19, asp = 1)
polygon(M, lty = 3, col = "blue", border = "orange", lwd = 3)

calc_area <- function(M) {
  M <- rbind(M, M[1, ])
  pos <- 0
  neg <- 0
  for (i in 1:3) {
    pos <- pos + M[i, 1] * M[i + 1, 2]
    neg <- neg + M[i + 1, 1] * M[i, 2]
  }
  a <- 0.5 * abs(pos - neg)
  return(a)
}

calc_area(M)

plot(x = NULL, y = NULL, xlim = c(0, 1), ylim = c(0, 1), asp = 1)
coords <- locator(n = 3)

coords

M <- cbind(coords$x, coords$y)

plot(M, col = "red", pch = 19, asp = 1)
polygon(M, lty = 3, col = "blue", border = "orange", lwd = 3)
calc_area(M)

#-----------------------------------------------------------------------
# Baskara 2.

a <- 0.5
b <- -1
c <- -10

curve(a * x^2 + b * x + c, from = -10, to = 10)
abline(h = 0, col = "red")

baskara <- function(a, b, c, verbose = FALSE) {
  if (missing(a)) {
    stop("O argumento `a` precisa ser fornecido.")
  }
  if (!is.numeric(a)) {
    stop("O argumento `a` precisa ser numérico.")
  }
  if (length(a) == 0L) {
    stop("O argumento `a` precisa ter comprimento maior que zero.")
  } else if (length(a) != 1L) {
    warning("O argumento `a` tem mais de 1 elemento. Apenas o 1º será usado.")
    a <- a[1]
  }
  if (a == 0) {
    stop("O argumento `a` tem que ser diferente de zero.")
  }
  delta <- b^2 - 4 * a * c
  if (delta < 0) {
    warning("Delta menor que zero, não possui raízes.")
    return(c(NA_real_, NA_real_))
  }
  x <- (-b + c(-1, 1) * sqrt(delta))/(2 * a)
  if (verbose) {
    cat("---------------------------------------------------------\n")
    cat("Argumentos\n")
    cat("a:", a, "\n")
    cat("b:", b, "\n")
    cat("c:", c, "\n")
    cat("Raízes encontradas:\n")
    cat("x1:", x[1], "\n")
    cat("x2:", x[2], "\n")
    cat("---------------------------------------------------------\n")
  }
  return(x)
}

root <- baskara(a = a, b = b, c = c, TRUE)

baskara(b = b, c = c)
baskara(a = "1", b = b, c = c)
baskara(a = numeric(), b = b, c = c)
baskara(a = c(0.5, 3, 4), b = b, c = c)
baskara(a = 0, b = b, c = c)
baskara(a = a, b = b, c = 10)

root <- baskara(a = a, b = b, c = c)
root

curve(a * x^2 + b * x + c, from = -10, to = 10)
abline(h = 0, col = "red")
abline(v = root, col = "red", lty = 2)

#-----------------------------------------------------------------------
# Baskara leitura da entrada padrão.

baskara_read <- function() {
  cat("Forneça o valor para o argumento `a`.\n")
  a <- scan(n = 1, what = numeric())
  cat("Forneça o valor para o argumento `b`.\n")
  b <- scan(n = 1, what = numeric())
  cat("Forneça o valor para o argumento `c`.\n")
  c <- scan(n = 1, what = numeric())
  root <- baskara(a = a, b = b, c = c)
  return(root)
}

baskara_read()

#-----------------------------------------------------------------------
# Cálculo de área.

plot(x = NULL, y = NULL, xlim = c(0, 1), ylim = c(0, 1), asp = 1)
abline(v = c(0, 1), h = c(0, 1), lty = 2, col = "gray")
coords <- locator(pch = 19, type = "p")
coords

M <- cbind(coords$x, coords$y)
M

# M <- rbind(c(0, 0), c(0, 1), c(1, 1), c(1, 0))

calc_area <- function(M) {
  n <- nrow(M)
  M <- rbind(M, M[1, ])
  pos <- 0
  neg <- 0
  for (i in 1:n) {
    pos <- pos + M[i, 1] * M[i + 1, 2]
    neg <- neg + M[i + 1, 1] * M[i, 2]
  }
  a <- 0.5 * abs(pos - neg)
  return(a)
}

plot(M, col = "red", pch = 19, asp = 1)
polygon(M, lty = 3, col = "blue", border = "orange", lwd = 3)
calc_area(M)

colnames(M) <- c("x", "y")
as.data.frame(M)

write.csv(as.data.frame(M), file = "coords.csv",
          row.names = FALSE,
          col.names = TRUE)

read.csv(file = "coords.csv", header = TRUE)

#-----------------------------------------------------------------------
# Dump e source de objetos.

args(baskara)
formals(baskara)
body(baskara)

baskara

args(hist.default)
formals(hist.default)
body(hist.default)
hist.default

dump("hist.default", file = "hist_default.R")
dump("baskara", file = "baskara.R")

dump("iris", file = "iris.R")

dput(iris)
str(iris)

iris$Species <- factor(iris$Species,
                       levels = c("versicolor", "virginica", "setosa"))

dput(levels(iris$Species))

source("baskara.R")
ls()

baskara(a = 0.5, b = -1, c = -10)

#-----------------------------------------------------------------------
