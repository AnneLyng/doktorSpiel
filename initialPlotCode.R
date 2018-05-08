## Author: Anne Lyngholm Sørensen
## Description: plot code for the doktorSpiel

#Set up of the frame of the plot
#Define playing field
par(mar = rep(1,4), bg = "white")
xmax = 100
ymax = 100

# based on the prob for event 1 and event 2 the playing field changes
probEvent1 <- 1/4
probEvent2 <- 1/3
probDeath <- 1-probEvent1-probEvent2
xPoints <- c(0,xmax*probEvent1, xmax*(probEvent1+probDeath),xmax)
yPoints <- c(0, ymax, ymax,0)

# calculate boundaries (dependence on the placement of x and y)
lengthT1 <- xmax*probEvent1
slope1 <- ymax/lengthT1

lengthT2 <- xmax-xmax*(probEvent1+probDeath)
slope2 <- -ymax/lengthT2

# initial position
x <- sample(5:95, 1)
y <- 0
xInit <- x
yInit <- y
bound <<- 0

last9 = data.frame(x=rep(xInit,9),y=rep(yInit,9))
colScale = c("gray20", "gray25", "gray30", "gray40", "gray50",
             "gray60", "gray70", "gray80","white")

# Wait
# text(xmax/2,ymax/2, "GAME OVER", cex=5, col = "red")
# s <- ifelse(score == 1, "", "s")
# text(xmax/7.5,ymax, paste0(score, " Point", s), cex=3, col = "blue")

