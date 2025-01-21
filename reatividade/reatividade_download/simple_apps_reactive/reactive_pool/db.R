#-----------------------------------------------------------------------
# Criando uma base de dados em disco.

library(DBI)
library(RSQLite)

str(mtcars)

# Criar um base de dados em disco.
file.remove("mtcars.sqlite3")

con <- dbConnect(RSQLite::SQLite(), dbname = "mtcars.sqlite3")
dbWriteTable(con,
             name = "mtcars",
             value = mtcars[1:3, ],
             overwrite = TRUE,
             append = FALSE)

# Confere.
dir(pattern = "*.sqlite3")

# Mostrar a tabela.
dbGetQuery(con,
           statement = "SELECT * FROM mtcars") |>
    str()

# Contar o número de linhas.
dbGetQuery(con, statement = "SELECT COUNT(*) FROM mtcars")

# Adicionar 2 linhas novas.
dbWriteTable(con,
             name = "mtcars",
             value = mtcars[1:2, ],
             append = TRUE)

# Contar o número de linhas.
dbGetQuery(
con, "SELECT COUNT(*) FROM mtcars")

# Fechar a conexão.
dbDisconnect(con)

#-----------------------------------------------------------------------
# Usar isso na aplicação.

# Conectar com a base de dados.
con <- dbConnect(RSQLite::SQLite(), "mtcars.sqlite3")

# Conferir as tabelas.
dbListTables(con)

# Fechar a conexão.
dbDisconnect(con)

#-----------------------------------------------------------------------
# Simples exemplo de como se conectar a um BD em MySQL.

# https://shiny.posit.co/r/articles/build/pool-dplyr/

pool <- pool::dbPool(
    drv = RMySQL::MySQL(),
    dbname = "shinydemo",
    host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
    username = "guest",
    password = "guest"
)
pool |>
    dplyr::tbl("City") |>
    head(5)

#-----------------------------------------------------------------------
