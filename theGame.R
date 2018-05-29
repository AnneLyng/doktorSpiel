## Author: Anne Lyngholm Sørensen
## Description: The game

# Introduction text and treatment dosis adjustment 
output$textIntroduction <- renderText({
  "Based on the initial starting point of the patient, do you wish to start treating the individual? \n
  If you start to treat the patient, you are able to adjust the dosis of the treatment."
})

observeEvent(input$startTreatment, if (input$startTreatment){
  output$dosisSpan <- renderUI({
    div(style="height: 100px; width: 350px",
        sliderInput("dosisSpan", "Adjusting the treatment dosis",
                    min=0, max=100, value = 50, step = 1, ticks=TRUE))
  })}
)

# Game instructions
output$textGame <- renderText({
  "Hello Game. Looking good today"
})


output$gamePlot <- renderPlot({
  plot.new()
  plot.window(xlim = c(0, 100), ylim = c(0, 100))
  lines(xPoints, yPoints,type = "l", lwd = 1, col = "black")
  
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
  y <<- input$timeSpan
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
    }} else {
      points(xInit, yInit, pch = 19, col="blue", cex = 2)
      for (i in 9:1){
        points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 2)
        if (i == 9) points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 3)}
      points(x, lasty, pch = 19, col = "red", cex = 2)
      observe({
        updateSliderInput(session, "timeSpan", value=lasty, step=NULL)
      })
    }
}, height = 750)
