library(grDevices)
 
# Game parameters
score <- 0
high.score <- 0
 
# Define playing field
par(mar = rep(1,4), bg = "white")
plot.new()
xmax = 100
ymax = 100
plot.window(xlim = c(0, xmax), ylim = c(0, ymax))

# based on the prob for event 1 and event 2 the playing field changes
probEvent1 <- 1/4
probEvent2 <- 1/3
probDeath <- 1-probEvent1-probEvent2
xPoints <- c(0,xmax*probEvent1, xmax*(probEvent1+probDeath),xmax)
yPoints <- c(0, ymax, ymax,0)
lines(xPoints, yPoints,type = "l", lwd = 5, col = "black")
 
# initial position
x <- sample(5:95, 1)
y <- 0
xInit <- x
yInit <- y
points(x, y, pch = 19, col="blue", cex = 2)

last5 = data.frame(x=rep(xInit,9),y=rep(yInit,9))
colScale = c("gray20", "gray25", "gray30", "gray40", "gray50",
             "gray60", "gray70", "gray80","white")
bound = 0
# game play
while (y < ymax & bound == 0) {
    Sys.sleep(.025) # Pause screen. Reduce to increase speed

    if(y == 50){
        text(xmax/2,ymax/2, "50 months of treatment reached.\n
                             But probability of either event 1 or 2 has become larger.",
             cex=1, col = "red")
        Sys.sleep(5)
        plot.new()
        xmax = 100
        ymax = 100
        plot.window(xlim = c(0, xmax), ylim = c(0, ymax))

if(x > 50) {probEvent1 <- 1/3}
if(x <= 50) {probEvent2 <- 1/2}
probDeath <- 1-probEvent1-probEvent2
xPoints <- c(0,xmax*probEvent1, xmax*(probEvent1+probDeath),xmax)
yPoints <- c(0, ymax, ymax,0)
lines(xPoints, yPoints,type = "l", lwd = 5, col = "black")
points(xInit, yInit, pch = 19, col="blue", cex = 2)
    }
    # make trail
    last5 = rbind(c(x,y),last5[1:8,])
    for (i in 9:1){
        points(last5$x[i], last5$y[i], pch = 19, col = colScale[i], cex = 2)
    if (i == 9) points(last5$x[i], last5$y[i], pch = 19, col = colScale[i], cex = 3)}

    # keep the start position marked
    if (y < 11){
        points(xInit, yInit, pch = 19, col="blue", cex = 2)}

    # move meeple
    x <- x + sample(c(-1,1),1)
    y <- y + 1

    # calculate boundaries (dependence on the placement of x and y)
    lengthT1 = xmax*probEvent1
    slope1 = ymax/lengthT1

    lengthT2 = xmax-xmax*(probEvent1+probDeath)
    slope2 = -ymax/lengthT2

    # indicate whether the bound was hit or not
    if (x <= y/slope1 | x >= xmax+y/slope2){
        bound = 1}
    
    # draw meeple
    points(x, y, pch = 4, col = "black", cex = 1)
    
    lines(xPoints, yPoints,type = "l", lwd = 5, col = "black")
    if(y == ymax | bound == 1) {points(x, y, pch = 19, col = "red", cex = 2)
    score = y}
}

text(xmax/2,ymax/2, "GAME OVER", cex=5, col = "red") 
s <- ifelse(score == 1, "", "s")
text(xmax/7.5,ymax, paste0(score, " Point", s), cex=3, col = "blue") 
