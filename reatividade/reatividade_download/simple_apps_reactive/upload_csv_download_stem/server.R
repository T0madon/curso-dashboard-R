#-----------------------------------------------------------------------
# server.R

library(shiny)

if (!file.exists("mtcars.csv")) {
    write.csv(
        x = mtcars,
        file = "mtcars.csv",
        row.names = FALSE
    )
}

shinyServer(
    function(input, output, session) {

        FILEURL <-
            reactive({
                fileUploaded <- input$THEFILE
                if (is.null(fileUploaded)) {
                    return(NULL)
                } else {
                    return(fileUploaded$datapath)
                }
            })

        DATASET <-
            eventReactive(input$RUN, {
                fileurl <- FILEURL()
                if (is.null(fileurl)) {
                    return(NULL)
                } else {
                    dados <-
                        read.table(
                            fileurl,
                            header = input$HEADER,
                            sep = input$SEPARATOR,
                            quote = input$QUOTATION,
                            dec = input$DECIMAL
                        )
                    return(dados)
                }
            })

        observe({
            dados <- req(DATASET())
            updateSelectInput(
                session,
                inputId = "VARIABLE",
                choices = names(dados),
                selected = names(dados)[1]
            )
        })

        STEM <-
            reactive({
                req(input$VARIABLE)
                dados <- DATASET()
                y <- dados[, input$VARIABLE]
                if (is.numeric(y)) {
                    st <- capture.output(stem(y))
                    return(st)
                } else {
                    return(NULL)
                }
            })

        output$STEM <-
            renderPrint({
                cat(STEM(), sep = "\n")
            })

        output$DOWNLOADDATA <-
            downloadHandler(
                filename = function() {
                    "stem.txt"
                },
                content = function(file) {
                    cat(STEM(),
                        sep = "\n",
                        file = file
                        )
                }
            )
    } # function()
) # shinyServer()
