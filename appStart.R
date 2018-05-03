## Author: Anne Lyngholm Soerensen (lynganne@gmail.com)
## Research assistant at the section of Biostatistics at the UniCopenhagen
## Date: 03-05-2018
## Description: This app contains the start page of the doktorSpiel game
# the player has to decide on a start-treatment for a class of patients
# the starting criteria will influence the treatment process of the patient

library(shiny)

uiStart <- fluidPage(
    # header
    headerPanel("doktorSpiel"),

    # Enter name etc.
    sidebarLayout(
        sidebarPanel(
            helpText("Please enter your name and an appropriate label:"),

            # Enter name
            textInput("text", label = "Your first name:"),

            # Enter label
            selectInput("label",
                        label = "Choose what you identify yourself with:",
                        choices = c("An aspiring doctor",
                                    "A doctor eager to learn more statistics",
                                    "An individual that just likes statistics"),
                        multiple=FALSE,
                        ),

            # Press Enter
            actionButton("go", "Start")
           ),
            
            # Main Panel (the text that will occur)
        mainPanel(
            htmlOutput("text")
            #textOutput("selected_var"),
            #textOutput("infotext",
            #               "The doktorSpiel was created for the purpose \n bla")
            )
    )
)

server <- function (input,output) {


    observeEvent(input$go,
                 output$text <- renderUI({
                     str1 <- paste("Dear ", input$text, ". Nice of
such ", tolower(input$label), " to try the doktorSpiel.", sep="")
                     str2 <- paste("The doktorSpiel was created for the purpose
of bla bla bla")
                     HTML(paste('<h3>',str1,'</h3>','<br/>',
                                str2,sep=''))
                 })
)
}

shinyApp(uiStart,server)    
    
