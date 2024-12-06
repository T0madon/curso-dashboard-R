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

UF_SEL <- "PI"

tb_filtered <- tb |>
  filter(sigla == UF_SEL) |>
  select(-sigla)

gg_scatter <- ggplot(data = tb_filtered, 
       mapping = aes(x = renda, y = alfab)) +
  geom_point() +
  labs(title = "Renda x Alfabetismo",
       x = "Renda",
       y = "Alfabetismo") +
  theme_minimal()

tb_10 <- tb_filtered |>
  slice_max(order_by = alfab , n = 10)

tb_cards <- 
  tb_filtered |>
    summarise(across(c("renda", "alfab"), ~median(., na.rm = TRUE)))

#img_path <- paste0("./imagens", UF_SEL, ".png")

img_path <- paste0("./imagens/", UF_SEL, ".png")


