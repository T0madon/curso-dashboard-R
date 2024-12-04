library(shiny)

shinyServer(function(input, output) {

    FILTERED_DATA <- reactive({
        tb_filtered <- tb |>
            filter(sigla == input$UF_SEL) |>
            select(-sigla)
        tb_filtered
    })

    output$SCATTER_PLOT <- plotly::renderPlotly({
        tb_filtered <- FILTERED_DATA()
        gg_scatter <- ggplot(data = tb_filtered,
                             mapping = aes(x = renda, y = alfab)) +
            geom_point() +
            labs(title = "Renda x Alfabetismo",
                 x = "Renda",
                 y = "Alfabetismo") +
            theme_minimal()
        plotly::ggplotly(gg_scatter)
    })

    output$TOP_10 <- renderDataTable({
        tb_filtered <- FILTERED_DATA()
        # cat("------- tb_filtered -------\n")
        # print(tb_filtered)
        # cat("---------------------------\n")
        # tb_10 <- tb_filtered |>
        #     slice_max(order_by = alfab, n = 10)
        tb_10 <- tb_filtered |>
            arrange(desc(alfab))
        tb_10
    })

    output$BANDEIRA <- renderImage({
        img_path <- paste0("./bandeiras/", input$UF_SEL, ".png")
        filename <- normalizePath(img_path)
        list(src = filename)
    }, deleteFile = FALSE)

    output$CORRELACAO <- renderPrint({
        tb_filtered <- FILTERED_DATA()
        cor.test(tb_filtered$renda,
                 tb_filtered$alfab,
                 method = "spearman")
    })

    output$RENDA_AGG <- shinydashboard::renderValueBox({
        renda_agg <- median(FILTERED_DATA()$renda, na.rm = TRUE)
        shinydashboard::valueBox(
            value = renda_agg,
            subtitle = "Renda da UF (mediana)",
            icon = icon("credit-card"),
            color = "orange")
    })

    output$ALFAB_AGG <- shinydashboard::renderInfoBox({
        alfab_agg <- median(FILTERED_DATA()$alfab, na.rm = TRUE)
        shinydashboard::infoBox(
            title = "Alfabetismo UF (mediana)",
            value = alfab_agg,
            icon = icon("credit-card"),
            color = "orange")
    })

    output$MAPA <- googleVis::renderGvis({
        tb_sigla <- tibble::tibble(
            uf = c("São Paulo", "Minas Gerais", "Rio de Janeiro", "Bahia", "Paraná", "Rio Grande do Sul", "Pernambuco", "Ceará", "Pará", "Santa Catarina", "Maranhão", "Goiás", "Amazonas", "Espírito Santo", "Paraíba", "Rio Grande do Norte", "Mato Grosso", "Alagoas", "Piauí", "Distrito Federal", "Mato Grosso do Sul", "Sergipe", "Rondônia", "Tocantins", "Acre", "Amapá", "Roraima"),
            sigla = c("SP", "MG", "RJ", "BA", "PR", "RS", "PE", "CE", "PA", "SC", "MA", "GO", "AM", "ES", "PB", "RN", "MT", "AL", "PI", "DF", "MS", "SE", "RO", "TO", "AC", "AP", "RR")
        )
        i <- input$UF_SEL == tb_sigla$sigla
        googleVis::gvisGeoChart(data = tb_sigla[i, ],
                                locationvar = "uf",
                                options = list(region = "BR",
                                               displayMode = "regions",
                                               resolution = "provinces",
                                               defaultColor = "purple"))
    })
})
