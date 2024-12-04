library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Teste de habilidade de regressão"),
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
                    value = FALSE),
    ),
    mainPanel(
      plotOutput("SCATTER_PLOT")
    )
  )
)

server <- function(input, output) {
  output$SCATTER_PLOT <- renderPlot({
    ggplot(cars, aes(x = speed, y = dist)) +
      geom_point(color = input$COR)
  })
}

str(cars)
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  theme_minimal()

shinyApp(
  ui = ui,
  server = server
)
 