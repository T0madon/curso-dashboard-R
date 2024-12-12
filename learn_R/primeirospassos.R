#-----------------------------------------------------------------------

# Comentário.
2 + 2

# Outro comentário.
2 *
    3 *
    4 *
    7

peso <- 83
altura <- 1.85
imc <- peso/altura^2

women
find("women")

ls()

ls("package:datasets")

women <- 123

women

datasets::women

search()

rm(imc)

imc
#-----------------------------------------------------------------------

ip <- installed.packages()
rownames(ip)

ip[1, ]

install.packages("EnvStats")

library(EnvStats)

u <- require(EnvStats)
u

u <- require(walmes)
u

library(walmes)

ls("package:EnvStats")

search()

remove.packages("EnvStats")

system.file(package = "EnvStats")

#-----------------------------------------------------------------------

library(EnvStats)

apropos("skew")
find("skewness")

help(skewness)

help.search("tukey")

RSiteSearch("hierarquical clustering")

browseVignettes(package = "survival")

str(iris)

help.start()

args(cor)

class(1:3)
methods(class = "nls")

example("skewness")
demo(plotmath)

#-----------------------------------------------------------------------

x <- c(1, 2, 3, NA, Inf)
sum(x)

is.na(x)
is.finite(x)

0/0
5/0

NULL

#-----------------------------------------------------------------------

v2 <- c(1, 3, 5, 6)
v1 <- c(3, 2, 1)
v1 * v2

v2 <- c(1, 3, 5, 6)
v1 <- c(1L, 3L)
typeof(v2)
typeof(v1)
typeof("R")
typeof(TRUE)

is.integer(v2)
is.integer(v1)

apropos("^is\\.")

as.logical(c(0, 1, 2, -1))
apropos("^as\\.")

x <- factor(c("BR", "NBR"))
class(x)

methods(class = "factor")

attributes(x)
levels(x)
nlevels(x)

#-----------------------------------------------------------------------

seq(1, 10, 2)
seq(by = 2, to = 10, from = 1)
seq(from = 1, to = 10, length.out = 7)
seq(from = 1, to = 10, along.with = c(8, 0, 3, 2))
seq(to = 10)

rep(c("a", "b", "c"), times = 4)
rep(c("a", "b", "c"), each = 4)

sample(1:10, size = 5, replace = TRUE, prob = c())
sample(1:3, size = 5, replace = TRUE, prob = c(0.1, 0.2, 0.7))

runif(5, min = 0, max = 1)
rnorm(10, mean = 170, sd = 15)

#-----------------------------------------------------------------------

notas <- c(João = 7.8,
           Bianca = 10,
           Eduarda = 8.5,
           Felipe = 7.0,
           Márcia = 6.5)
notas

notas[2]
notas[2:3]
notas[c(1, 5)]
notas[-2]
notas[-c(1, 5)]

notas["João"]
notas[c("João", "Bianca")]

notas[notas >= 7]
notas[notas >= 8]

notas[1] <- NA
notas

append(notas, c("Marcos" = 9, "Gisele" = 10), after = 2)

c(notas, 
  c("Marcos" = 9, "Gisele" = 10),
  c("André" = 2, "Pietro" = 3))

sort(notas)
sort(notas, decreasing = TRUE)

notas[sort(names(notas), decreasing = TRUE)]
notas[order(names(notas), decreasing = TRUE)]

notas
rev(notas)

#-----------------------------------------------------------------------

save.image(file = "meus_objstos.RData")

getwd()
setwd("~/Documents/Ômega/r_para_decolar")

load(file = "meus_objstos.RData")

altura
notas

save(notas, file = "notas.RData")
load("notas.RData")
notas

saveRDS(notas, "notas.rds")
notas <- readRDS("notas.rds")
notas

#-----------------------------------------------------------------------
# a * x^2 + b * x + c
a <- 0.25
b <- -1
c <- -3

(-b - sqrt(b^2 - 4 * a * c))/(2 * a)
(-b + sqrt(b^2 - 4 * a * c))/(2 * a)
 
(-b + c(-1, +1) * sqrt(b^2 - 4 * a * c))/(2 * a)

2 == 2
2 != 2

2/0
0/0

c(1, 2, 3, NA) + 10

is.numeric(10)
is.integer(2.5)

x <- c(2, 3, 4)
y <- c(10, 0, -10)
z <- c(-1, 5)
x * y

x * z

length(x)
length(z)

typeof(x)
typeof(z)

typeof(TRUE)
typeof("walmes")
typeof(factor("walmes"))

class(iris)
summary(iris)
summary(x)

typeof(2i)

as.integer("2")

apropos("^is\\.")
apropos("^as\\.")

notas <- c(João = 10L, Maria = 10L, Pedro = 8L, André = 7L)
class(notas)
typeof(notas)
attributes(notas)
str(notas)
names(notas)

seq(from = 1, to = 10, by = 2)
seq(by = 2, from = 1, to = 10)
seq(from = 1, to = 10, length.out = 13)
seq(from = 1, to = 10, along.with = c(1, 3, 2, 4))
seq(from = 1, by = 3, length.out = 20)
seq(to = 100, by = 3, length.out = 20)
seq(to = 10)

rep(c(1, 3, 4), times = 3)
rep(c(1, 3, 4), each = 3)

sample(1:10, size = 1)




notas <- c(João = 10,
           Maria = 10,
           Pedro = 8, 
           André = 7,
           Regina = 5,
           Julia = 6,
           Mateus = 3,
           Jorge = 5)
notas
notas[1]
notas[2]
notas[1:2]
notas[-1]
notas[-2]
notas[-c(1:2)]

"Pedro"
c("Pedro")

notas["João"]
notas["Pedro"]
notas[c("Pedro", "João")]

notas >= 7
notas[notas >= 7]

notas["João"] <- NA
notas
notas <- notas[-1]

notas[c("João", "Pedro")] <- c(10, NA)

append(notas,
       values = c("Lucas" = 10, "Larissa" = 10),
       after = 5)
# c(notas, c("Lucas" = 10, "Larissa" = 10))

notas
sort(notas)
sort(notas, decreasing = TRUE)
rev(notas)

mean(notas, na.rm = TRUE)
median(notas, na.rm = TRUE)
sd(notas, na.rm = TRUE)
min(notas, na.rm = TRUE)
max(notas, na.rm = TRUE)
length(notas)

sum(notas >= 7, na.rm = TRUE)

sort(names(notas))

ordem <- sort(names(notas))
notas[ordem]

sort(names(notas))
o <- order(names(notas))
notas[o]

notas <- notas * 10
notas

names(notas) <- toupper(names(notas))
notas

notas <- sort(notas, decreasing = TRUE)
notas

M <- matrix(1:9, ncol = 3, nrow = 3)
M

M[1, ]
M[, 1]
M[3, 3]
diag(M)
t(M)

l <- list(número = 2,
          verdadeiro = TRUE, 
          "frase legal" = "R é muito legal", 
          par = c(2, 3), 
          hoje = Sys.Date())
str(l)

l[[3]]
l[["par"]]

l[c(TRUE, FALSE, FALSE, TRUE, TRUE)]
l[1:2]
l[-(1:2)]

ls()
rm(a, b)

#-----------------------------------------------------------------------

install.packages("mcglm")
help(package = "mcglm")

vet <- c(3.62, 2.78, 2.42, 3.13, 2.64, 1.92, 1.97, 2.39, 3.61, 1.10)
mean(vet)
sd(vet)
median(vet)

1 + NA
5 + NULL

plot(1:10, 1:10)


matA <- matrix(c(1.56, 0.03, 1.57, 2.94), nrow = 2, byrow = TRUE)
matA
matB <- matrix(c(1.27, 2.48, 2.01, 0.01), nrow = 2, byrow = TRUE)
matB

matA * matB

install.packages("datasets")
library("datasets")
a <- datasets::airquality
a

mean(a[["Ozone"]], na.rm = TRUE)

b <- datasets::attenu
b
b[,c("event", "accel")]









