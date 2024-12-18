library(shiny)

shinyUI(
    fluidPage(
        sidebarLayout(
            sidebarPanel(
                selectInput(
                    inputId = "UF_SEL",
                    label = "UF",
                    choices = UF_CHOICES,
                    selected = "SP"
                )
            ),
            mainPanel(
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