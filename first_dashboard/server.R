setwd("~/UEPG - 3° ano/IC estatística/curso_R/first_dashboard")
library(shiny)

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
    
})