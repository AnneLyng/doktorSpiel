library(shiny)
library(shinydashboard)

PreviousButton <- tags$div(actionButton("Prev_Tab",HTML('
&lt;div class="col-sm-4"&gt;&lt;i class="fa fa-angle-double-left fa-2x"&gt;&lt;/i&gt;&lt;/div&gt;
')))
NextButton <- div(actionButton("Next_Tab",HTML('
&lt;div class="col-sm-4"&gt;&lt;i class="fa fa-angle-double-right fa-2x"&gt;&lt;/i&gt;&lt;/div&gt;
')))

shinyServer(function(input,output,session) {
    output$NextPrevious=renderUI({
    div(column(1,offset=1,PreviousButton),column(1,offset=8,NextButton})

