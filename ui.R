library(shiny)
library(shinydashboard)
library(markdown)

dashboardPage(
    dashboardHeader(disable = T),
    dashboardSidebar(disable = T),
    dashboardBody(box(width=12,
                      tabBox(width=12, id="tabBox_next_previous",
                             tabPanel("Introduction part 1",
                                      p(h3("Purpose of the doktorSpiel")),
                                      br(),
                                      sidebarLayout(
                                        sidebarPanel(
                                          helpText("Please enter your first name and an appropriate label:"),

                                          # Enter name
                                          textInput("textName", label = "Your first name:"),

                                          # Enter label
                                          selectInput("label",
                                                      label = "Choose what you identify yourself with:",
                                                      choices = c("An aspiring doctor",
                                                                  "A doctor eager to learn more statistics",
                                                                  "An individual that just likes statistics"),
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
                             tabPanel("Introduction part 2",
                                        p(h3("Elements of the doctorSpiel and an example"))
                                      # needs to be included when go
                                      # is pressed
                                      ),
                             tabPanel("The game - treatment process simulator",
                                      p("Investigate and adjust the treatment schemes
                                          depending on the process of the individual"),
                                      sidebarLayout(
                                        sidebarPanel(
                                          textOutput("textGame"),
                                          br(),
                                          div(style="height: 100px; width: 350px",
                                            sliderInput("timeSpan", "Running the treatment plan",
                                                    min=0, max=100, value = 0, step = 1,
                                                    animate = animationOptions(interval = 150,
                                                                               loop = FALSE,
                                                                               playButton="start",
                                                                               pauseButton="pause"),
                                                    ticks=TRUE
                                      ))),

                                      # main panel for the process of the individual in the treatment
                                      mainPanel(div(plotOutput("gamePlot"), style="width=100%; height: 750px")))
                                      ),
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
