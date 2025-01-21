#-----------------------------------------------------------------------
# ui.R

# Cria um arquivo para usar como teste.
# write.csv(iris, "iris.csv", row.names = FALSE)

library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Carregamento de arquivos"),
        sidebarLayout(
            sidebarPanel(
                fileInput(
                    inputId = "THEFILE",
                    label = "Selecione o arquivo",
                    accept = c(
                        "text/csv",
                        "text/comma-separated-values",
                        ".csv"
                    )
                ),
                checkboxInput(
                    inputId = "AVANCADO",
                    label = "Opções avançadas",
                    value = FALSE
                ),
                conditionalPanel(
                    "input.AVANCADO",
                    checkboxInput(
                        inputId = "HEADER",
                        label = "Cabeçalho",
                        value = TRUE
                    ),
                    radioButtons(
                        inputId = "SEPARATOR",
                        label = "Separador de campo",
                        choices = c(
                            "Vírgula" = ",",
                            "Ponto e vírgula" = ";",
                            "Tabulação" = "\t"
                        ),
                        selected = ","
                    ),
                    radioButtons(
                        inputId = "DECIMAL",
                        label = "Decimal numérico",
                        choices = c(
                            Ponto = ".",
                            Vírgula = ","
                        ),
                        selected = "."
                    ),
                    radioButtons(
                        inputId = "QUOTATION",
                        label = "Quote",
                        choices = c(
                            Nenhuma = "",
                            Dupla = '"',
                            Simples = "'"
                        ),
                        selected = '"'
                    )
                ),
                actionButton(
                    inputId = "RUN",
                    label = "Processar"
                ),
                hr(),
                selectInput(
                    inputId = "VARIABLE",
                    label = "Variável",
                    choices = "",
                    selected = ""
                ),
                downloadButton(
                    outputId = "DOWNLOADDATA",
                    label = "Download"
                )
            ),
            mainPanel(
                verbatimTextOutput("STEM")
            )
        )
    )
)
