library(shiny)

tb <- tibble::tribble(
    ~time, ~uf, ~regiao,
    "Palmeiras", "SP", "Sudeste",
    "Corinthians", "SP", "Sudeste",
    "São Paulo", "SP", "Sudeste",
    "Flamengo", "RJ", "Sudeste",
    "Vasco", "RJ", "Sudeste",
    "Fluminense", "RJ", "Sudeste",
    "Grêmio", "RS", "Sul",
    "Internacional", "RS", "Sul",
    "Atlético-MG", "MG", "Sudeste",
    "Cruzeiro", "MG", "Sudeste",
    "Atlético-PR", "PR", "Sul",
    "Coritiba", "PR", "Sul",
    "Bahia", "BA", "Nordeste",
    "Vitória", "BA", "Nordeste",
    "Sport", "PE", "Nordeste",
    "Náutico", "PE", "Nordeste",
    "Ceará", "CE", "Nordeste",
    "Fortaleza", "CE", "Nordeste",
    "Goiás", "GO", "Centro-Oeste",
    "Vila Nova", "GO", "Centro-Oeste",
    "Avaí", "SC", "Sul",
    "Figueirense", "SC", "Sul",
    "Paysandu", "PA", "Norte",
    "Remo", "PA", "Norte",
    "Sampaio Corrêa", "MA", "Norte",
    "Moto Club", "MA", "Norte",
    "Botafogo", "RJ", "Sudeste",
    "Flamengo", "RJ", "Sudeste",
    "Santos", "SP", "Sudeste") |>
    dplyr::arrange(regiao, uf, time)
str(tb)

ui <- fluidPage(
    titlePanel("Times do Brasil"),
    sidebarLayout(
        sidebarPanel(
            selectInput(
                inputId = "REGIAO",
                label = "Região:",
                choices = unique(tb$regiao)
            ),
            selectInput(
                inputId = "UF",
                label = "Estado:",
                choices = unique(tb$uf)
            ),
            selectInput(
                inputId = "TIME",
                label = "Time:",
                choices = unique(tb$time)
            ),
            actionButton(
                inputId = "PROCESSAR",
                label = "Processar",
                icon = icon("play")
            )
        ),
        mainPanel(
            textOutput("REGIAO"),
            textOutput("UF"),
            textOutput("TIME")
        )
    )
)

server <- function(input, output) {
    output$REGIAO <- renderPrint({
        cat(input$REGIAO)
    })
    output$UF <- renderPrint({
        cat(input$UF)
    })
    output$TIME <- renderPrint({
        cat(input$TIME)
    })
}

shinyApp(
    ui = ui,
    server = server,
    options = list(display.mode = "showcase")
)

