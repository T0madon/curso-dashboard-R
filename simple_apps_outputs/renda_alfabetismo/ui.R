options(shiny.reactlog = TRUE)

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
                        shinydashboard::valueBoxOutput(
                            outputId = "RENDA_AGG")
                    ),
                    column(
                        width = 6,
                        shinydashboard::infoBoxOutput(
                            outputId = "ALFAB_AGG")
                    )
                ),
                fluidRow(
                    column(
                        width = 6,
                        # plotOutput(outputId = "SCATTER_PLOT")
                        plotly::plotlyOutput(outputId = "SCATTER_PLOT")
                    ),
                    column(
                        width = 6,
                        dataTableOutput(outputId = "TOP_10")
                    )
                ),
                fluidRow(
                    column(
                        width = 6,
                        htmlOutput(outputId = "MAPA")
                    ),
                    column(
                        width = 6,
                        imageOutput(outputId = "BANDEIRA")
                    )
                ),
                fluidRow(
                    column(
                        width = 12,
                        verbatimTextOutput(outputId = "CORRELACAO")
                    )
                )
            )
        )
    )
)
