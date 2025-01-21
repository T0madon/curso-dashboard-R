library(shiny)

options(shiny.reactlog = TRUE)

# list("inscritos" =
#          tibble::tribble(
#              ~nome, ~data,
#              "Bruce Wayne", "2020-01-01",
#              "Clark Kent", "2020-01-01",
#              "Barry Allan", "2020-01-02"
#          )
#      ) |>
#     writexl::write_xlsx(path = "inscritos.xlsx")

read_inscritos <- function(path, print_md5 = FALSE) {
    if (print_md5) {
        print(tools::md5sum(path))
    }
    tb <- readxl::read_excel(path) |>
        dplyr::mutate(data = as.Date(data))
    return(tb)
}
##' read_inscritos("inscritos.xlsx")

ui <- fluidPage(
    class = "container",
    titlePanel("Inscritos"),
    verticalLayout(
        fluidRow(
            column(
                width = 6,
                dataTableOutput("TABELA_INSCRITOS")
            ),
            column(
                width = 6,
                plotly::plotlyOutput("INSCRITOS_DIA")
            )
        ),
        fluidRow(
            column(
                width = 6,
                textOutput("NOVOS_INSCRITOS")
            )
        )
    )
)

server <- function(input, output, session) {
    RV <- reactiveValues(antes = 0, agora = 0, novos = 0)
    STREAM_DATA <- reactiveFileReader(
        intervalMillis = 1000,
        session = session,
        filePath = "inscritos.xlsx",
        readFunc = read_inscritos,
        print_md5 = TRUE
    )
    observe({
        n <- nrow(STREAM_DATA())
        RV$antes <- RV$agora
        RV$agora <- n
        cat("---\n",
            "antes: ", RV$antes,
            "\nagora: ", RV$agora,
            "\n", sep = "")
    })
    output$TABELA_INSCRITOS <-
        renderDataTable(
            expr = {
                STREAM_DATA()
            },
            options = list(pageLength = 5)
        )
    output$INSCRITOS_DIA <- plotly::renderPlotly({
        gg <- STREAM_DATA() |>
            dplyr::count(data) |>
            ggplot2::ggplot(ggplot2::aes(x = data, y = n, group = 1)) +
            ggplot2::geom_line() +
            ggplot2::labs(title = "Inscritos por data",
                          x = "Data",
                          y = "Inscritos")
        plotly::ggplotly(gg)
    })
    output$NOVOS_INSCRITOS <- renderPrint({
        if (RV$antes != RV$agora) {
            RV$novos <- RV$agora - RV$antes
            cat("Novos inscritos: ", RV$novos, "\n", sep = "")
        } else {
            cat("Novos inscritos: ", RV$novos, "\n", sep = "")
        }
    })
}

shinyApp(
    ui = ui,
    server = server,
    options = list(display.mode = "showcase")
)
