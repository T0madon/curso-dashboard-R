library(shiny)

# apropos("*Layout", ignore.case = TRUE)
# apropos("reactive", ignore.case = TRUE)

# list("inscritos" =
#          tibble::tribble(
#              ~nome, ~data,
#              "Bruce Wayne", "2020-01-01",
#              "Clark Kent", "2020-01-01",
#              "Barry Allan", "2020-01-02"
#          )
#      ) |>
#     writexl::write_xlsx(path = "inscritos.xlsx")

tb <- readxl::read_excel("inscritos.xlsx") |>
    dplyr::mutate(data = as.Date(data))

ui <- fluidPage(
    class = "container",
    titlePanel("Inscritos"),
    verticalLayout(
        fluidRow(
            column(
                width = 6,
                dataTableOutput("INSCRITOS")
            ),
            column(
                width = 6,
                plotly::plotlyOutput("PLOT")
            )
        )
    )
)

server <- function(input, output) {
    output$INSCRITOS <- renderDataTable({
        tb
    })
    output$PLOT <- plotly::renderPlotly({
        gg <- tb |>
            dplyr::count(data) |>
            ggplot2::ggplot(ggplot2::aes(x = data, y = n, group = 1)) +
            ggplot2::geom_line() +
            ggplot2::labs(title = "Inscritos por data",
                          x = "Data",
                          y = "Inscritos")
        plotly::ggplotly(gg)
    })
}

shinyApp(ui = ui, server = server)
