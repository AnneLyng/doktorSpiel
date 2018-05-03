library(shiny)
library(shinydashboard)

dashboardPage(
    dashboardHeader(disable = T),
    dashboardSidebar(disable = T),
    dashboardBody(box(width=12,
                      tabBox(width=12, id="tabBox_next_previous",
                             tabelPanel("Introduction",
                                        p("Introduction to the doktorSpiel")),
                             tabelPanel("Initial treatment schemes",
                                        p("Inital treatment schemes for patients based on disease")),
                             tabelPanel("The game - treatment process simulator",
                                        p("The game"))
                             ),
                      uiOutput("NextPrevious")
                      )
                  )
)


