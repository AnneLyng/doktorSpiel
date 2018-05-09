## Author: Anne Lyngholm Sørensen
## Description: The server set-up for the doktorSpiel

# Libraries
library(shiny)
library(shinydashboard)
library(grDevices)

# source the inital settings for the doktorSpiel plot
source("initialPlotCode.R")

# Create Previous and Next buttons and specific look in HTML code
Previous_Button <- tags$div(actionButton("Prev_Tab",HTML('<div class="col-sm-4"><i class="fa fa-angle-double-left fa-2x"></i></div>')))
Next_Button <- div(actionButton("Next_Tab",HTML('<div class="col-sm-4"><i class="fa fa-angle-double-right fa-2x"></i></div>')))

# The server input, output and session info
shinyServer(function(input,output,session) {
  # settings for all of the tabs (previous and next buttons)
  source('NextPreviousButtons.R',local=TRUE)

  # The introduction tab (create text from the input that the player enters)
  source('introductionText.R',local=TRUE)
  
  # The surivial theory with examples
  # source('survivalTheoryAndExample.R',local=TRUE)
    
  # The game tab
  source('theGame.R',local=TRUE)
})

