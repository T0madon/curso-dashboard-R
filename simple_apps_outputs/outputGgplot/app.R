library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Teste de habilidades de regressão"),
  sidebarLayout(
      sidebarPanel(
          sliderInput(inputId = "BETA_0",
                      label = "beta_0",
                      min = -25,
                      max = 25,
                      value = 0,
                      step = 1),
            sliderInput(inputId = "BETA_1",
                        label = "beta_1",
                        min = -3,
                        max = 8,
                        value = 0,
                        step = 0.1),
          selectInput(inputId = "COR",
                      label = "Cor dos pontos",
                      choices = c("blue", "red", "green", "yellow", "black"),
                      selected = "blue"),
          checkboxInput(inputId = "MOSTRA_AJUSTE",
                        label = "Mostrar linha de regressão",
                        value = FALSE)
      ),
      mainPanel(
          plotOutput("SCATTER_PLOT")
      )
  ) # sidebarLayout
)

server <- function(input, output) {
    output$SCATTER_PLOT <- renderPlot({
        gg <-
            ggplot(cars, aes(x = speed, y = dist)) +
            geom_point(color = input$COR, size = 2) +
            geom_abline(intercept = input$BETA_0,
                        slope = input$BETA_1,
                        color = "red")
        if (input$MOSTRA_AJUSTE) {
            gg <- gg +
                geom_smooth(method = "lm",
                            se = TRUE,
                            color = "black")
        }
        gg
    })
}

shinyApp(ui = ui, server = server)
