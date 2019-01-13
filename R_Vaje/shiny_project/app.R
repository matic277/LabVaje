#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# install.packages("DT")


library(DT)
library(shiny)




ui <- fluidPage(
   
   # title
  titlePanel("Google Play store, apps analysis"),
   
   # Sidebar with a slider input for number of bins 
  sidebarPanel(
    # Input: Specification of range within an interval ----
    sliderInput(
      "range",
      "Range:",
      min = 1,
      max = 5,
      value = c(3,4),
      step = 0.1
    )
    
  ),
  
  
  navbarPage(
    title = 'Tabs',
    tabPanel(
      'Slider for ratings',
      sliderInput("range", "Range:", min=1, max=5, value=c(3,4), step = 0.1),
      sliderValues("range")
    )
    
    
   # tabPanel('Tab2', )
  ),
  

  
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Table summarizing the values entered ----
    tableOutput("values")
    
  )
  
)




# Define server logic required to draw a histogram
server <- function(input, output) {
  
  sliderValues <- reactive({
    
    data.frame(
      Name = "Range",
      Value = as.character(c(paste(input$range, collapse = " "))),
      stringsAsFactors = FALSE
    )
    
  })

  
  output$sliderValues <- reactive({
    print(input$range)
  })
  
  
  
}







# Run the application 
shinyApp(ui = ui, server = server)

