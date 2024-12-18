setwd("~/UEPG - 3° ano/IC estatística/curso_R/first_dashboard")
library(shiny)

shinyServer(function(input, output) {
  
  output$SCATTER_PLOT <- renderPlot({
    gg_scatter
  })
  
  output$TOP_10 <- renderTable({
    tb_10
  })
  
  output$BANDEIRA <- renderImage({
    filename <- normalizePath(img_path)
    list(src = filename, alt = "Bandeira do estado")
  }, deleteFile = FALSE)
  
  output$CARDS <- renderPrint({
    tb_cards
  })
  
})