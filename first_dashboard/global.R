setwd("~/UEPG - 3° ano/IC estatística/curso_R/first_dashboard")

library(tidyverse)
library(shiny)

tb <- read.csv2("renda_alfabetismo.csv")
str(tb)

attr(tb, "spec") <- NULL

tb <- tb |>
  rename(
    sigla = 1,
    codigo = 2,
    municipio = 3,
    renda = 4,
    alfab = 5) |>
  select(-6)
str(tb)

UF_CHOICES <- tb$sigla |>
  unique()


