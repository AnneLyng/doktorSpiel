library(shiny)

ui <- fluidPage(
    # header
    headerPanel("doktorSpiel"),

    # sidebar for adjusting the dosis
    sidebarPanel(),

    # main panel for the process of the individual in the treatment
    mainPanel(),

    # create action buttons (pause and play)
    actionButton("start","Start"),
    actionButton("pause","Pause")
    )

server <- function(input, output){
        
}

shinyApp(ui,server)

    

