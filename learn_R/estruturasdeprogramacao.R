setwd("~/UEPG - 3° ano/IC estatística/curso_R/learn_R")
#-----------------------------------------------------------------------
# Estruturas de programação e funções.
#-----------------------------------------------------------------------
# If-else 1.

u <- Sys.info()
str(u)
cat("Olá", u["user"], "! Vi que você usa", u["sysname"], "\n")

h <- as.integer(strftime(Sys.time(), "%H"))
# h <- 2

if (h >= 6 & h < 12) {
    saudacao <- "Bom dia!"
} else if (h >= 12 & h < 18) {
    saudacao <- "Bom tarde!"
} else if (h >= 18 & h < 23) {
    saudacao <- "Bom noite!"
} else {
    stop("Não enviar mensagem nesse horário!")
}

saudacao

#--------------------------------------------------------------------
# If-else 2.

# No: Acre, Alagoas, Amapá, Amazonas, Ceará,
# Espírito Santo, Maranhão Mato Grosso, Mato
# Grosso do Sul, Pará, Rio de Janeiro, Rio Grande
# do Norte, Rio Grande do Sul, Tocantins, Distrito
# Federal.
  #   Bahia, Paraíba.
  # Goiás, Minas Gerais, Rondônia, Roraima,
  # Santa Catarina, São Paulo, Sergipe.

estado <- "Sergipe"
estado <- "Rio de Janeiro"
estado <- "Bahia"
estado <- "Inglaterra"

grupo_em <- c("Goiás", "Minas Gerais", "Rondônia", "Roraima",
              "Santa Catarina", "São Paulo", "Sergipe")

# is.element(estado, grupo_em)
# estado %in% grupo_em
#
# if (estado == "Bahia" | estado == "Paraíba") {
#     msg <- paste(
#         "Estamos com uma super promoção para você que mora na",
#         estado)
# } else if (estado %in% grupo_em) {
#     msg <- paste(
#         "Estamos com uma super promoção para você que mora em",
#         estado)
# } else {
#     msg <- paste(
#         "Estamos com uma super promoção para você que mora no",
#         estado)
# }

grupo_na <- c("Bahia", "Paraíba")

if (is.element(estado, grupo_na)) {
    msg <- paste(
        "Estamos com uma super promoção para você que mora na",
        estado)
} else if (is.element(estado, grupo_em)) {
    msg <- paste(
        "Estamos com uma super promoção para você que mora em",
        estado)
} else {
    msg <- paste(
        "Estamos com uma super promoção para você que mora no",
        estado)
}

msg

#-------------------------------------------------------------------
# If-else 3.

argila <- 20
areia <- 70

if (argila > 60) {
    classe <- "Muito argilosa"
} else if (argila > 35) {
    classe <- "Argilosa"
} else if (areia < 15) {
    classe <- "Siltosa"
} else if (areia > 15 & areia < 70) {
    classe <- "Média"
} else {
    classe <- "Arenosa"
}

classe

#-------------------------------------------------------------------
# If-else 4.

salario <- 5000

if (salario < 1903) {
    tx <- 0
} else if (salario < 2826) {
    tx <- 7.5
} else if (salario < 3751) {
    tx <- 15
} else if (salario < 4664) {
    tx <- 22.5
} else {
    tx <- 27.5
}

tx

salario <- 3000
n_comp <- salario < c(0, 1903, 2826, 3751, 4664, Inf)
n_comp
n <- sum(n_comp)

switch(as.character(n),
       "1" = 27.5,
       "2" = 22.5,
       "3" = 15,
       "4" = 7.5,
       0)

findInterval(10000, c(0, 1903, 2826, 3751, 4664, Inf))

#------------------------------------------------------------------
# If-else vetorial.

salario_clientes <- c(2000, 10000, 5500, 7000, 1350)

ifelse(salario_clientes < 1903, 0,
       ifelse(salario_clientes < 2826, 7.5,
              ifelse(salario_clientes < 3751, 15,
                     ifelse(salario_clientes < 4664, 22.5,
                            27.5
                     )
              )
       )
)

dplyr::case_when(salario_clientes < 1903 ~ 0,
                 salario_clientes < 2826 ~ 7.5,
                 salario_clientes < 3751 ~ 15,
                 salario_clientes < 4664 ~ 22.5,
                 TRUE ~ 27.5)

ls()

#-----------------------------------------------------------------------
# Salvar arquivos da sessão.

save(salario_clientes, saudacao,
     file = "salarios_clientes.RData")
getwd()

saveRDS(salario_clientes,
        file = "salarios_clientes.rds")

save.image(file = "toda_sessao.RData")

#------------------------------------------------------------------
# For 1.

tx <- 0.01
n_meses <- 12
valor <- 100

for (i in 2:n_meses) {
    valor <- valor * (1 + tx)
    cat("Mes:", i, "\n")
    cat("Valor:", valor, "\n")
}

100 * (1 + tx)^11

#----------------------------------------------------------------
# For 2.

invest <- 100
juros <- c(5430, 4936, 4688,
           5183, 5430, 4668,
           5678, 5017, 4638)/(1000 * 100)
juros

i <- 0
for (j in juros) {
    invest <- invest * (1 + j)
    i <- i + 1
    cat("Mes: ", i,
        "; Taxa (%): ", j * 100,
        "; Valor: ", invest, "\n", sep = "")
}

x <- try(2 > 1)
x

x <- try(stop())
x

#----------------------------------------------------------------
# While 1.

n <- 10000
x0 <- 123 # Semente.
m <- 2^31 - 1
c <- 0
a <- 7^5
i <- 1

u <- numeric(n)
while (i <= n) {
    x1 <- (a * x0 + c) %% m
    u[i] <- x1/m
    i <- i + 1
    x0 <- x1
}

head(u)
hist(u)
plot(u)

set.seed(102030)
runif(10)

#--------------------------------------------------------------
# Repeat.

result <- 0
i <- 1
n <- 10000
repeat {
    s0 <- sample(1:6, size = 3, replace = TRUE)
    s1 <- sort(s0)
    s2 <- diff(s1)
    i <- i + 1
    if (i > n) break
    result <- result + as.integer(all(s2 == c(1, 1)))
}

result/n

#--------------------------------------------------------------
# Replicate.

u <- replicate(1000, {
    i <- 0
    repeat {
        s0 <- sample(1:6, size = 3, replace = TRUE)
        s1 <- sort(s0)
        s2 <- diff(s1)
        i <- i + 1
        if (all(s2 == c(1, 1))) break
    }
    i
})

mean(u)
hist(u)

#-----------------------------------------------------------
# Função · Baskara 1.

baskara <- function(a, b, c) {
    delta <- sqrt(b^2 - 4 * a * c)
    root <- (-b + c(-1, 1) * delta)/(2 * a)
    return(root)
}

a <- -1
b <- 1
c <- 5

r <- baskara(a = a, b = b, c = c)
r

curve(a * x^2 + b * x + c, from = -5, to = 5)
abline(h = 0, col = "red")
abline(v = r, col = "red")

r <- baskara(a = a, b = b, c = c)
r

#-----------------------------------------------------------------------
# Função · Baskara 2.

baskara <- function(a, b, c) {
    if (a == 0) {
        stop("`a` tem que ser diferente de 0!")
    }
    delta <- b^2 - 4 * a * c
    if (delta < 0) {
        stop("Função não tem raízes")
    }
    root <- (-b + c(-1, 1) * sqrt(delta))/(2 * a)
    return(root)
}

baskara(0, 1, 1)
baskara(1, 1, 1)
baskara(a, b, c)

mapply(a = c(-1, -1.1, -1.2),
       b = c(1, 1.1, 1),
       c = c(5, 4, 5),
       FUN = baskara)

#-----------------------------------------------------------------------
# Função · Baskara 3.

baskara <- function(vec) {
    if (length(vec) != 3) {
        stop("`vec` tem que ter 3 elementos!")
    }
    if (vec[1] == 0) {
        stop("`a` tem que ser diferente de 0!")
    }
    delta <- vec[2]^2 - 4 * vec[1] * vec[3]
    if (delta < 0) {
        stop("Função não tem raízes")
    }
    root <- (-vec[2] + c(-1, 1) * sqrt(delta))/(2 * vec[1])
    return(root)
}

baskara(c(a, b, c))

#--------------------------------------------------------------
# Função · Área de um triângulo.

M <- matrix(c(0, 0,
              0, 2,
              2, 0),
            byrow = TRUE,
            ncol = 2,
            nrow = 3)
plot(M, asp = 1)
polygon(M)

area_triangulo <- function(M) {
    M <- rbind(M, M[1, ])
    pos <- 0
    neg <- 0
    for (i in 1:3) {
        pos <- pos + M[i, 1] * M[i + 1, 2]
        neg <- neg + M[i + 1, 1] * M[i, 2]
    }
    area <- 0.5 * abs(pos - neg)
    return(area)
}

area_triangulo(M)

#-----------------------------------------------------------------------
