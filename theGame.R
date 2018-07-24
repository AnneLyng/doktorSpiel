## Author: Anne Lyngholm Sørensen
## Description: The game

# Introduction to the patients
output$textPatients <- renderText({
  "The game ends when all of the ten patients have a treatment regime 
  (no treatment is also a treatment regime) and are observed for a full year."
})

# Introduction to the score
output$textScore <- renderText({
  "Your score will be a cumulative score of 
  the number of days, that your patients 'survived'
  without experiencing stroke or bleeding."
})

# Introduction text and treatment dosis adjustment 
output$textIntroduction <- renderText({
  "Based on the initial starting point of the patient, do you wish to start treating the individual? \n
  If you start to treat the patient, you are able to adjust the dosis of the treatment."
})

addTooltip(session, id = "someInput", title = "This is an input.",
           placement = "left", trigger = "hover")

# Game instructions
output$textGame <- renderText({
  "Start the game by pressing start located to the left below the 
  slider. The purpose of the game is to treat the patient such that
  the patient will have either stroke or bleeding before their
  next consultation."
})

# set initial score
v <- reactiveValues(value1 = 0,newpatient = 0)

# new treatment per patient
output$newPatient <- reactive({
  return(input$startTreatment)
})

observeEvent(input$startTreatment, if (input$startTreatment){
  output$dosisSpan <- renderUI({
    div(style="height: 100px; width: 350px",
        sliderInput("dosisSpan", "Adjusting the treatment dosis",
                    min=0, max=100, value = 50, step = 1, ticks=TRUE))
  })}
)

# end of process per patient
output$endOfProcess <- reactive({
  returnedValue = (v$value1>0)
  return(returnedValue)
})

# end of process per patient
#output$startAgain <- reactive({
#  input$nReset
#})

outputOptions(output, "endOfProcess", suspendWhenHidden = FALSE)
outputOptions(output, "newPatient", suspendWhenHidden = FALSE)

output$value1 <- renderText({
  paste(v$value1)
})

output$nPat <- renderText({
  paste(v$newpatient)
})

output$gamePlot <- renderPlot({
  plot.new()
  plot.window(xlim = c(0, 100), ylim = c(0, 100))
  lines(xPoints, yPoints,type = "l", lwd = 1, col = "black")
  text(5,50,"Stroke", srt=70)
  text(90,50,"Bleeding", srt=300)
  text(50,100,"Survived process without treatment or stroke")
  
  # intial point
  # y <<- input$timeSpan
  # points(xInit, yInit, pch = 19, col="blue", cex = 2)
  #
  # last9 <<- rbind(c(x,y),last9[1:8,])
  # for (i in 9:1){
  #       points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 2)
  #       if (i == 9) points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 3)}
  #
  # x <<- x + sample(c(-1,1),1)
  #
  # points(x, y, pch = 4, col="black", cex = 1)
  
  # game play

  if(!exists("lasty")){
  y <<- input$timeSpan}
  #Sys.sleep(.025) # Pause screen. Reduce to increase speed
  
  # make trail
  if (bound != 1){
    last9 <<- rbind(c(x,y),last9[1:8,])
    for (i in 9:1){
      points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 2)
      if (i == 9) points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 3)}
    
    # keep the start position marked
    points(xInit, yInit, pch = 19, col="blue", cex = 2)
    
    # move meeple
    x <<- x + sample(c(-1,1),1)
    
    # indicate whether the bound was hit or not
    if (x <= y/slope1 | x >= xmax+y/slope2){
      bound <<- 1}
    
    # draw meeple
    points(x, y, pch = 4, col = "black", cex = 1)
    
    lines(xPoints, yPoints,type = "l", lwd = 1, col = "black")
    if(y == ymax | bound == 1) {points(x, y, pch = 19, col = "red", cex = 2)
      #score = y
      lasty <<- y
      observe({
        updateSliderInput(session, "timeSpan", value=lasty, max=lasty, step=NULL)
      })
      if(y == ymax){
        output$defaultSlider = renderUI({
          includeCSS('type2.css')
        })}
      else {output$defaultSlider = renderUI({
        includeCSS('type1.css')
      })}
      v$value1 <<- v$value1+lasty
      v$newpatient <<- v$newpatient + 1
    }} else {
      points(xInit, yInit, pch = 19, col="blue", cex = 2)
      for (i in 9:1){
        points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 2)
        if (i == 9) points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 3)}
      points(x, lasty, pch = 19, col = "red", cex = 2)
    }
}, height = 750)

observeEvent(input$nPatient, 
             {source("initialPlotCode.R")
             updateSliderInput(session, "timeSpan", value=0, max=ymax, step=NULL)
             output$defaultSlider = renderUI({
               includeCSS('type2.css')
             })
             rm(lasty,envir=globalenv())
              updateCheckboxInput(session, "startTreatment", value = FALSE)
             })

observeEvent(input$nAgain,
             output$gamePlot <- renderPlot({
               plot.new()
               plot.window(xlim = c(0, 100), ylim = c(0, 100))
               lines(xPoints, yPoints,type = "l", lwd = 1, col = "black")
               text(5,50,"Stroke", srt=70)
               text(95,50,"Bleeding", srt=300)
               text(50,100,"Survived process without treatment or stroke")
               
               # intial point
               # y <<- input$timeSpan
               # points(xInit, yInit, pch = 19, col="blue", cex = 2)
               #
               # last9 <<- rbind(c(x,y),last9[1:8,])
               # for (i in 9:1){
               #       points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 2)
               #       if (i == 9) points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 3)}
               #
               # x <<- x + sample(c(-1,1),1)
               #
               # points(x, y, pch = 4, col="black", cex = 1)
               
               # game play
               
               if(!exists("lasty")){
                 y <<- input$timeSpan}
               #Sys.sleep(.025) # Pause screen. Reduce to increase speed
               
               # make trail
               if (bound != 1){
                 last9 <<- rbind(c(x,y),last9[1:8,])
                 for (i in 9:1){
                   points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 2)
                   if (i == 9) points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 3)}
                 
                 # keep the start position marked
                 points(xInit, yInit, pch = 19, col="blue", cex = 2)
                 
                 # move meeple
                 x <<- x + sample(c(-1,1),1)
                 
                 # indicate whether the bound was hit or not
                 if (x <= y/slope1 | x >= xmax+y/slope2){
                   bound <<- 1}
                 
                 # draw meeple
                 points(x, y, pch = 4, col = "black", cex = 1)
                 
                 lines(xPoints, yPoints,type = "l", lwd = 1, col = "black")
                 if(y == ymax | bound == 1) {points(x, y, pch = 19, col = "red", cex = 2)
                   #score = y
                   lasty <<- y
                   observe({
                     updateSliderInput(session, "timeSpan", value=lasty, max=lasty, step=NULL)
                   })
                   if(y == ymax){
                   output$defaultSlider = renderUI({
                     includeCSS('type2.css')
                   })}
                   else {output$defaultSlider = renderUI({
                     includeCSS('type1.css')
                   })}
                   v$value1 <<- v$value1+lasty
                   v$newpatient <<- v$newpatient + 1
                 }} else {
                   points(xInit, yInit, pch = 19, col="blue", cex = 2)
                   for (i in 9:1){
                     points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 2)
                     if (i == 9) points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 3)}
                   points(x, lasty, pch = 19, col = "red", cex = 2)
                 }
}, height = 750))
