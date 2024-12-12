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
