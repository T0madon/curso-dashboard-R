# Adaptado de https://rstudio.github.io/pool/.

library(shiny)
library(pool)
library(RSQLite)

# Faz a conexão.
con <- dbPool(RSQLite::SQLite(), dbname = "mtcars.sqlite3")

# Quando o R encerrar, fechar a conexão.
onStop(function() {
    poolClose(con)
})

# Função para verificar se a base de dados mudou.
db_check <- function(con) {
    cat(as.character(Sys.time()), "Consultando...\n")
    dbGetQuery(con, "SELECT COUNT(*) FROM mtcars")
}

# Função para ler a base de dados.
db_read <- function(con) {
    cat(as.character(Sys.time()), "Lendo...\n")
    dbGetQuery(con, "SELECT * FROM mtcars")
}

# Define o front-end.
ui <- fluidPage(
    titlePanel("Reactive Poll"),
    verticalLayout(
        dataTableOutput("DATABASE_TABLE")
    )
)

# Define a lógica no back-end.
server <- function(input, output, session){
    READ_DATA <- reactivePoll(
        intervalMillis = 2000,
        session = session,
        checkFunc = function() {
            db_check(con)
        },
        valueFunc = function() {
            db_read(con)
        })
    output$DATABASE_TABLE <- renderDataTable({
        tb <- READ_DATA()
        tb
    })
}

# Chama a aplicação.
shinyApp(ui = ui, server = server)
