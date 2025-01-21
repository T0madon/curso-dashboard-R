library(shiny)

# Usar Ctrol + F3 para ver o grafo de reatividade.
options(shiny.reactlog = TRUE)

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

# Crias listas para faciliar a seleção de estados e times.
regiao_choices <- unique(tb$regiao)
uf_choices <- with(dplyr::distinct(tb, uf, regiao), split(uf, regiao))
time_choices <- with(tb,
                     split(time, paste(uf, regiao, sep = "_")))

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
            textOutput("TIME"),
            tableOutput("TABELA")
        )
    )
)

server <- function(input, output, session) {
    observeEvent(input$REGIAO, {
        updateSelectInput(
            session = session,
            inputId = "UF",
            choices = uf_choices[[input$REGIAO]]
        )
    })
    observeEvent(input$UF, {
        updateSelectInput(
            session = session,
            inputId = "TIME",
            choices = time_choices[[paste(input$UF, input$REGIAO, sep = "_")]]
        )
    })
    
    SELECTED_OPTIONS <-
        eventReactive(input$PROCESSAR, {
            list(
                regiao = input$REGIAO,
                uf = input$UF,
                time = input$TIME
            )
        })
    
    output$REGIAO <- renderPrint({
        cat(SELECTED_OPTIONS()$regiao)
    })
    output$UF <- renderPrint({
        cat(SELECTED_OPTIONS()$uf)
    })
    output$TIME <- renderPrint({
        cat(SELECTED_OPTIONS()$time)
    })
    output$TABELA <- renderTable({
        opts <- SELECTED_OPTIONS()
        tb |>
            dplyr::filter(regiao == opts$regiao) |>
            dplyr::filter(uf == opts$uf) |>
            dplyr::filter(time == opts$time)
    })
}

shinyApp(
    ui = ui,
    server = server,
    options = list(display.mode = "showcase")
)
