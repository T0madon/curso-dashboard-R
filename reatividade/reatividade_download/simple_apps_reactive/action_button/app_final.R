library(shiny)

# # Retorna `Error:`.
# req("")
# req(NULL)
# req(FALSE)
#
# # Retorna o que recebe.
# req(TRUE)
# req("AKJSALKJS")
# req(100)
#
# need("", "Valor recebido é inválido")
# need(NULL, "Valor recebido é inválido")
# need(FALSE, "Valor recebido é inválido")
#
# tb <- data.frame(nome = "Shiny", nota = 10)
# tb <- matrix()
# tb <- list("valor" = TRUE)
# validate(
#     if (!is.data.frame(tb)) "Não é data.frame",
#     if (nrow(tb) == 0) "Não tem conteúdo",
#     if (!"nome" %in% names(tb)) "Não tem coluna nome",
# )

ui <- fluidPage(
    titlePanel("Teste t"),
    verticalLayout(
        textAreaInput(
            inputId = "Y1",
            label = "Amostra 1",
            placeholder =  "8.90; 10.12; 9.34; etc"
        ),
        textAreaInput(
            inputId = "Y2",
            label = "Amostra 2",
            placeholder =  "8.90; 10.12; 9.34; etc"
        ),
        actionButton(
            inputId = "PROCESSAR",
            label = "Processar",
            icon = icon("cog")
        ),
        verbatimTextOutput("TESTE_T")
    )
)

server <- function(input, output) {
    RUN_TEST <- eventReactive(input$PROCESSAR, {
        req(input$Y1, input$Y2)
        y1 <- strsplit(input$Y1, split = ";")[[1]] |>
            as.numeric()
        y2 <- strsplit(input$Y2, split = ";")[[1]] |>
            as.numeric()
        t.test(y1, y2)
    })
    output$TESTE_T <- renderPrint({
        print(RUN_TEST())
    })
}

shinyApp(
    ui = ui,
    server = server,
    options = list(display.mode = "showcase")
)
