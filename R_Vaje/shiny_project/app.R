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

library("wordcloud")
library("RColorBrewer")

library("rio")
library("dplyr")
library("ggplot2")

library("stringi")
library("stringr")
library("lazyeval")

sourceDir = "C:/git/LabVaje/R_Vaje/shiny_project/data_resources/"
sourceDir = "C:/git/SQL-R/LabVaje/R_Vaje/shiny_project/data_resources/"

RawDataPath = paste(sourceDir, "googleplaystore.csv", sep="")
RawReviewsPath = paste(sourceDir, "googleplaystore_user_reviews.csv", sep="")

ProcessedDataPath = paste(sourceDir, "processedData.csv", sep="")
ProcessedReviewsPath = paste(sourceDir, "processedReviews.csv", sep="")

# raw data apps
# rdata = rio::import(file=RawDataPath, format="csv")
# processed data apps
data = rio::import(file=ProcessedDataPath, format="csv")

# raw reviews
# rrvs = rio::import(file=RawReviewsPath, format="csv")
# processed reviews
rvs = rio::import(file=ProcessedReviewsPath, format="csv")




ui <- navbarPage(
  "Google Play applications analysis",
  
  # rating tap
  tabPanel( "Select by rating",

    sidebarLayout(
      
      # input panel
      sidebarPanel(
        # element
        sliderInput(
          inputId = "rangeInput",
          h3("Select range:"),
          min = 1, max = 5,
          value = c(2,3),
          step = 0.1
        ),

        # element
        submitButton(
          "Show"
        )
      ), # end input panel

      mainPanel(
        DT::dataTableOutput(outputId="ratingSearch")
      )

    )
  ), # end rating tab
  
  # search tab
  tabPanel( "Search by name",
    
    sidebarLayout(
      
      sidebarPanel(
        
        # element in sidebar
        textInput(
          inputId = "nameInput",
          label = h3("Text input"),
          value = ""
        ),
        
        # element in sidebar
        submitButton(
          "Search"
        )
      ),
      
      mainPanel(
        DT::dataTableOutput(outputId="nameSearch")
      )
      
    )
  ), # end search tab
  
  # frequent words tab
  tabPanel( "Frequent Words",
    
    sidebarLayout(
      
      sidebarPanel(
        
        # element
        radioButtons(
          inputId = "radioInput",
          label = h3("Select criteria"),
          choices = list(
            "Apps names with most installs" = 1,
            "Frequent words in positive reviews" = 2,
            "Frequent words in neutral reviews" = 3,
            "Frequent words in negative reviews" = 4,
            "Draw Graphs" = 5
          ), 
          selected = 1
        ),
        
        # element
        submitButton(
          "Submit"
        )
      ),
      
      mainPanel(
        #renderDataTable("freqWords")
        DT::dataTableOutput(outputId="freqWords")
      )
      
    )
  ), # end frequent words tab
  
  # frequent words tab
  tabPanel( "Some plots",
            
            sidebarLayout(
              
              sidebarPanel(
                
                
              ),
              
              mainPanel= plotOutput(outputId="somePlots")
                #renderDataTable("freqWords")
               
              
              
            )
            
  ) # end frequent words tab
)

# ui <- fluidPage(
#   # Copy the line below to make a text input box
#   textInput("text", label = h3("Text input"), value = "Enter text..."),
#   
#   hr(),
#   fluidRow(column(3, verbatimTextOutput("value")))
# )

# Server -----------------------------------------------------------------------
server <- function(input, output, session) {
  
  # search by name
  output$nameSearch <- DT::renderDataTable({
    getAppsByName <- function(d, n) {
      #print(paste("Searching for apps that contain:", n, sep=" "))
      return(d %>% filter(grepl(n, d$App)))
    }
    r = getAppsByName(data, input$nameInput)
    datatable(r, options=list(dom='pt'))
  })
  
  # search by rating
  output$ratingSearch <- DT::renderDataTable({
    getAppsByRating <- function(d, n1, n2) {
      #print(paste("Searching for apps in range: [", n1, " ", n2, "]", sep=""))
      return(d %>% filter(d$Rating>=n1 & d$Rating<=n2))
    }
    r = getAppsByRating(data, input$rangeInput[1], input$rangeInput[2])
    datatable(r, options=list(dom='pt'))
  })
  
  # frequent words
  output$freqWords <- DT::renderDataTable({
    n = 5
    get_top_n <- function(d, n) {
      str = ""
      i = 0
      for (e in d) {
        str = paste(str, e, sep=", ")
        i = i + 1
        if (i == n) break
      }
      return(str)
    }
    
    occurences <- function(d) {
      allWords = c("")
      for (e in d) {
        split = str_split(e, " ")[[1]]
        allWords = combine(allWords, split)
      }
      # get a pair of word - num_of_occurrences and put it in a dataframe
      df = as.data.frame(table(allWords))
      colnames(df) = c("Word", "Freq")
      return(df %>% arrange(desc(Freq)))
    }
    
    # frequent words in apps by installs
    if (input$radioInput == 1) {
      data %>% select(App2, eInstalls) %>% group_by(eInstalls) %>% 
        summarise("Names"=get_top_n(App2, n)) %>% arrange(desc(eInstalls))
    }
    # positive reviews
    else if (input$radioInput == 2) {
      pos = rvs %>% filter(Sentiment=="Positive") %>% select(Sentiment, Translated_Review, App)
      posFreq = occurences(pos$Translated_Review)
      posFreq %>% top_n(50)
      
    }
    # neutral reviews
    else if (input$radioInput == 3) {
      neu = rvs %>% filter(Sentiment=="Neutral") %>% select(Sentiment, Translated_Review, App)
      neuFreq = occurences(neu$Translated_Review)
      neuFreq %>% top_n(50)
    }
    # negative reviews
    else if (input$radioInput == 4){
      neg = rvs %>% filter(Sentiment=="Negative") %>% select(Sentiment, Translated_Review, App)
      negFreq = occurences(neg$Translated_Review)
      negFreq %>% top_n(50)
    }
  })
  
  # some plots
  output$somePlots <- renderPlot({
    # count how many apps there are per group of installs
    d = data %>% select(eInstalls) %>% group_by(eInstalls) %>% summarise("num"=n()) %>% arrange(desc(eInstalls))
    ggplot(d, aes(x=factor(eInstalls), y=num)) + geom_bar(stat="identity", fill="green") + coord_flip() + 
      theme(plot.subtitle = element_text(vjust = 1), 
      plot.caption = element_text(vjust = 1), 
      axis.line = element_line(colour = "gray59", 
                               linetype = "solid"), axis.ticks = element_line(colour = "gray15"), 
      panel.grid.major = element_line(colour = "gray77"), 
      panel.grid.minor = element_line(colour = NA, 
                                      linetype = "blank"), axis.title = element_text(size = 12), 
      axis.text = element_text(size = 12, vjust = 0.4), 
      axis.text.x = element_text(size = 12), 
      axis.text.y = element_text(size = 12), 
      plot.title = element_text(size = 15, 
                                hjust = 0.5), panel.background = element_rect(fill = NA)) + 
      labs(title = "Number of apps per installations", 
            x = "Numer of installs", y = "Number of apps")
    
    # number of apps installed per category
    d = data %>% select(`Content Rating`, eInstalls) %>% group_by(`Content Rating`) %>% summarise("num"=n()) %>% arrange(desc(num))
    ggplot(d, aes(x=`Content Rating`, y=num)) + geom_bar(stat="identity") + 
      theme(plot.subtitle = element_text(vjust = 1), 
            plot.caption = element_text(vjust = 1), 
            axis.line = element_line(colour = "gray59", 
                                     linetype = "solid"), axis.ticks = element_line(colour = "gray15"), 
            panel.grid.major = element_line(colour = "gray77"), 
            panel.grid.minor = element_line(colour = NA, 
                                            linetype = "blank"), axis.title = element_text(size = 12), 
            axis.text = element_text(size = 12, vjust = 0.4), 
            axis.text.x = element_text(size = 12), 
            axis.text.y = element_text(size = 12), 
            plot.title = element_text(size = 15, 
                                      hjust = 0.5), panel.background = element_rect(fill = NA)) +
      labs(title = "Number of apps installed per category", 
           x = "Category", y = "Number of apps")
  })
  

}




# Run the application 
shinyApp(ui = ui, server = server)

