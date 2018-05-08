## Author: Anne Lyngholm Sørensen
## Description: The game

output$textGame <- renderText({
  "Hello Game. Looking good today"
})

output$gamePlot <- renderPlot({
  plot.new()
  plot.window(xlim = c(0, 100), ylim = c(0, 100))
  lines(xPoints, yPoints,type = "l", lwd = 5, col = "black")
  
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
    
    lines(xPoints, yPoints,type = "l", lwd = 5, col = "black")
    if(y == ymax | bound == 1) {points(x, y, pch = 19, col = "red", cex = 2)
      #score = y
      lasty <<- y
    }} else {
      points(xInit, yInit, pch = 19, col="blue", cex = 2)
      for (i in 9:1){
        points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 2)
        if (i == 9) points(last9$x[i], last9$y[i], pch = 19, col = colScale[i], cex = 3)}
      points(x, lasty, pch = 19, col = "red", cex = 2)
    }
}, height = 750)