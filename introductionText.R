# Author: Anne Lyngholm Sørensen
# The introduction text
library(shiny)

observeEvent(input$go,
             output$textParInfo <- renderUI({
               str1 <- paste("Dear ", input$textName, ". Nice of
such ", tolower(input$label), ", like you, to try the doktorSpiel.", sep="")
               HTML(paste('<h3>',str1,'</h3>',sep=''))
             })
)

observeEvent(input$go,
             output$textPurpose <- renderUI({
               withMathJax(includeMarkdown("purpose.Rmd")) 
             })
)
