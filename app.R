library(shiny)
library(datasets)
library(ggplot2)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

ui <- fluidPage(
  
  titlePanel("Miles Per Gallon"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      
      checkboxInput("outliers", "Show outliers", TRUE)
      
    ),
    
    mainPanel(
      
      h3(textOutput("caption")),
      
      plotOutput("mpgPlot")
      
    )
  )
)

server <- function(input, output) {
 
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  output$caption <- renderText({
    formulaText()
  })
  
  output$mpgPlot <- renderPlot({
    ggplot(mpgData,aes(x=mpg)) + 
    geom_histogram(binwidth = 5,colour="black",fill="white") + 
      facet_wrap(input$variable, ncol = 1)
    
  })
  
}

