#--------------------------------------------------------------

f <- 0
s <- 0
q <- 0
g <- 0

while(1){
  dados <- sample(1:6, size = 5, replace = TRUE)
  print(dados)
  if(all(dados == 6)){
    break
  }
  i <- i + 1
}

dados <- sample(1:6, size = 5, replace = TRUE)
dados
dados <- sort(dados)
dados
diff(dados)

r <- numeric(10)
r
for (x in 1:10){
    y <- (2*x)+(2^x)
    r <- c(r, y)
}
r

#--------------------------------------------------------------
vet <- numeric(100)

for (i in 1:100){
  if(i%%2 == 0){
    vet[i] <- i*i
  } else {
    vet[i] <- i^3
  }
}
vet[45]



