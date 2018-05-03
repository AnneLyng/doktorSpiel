## Author: Anne Lyngholm Soerensen (lynganne@gmail.com)
## Research assistant at the section of Biostatistics at the UniCopenhagen
## Date: 03-05-2018
## Description: This app contains the main application. It is expected that the user will
# have entered some start arguments/conditions under which the next lines of
# codes will be generated. 

library(shiny)

uiMain <- fluidPage(
    # header
    headerPanel("doktorSpiel"),
    
    # sidebar for adjusting the dosis
    sidebarLayout(
        sliderInput("timeSpan", "Running the treatment Plan",
                    min=0, max=100, value = 1, step = 5,
                    animate = animationOptions(interval = 300,
                                               loop = TRUE,
                                               playButton="start",
                                               pauseButton="pause")
    ),

    # main panel for the process of the individual in the treatment
    mainPanel())

    # create action buttons (pause and play)
    )

server <- function(input, output){
        
}

shinyApp(ui,server)
