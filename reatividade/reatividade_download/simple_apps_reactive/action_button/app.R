library(shiny)

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
        verbatimTextOutput("TESTE_T")
    )
)

server <- function(input, output) {
    output$TESTE_T <- renderPrint({
        t.test(input$Y1, input$Y2)
    })
}

shinyApp(ui = ui, server = server)
