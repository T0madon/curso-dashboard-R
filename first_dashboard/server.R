setwd("~/UEPG - 3° ano/IC estatística/curso_R/first_dashboard")
library(shiny)
install.packages('googleVis')
library(googleVis)

shinyServer(function(input, output) {
    
    FILTERED_DATA <- reactive({
        tb_filtered <- tb |>
            filter(sigla == input$UF_SEL) |>
            select(-sigla)
        tb_filtered
    })
    
    output$SCATTER_PLOT <- renderPlot({
        tb_filtered <- FILTERED_DATA()
        
        gg_scatter <- ggplot(data = tb_filtered, 
                             mapping = aes(x = renda, y = alfab)) +
            geom_point() +
            labs(title = "Renda x Alfabetismo",
                 x = "Renda",
                 y = "Alfabetismo") +
            theme_minimal()
        gg_scatter
    })
    
    output$TOP_10 <- renderTable({
        tb_filtered <- FILTERED_DATA()
        tb_10 <- tb_filtered |>
            slice_max(order_by = alfab , n = 10)
        tb_10
    })
    
    output$BANDEIRA <- renderImage({
        img_path <- paste0("./imagens/", input$UF_SEL, ".png")
        filename <- normalizePath(img_path)
        list(src = filename, alt = "Bandeira do estado")
    }, deleteFile = FALSE)
    
    output$CARDS <- renderPrint({
        tb_filtered <- FILTERED_DATA()
        tb_cards <- tb_filtered |>
            summarise(across(c("renda", "alfab"), ~median(., na.rm = TRUE)))
        tb_cards
    })
    
    output$RENDA_AGG <- shinydashboard::renderValueBox({
        renda_agg <- median(FILTERED_DATA()$renda, na.rm = TRUE)
        shinydashboard::valueBox(
            renda_agg, 
            "Renda mediana do Estado", 
            icon = icon("credit-card"), 
            color = "orange")
    })
    
    output$ALFAB_AGG <- shinydashboard::renderInfoBox({
        alfab_agg <- median(FILTERED_DATA()$alfab, na.rm = TRUE)
        shinydashboard::infoBox(
            "Alfabetismo do Estado", 
            alfab_agg, 
            icon = icon("credit-card"), 
            color = "orange")
    })
    
    output$MAPA <- googleVis::renderGvis({
        
        tb_sigla <- tibble::tibble(
            uf = c("São Paulo", "Minas Gerais", "Rio de Janeiro", "Bahia", "Paraná", "Rio Grande do Sul", "Pernambuco", "Ceará", "Pará", "Santa Catarina", "Maranhão", "Goiás", "Amazonas"), 
            sigla = c("SP", "MG", "RJ", "BA", "PR", "RS", "PE", "CE", "PA", "SC", "MA", "GO", "AM"),)
        
        i <- input$UF_SEL == tb_sigla$sigla
        
        googleVis::gvisGeoChart(data = tb_sigla[i, ], 
                                locationvar = "uf", 
                                options = list(region = "BR", 
                                               displayMode = "regions", 
                                               resolution = "provinces",
                                               defautColor = "purple",
                                               width = 800,
                                               height = 800))
    })
    
})

