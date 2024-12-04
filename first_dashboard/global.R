setwd("~/UEPG - 3° ano/IC estatística/curso_R/first_dashboard")

library(tidyverse)
library(shiny)

tb <- read.csv2("renda_alfabetismo.csv")
str(tb)
