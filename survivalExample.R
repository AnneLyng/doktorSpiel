library(shiny)
library(knitr)

rmdfiles <- c("example.Rmd")
sapply(rmdfiles, knit, quiet = T)

output$textExample <- renderUI({
  withMathJax(includeMarkdown("example.md"))
})
