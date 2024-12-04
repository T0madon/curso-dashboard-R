# cat("-- ENTRANDO NO GLOBAL.R --\n")

library(tidyverse)

tb <- read_csv2("renda_alfabetismo.csv")
attr(tb, "spec") <- NULL
str(tb)

tb <- tb |>
    rename(sigla = 1,
           codigo = 2,
           municipio = 3,
           renda = 4,
           alfab = 5) |>
    select(-6)
str(tb)

UF_CHOICES <- tb$sigla |>
    unique()

# cat("-- SAINDO DO GLOBAL.R --\n")
