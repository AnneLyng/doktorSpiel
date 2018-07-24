## Author: Anne Lyngholm Soerensen
## Description: The ui part of the R Shiny app for doktorSpiel

# libraries
library(shiny)
library(shinydashboard)
library(markdown)
library(shinyalert)
library(shinyBS)

# The dashboard settings
dashboardPage(
    dashboardHeader(disable = T),
    dashboardSidebar(disable = T),
    dashboardBody(box(width=12,
                      tabBox(width=12, id="tabBox_next_previous",
                             # tab 1 - introduction to the game
                             tabPanel("Introduction part 1",
                                      p(h3("Purpose of the doktorSpiel")),
                                      br(),
                                      sidebarLayout(
                                        sidebarPanel(
                                          helpText("Please enter your first name and
                                                   an appropriate label:"),

                                          # Enter name
                                          textInput("textName", label = "Your first name:"),

                                          # Enter label
                                          selectInput("label",
                                                      label = "Choose what you identify yourself 
                                                      with:",
                                                      choices = c("An aspiring doctor",
                                                                  "A doctor eager to learn 
                                                                  more statistics",
                                                                  "An individual that just 
                                                                  likes statistics"),
                                                      multiple=FALSE
                                          ),

                                          # Press Enter
                                          actionButton("go", "Start")
                                        ),

                                        # Main Panel (the text that will occur)
                                        mainPanel(
                                          htmlOutput("textParInfo"),
                                          br(),
                                          htmlOutput("textPurpose")
                                        ))
                                      ),
                             # tab 2 - the theory behind the game
                             tabPanel("Introduction part 2",
                                        p(h3("Elements of the doctorSpiel and an example")),
                                      fluidPage(uiOutput("textExample"))
                                      # needs to be included when go
                                      # is pressed
                                      ),
                             #tab 3 - the game
                             tabPanel("The game",
                                      p(h3("Play the doktorSpiel")),
                                      sidebarLayout(
                                        sidebarPanel(
                                          tags$head(tags$style("#container * {
                                                               display:inline;
                                                               }")),
                                          div(id="container",h4(textOutput("nPat"),style="display:inline"),
                                              h4(' out of 10 patients treated')),
                                          textOutput("textPatients"),
                                          bsTooltip(id = "someInput", title = "This is an input", 
                                                    placement = "left", trigger = "hover"),
                                          hr(),
                                          div(id="container",h4('Score: ',style="display:inline"), h4(textOutput("value1"))),
                                          textOutput("textScore"),
                                          hr(),
                                          h4("Treatment Setting"),
                                          textOutput("textIntroduction"),
                                          checkboxInput('startTreatment', 'Start treatment', value=FALSE),
                                          conditionalPanel(condition="output.newPatient",
                                                           uiOutput("dosisSpan")),
                                          hr(),
                                          h4("Run treatment plan"),
                                          textOutput("textGame"),
                                          includeCSS('type2.css'), # your initial look
                                          htmlOutput('defaultSlider'),
                                          div(style="height: 100px; width: 350px",
                                            sliderInput("timeSpan", "Running the treatment plan",
                                                    min=0, max=100, value = 0, step = 1,
                                                    animate = animationOptions(interval = 150,
                                                                               loop = FALSE,
                                                                               playButton="start",
                                                                               pauseButton="pause"),
                                                    ticks=TRUE
                                      )),
                                      div(id="container",conditionalPanel(condition="output.endOfProcess",
                                                                          actionButton("nPatient","Reset Treatment Setting"),
                                                                          style="display:inline"),
                                      conditionalPanel(condition="output.endOfProcess",
                                                       actionButton("nAgain","Fix Treatment Setting")))),

                                      # main panel for the process of the individual in the treatment
                                      mainPanel(div(plotOutput("gamePlot"),
                                                    style="width=100%; height: 750px")))
                                      ),
                             #tab 4 - treatment process simulator
                             tabPanel("Treatment process simulator",
                                      p("Investigate treatment schemes")),
                             tags$script("
                                         $('body').mouseover(function() {
                                         list_tabs=[];
                                         $('#tabBox_next_previous li a').each(function(){
                                         list_tabs.push($(this).html())});
                                         Shiny.onInputChange('List_of_tab', list_tabs);})
                                         "
                                         )
                             ),
                      uiOutput("Next_Previous")
                  ),
                  tags$head(
                    tags$script(src="disqus.js"),
                    tags$script("$(function() {$.fn.dataTableExt.errMode = 'none';});"),
                    tags$link(rel = "stylesheet",
                              type = "text/css",
                              href = "base.css")
                  )
    )
)