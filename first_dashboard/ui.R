library(shiny)
library(shinydashboard)

shinyUI(
    fluidPage(
        sidebarLayout(
            sidebarPanel(
                selectInput(
                    inputId = "UF_SEL",
                    label = "UF",
                    choices = UF_CHOICES,
                    selected = "PR"
                )
            ),
            mainPanel(
                fluidRow(
                    column(
                        width = 6,
                        shinydashboard::valueBoxOutput("RENDA_AGG"),
                    ),
                    column(
                        width = 6,
                        shinydashboard::infoBoxOutput("ALFAB_AGG"),
                    )
                ),
                fluidRow(
                    column(
                        width = 6,
                        plotOutput("SCATTER_PLOT")
                    ),
                    column(
                        width = 6,
                        tableOutput("TOP_10")
                    )
                ),
                fluidRow(
                    column(
                        width = 6,
                        htmlOutput(outputId = "MAPA")
                    ),
                    column(
                        width = 6,
                        "Teste"
                    ),
                ),
                fluidRow(
                    column(
                        width = 6,
                        imageOutput("BANDEIRA")
                    ),
                    column(
                        width = 6,
                        verbatimTextOutput("CARDS")
                    ),
                )
            )
        )
    )
)