#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# install.packages("DT")

# install.packages("stringi")
# install.packages("stringr")
# 
# install.packages("ggplot2")
# install.packages("rio")
# install.packages("dplyr")
# install.packages("lazyeval")
# 
# install.packages("tm")
# install.packages("wordcloud")
# install.packages("RColorBrewer")
# install.packages("ggThemeAssist")
# install.packages("scales")

library("DT")
library("shiny")

library("scales")

library("gridExtra")

library("wordcloud")
library("RColorBrewer")

library("rio")
library("dplyr")
library("ggplot2")

library("stringi")
library("stringr")
library("lazyeval")
# 
# sourceDir = "C:/git/LabVaje/R_Vaje/shiny_project/data_resources/"
# sourceDir = "C:/git/SQL-R/LabVaje/R_Vaje/shiny_project/data_resources/"
# 
# RawDataPath = paste(sourceDir, "googleplaystore.csv", sep="")
# RawReviewsPath = paste(sourceDir, "googleplaystore_user_reviews.csv", sep="")
# 
# ProcessedDataPath = paste(sourceDir, "processedData.csv", sep="")
# ProcessedReviewsPath = paste(sourceDir, "processedReviews.csv", sep="")

# raw data apps
# rdata = rio::import(file=RawDataPath, format="csv")
# processed data apps
#data = rio::import(file=ProcessedDataPath, format="csv")

# raw reviews
# rrvs = rio::import(file=RawReviewsPath, format="csv")
# processed reviews
#rvs = rio::import(file=ProcessedReviewsPath, format="csv")

### IMPORTS 
data = rio::import("./processedData.csv", format="csv")
rvs = rio::import("./processedReviews.csv", format="csv")







joined = left_join(data, rvs)
joined = joined %>% filter(!is.na(Sentiment))





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
            "Frequent words in negative reviews" = 4
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
                # element
                radioButtons(
                  inputId = "radioInputPlots",
                  label = h3("Select criteria"),
                  choices = list(
                    "Number of apps per installation" = 1,
                    "Most frequent words in apps" = 3,
                    "Number of apps installed per category" = 4,
                    "Number of apps based on price" = 5,
                    "Sales based on category" = 6,
                    "Review length based on sentiment" = 7,
                    "Number of reviews based on categories" = 8,
                    "App name length based on installs" = 9,
                    "App name length based on installs boxplot" = 10,
                    "Number of installs and average price" = 11,
                    "Average price based on category" = 12,
                    "Reviews based on number of installs" = 13
                  ), 
                  selected = 1
                ),
                
                # element
                submitButton(
                  "Submit"
                )
              ),
              
              
              mainPanel(
                plotOutput(outputId="somePlots")
              )
               
              
              
            )
            
  ) # end frequent words tab
)




#------------- SERVER -------------------------------------------
server <- function(input, output, session) {
  
  # ----------- FUNCTIONS ---------------------------------------
  topn <- function(d, n) {
    freqWords = (
      d %>% select(Word, Freq) %>% 
      arrange(desc(Freq)) %>% 
      top_n(n)
    )$Word
    return(paste(freqWords, collapse=" "))
  }
  occurences <- function(d) {
    combined = paste(d, collapse=" ")
    allWords = str_split(combined, " ")[[1]]
    df = as.data.frame(table(allWords))
    colnames(df) = c("Word", "Freq")
    return(df)
  }
  priceRange <- function(d) {
    if (d == 0) return(0)
    else {
      prices = c(0.5, 1, 1.5, 2, 2.5, 3, 4, 5, 10, 20, 300, 350)
      for(p in prices) if (d < p) return(p)
      return(400)
    }
  }
  
  #---------------- SEARCH BY NAME TAB --------------------------
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
  
  
  
  #--------------------- FREQ WORDS TAB ---------------------------
  output$freqWords <- DT::renderDataTable({
    n = 5
    # frequent words in apps by installs
    if (input$radioInput == 1) {
      data %>% select(eInstalls, App) %>% group_by(eInstalls) %>% summarise("TopWords"=topn(occurences(App), 10))
    }
    # positive reviews
    else if (input$radioInput == 2) {
      pos = rvs %>% filter(Sentiment=="Positive") %>% select(Sentiment, Translated_Review, App)
      posFreq = occurences(pos$Translated_Review)
      posFreq %>% arrange(desc(Freq)) %>% top_n(50)
    }
    # neutral reviews
    else if (input$radioInput == 3) {
      neu = rvs %>% filter(Sentiment=="Neutral") %>% select(Sentiment, Translated_Review, App)
      neuFreq = occurences(neu$Translated_Review)
      neuFreq %>% arrange(desc(Freq)) %>% top_n(50)
    }
    # negative reviews
    else if (input$radioInput == 4){
      neg = rvs %>% filter(Sentiment=="Negative") %>% select(Sentiment, Translated_Review, App)
      negFreq = occurences(neg$Translated_Review)
      negFreq %>% arrange(desc(Freq)) %>% top_n(50)
    }
  })
  
  #--------------------- SOME PLOTS TAB ----------------------------------------------
  output$somePlots <- renderPlot({
    # count how many apps there are per group of installs
    if (input$radioInputPlots == 1) {
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
    }
    # most frequent words in apps
    else if (input$radioInputPlots == 3) {
      #occurences(data$App2)
      d = occurences(data$App2)
      wordcloud::wordcloud(words = d$Word, freq = d$Freq, min.freq = 1,
                           max.words=300, random.order=FALSE, rot.per=0.0, 
                           colors=brewer.pal(8, "Set1"))
    }
    # number of apps installed per category
    else if (input$radioInputPlots == 4) {
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
    }
    # prices and categories, 2 graphs side by side
    else if (input$radioInputPlots == 5) {
      r = data %>% select(ePrice) %>% rowwise() %>% mutate("Price2"=priceRange(ePrice)) %>% arrange(desc(Price2))
      r = r %>% select(Price2) %>% group_by(Price2) %>% summarise("num"=n()) %>% arrange(num)
      r = r[r$Price2 != 0, ]
      
      g1 = ggplot(r, aes(x=Price2, y=num)) + geom_bar(stat="identity", width=5) + 
        theme(plot.subtitle = element_text(vjust = 1), 
        plot.caption = element_text(vjust = 1), 
        panel.grid.major = element_line(colour = "gray47"), 
        panel.grid.minor = element_line(colour = "gray80", 
                                        linetype = "blank"), axis.title = element_text(size = 15), 
        axis.text = element_text(size = 14), 
        axis.text.x = element_text(size = 14), 
        plot.title = element_text(size = 14), 
        panel.background = element_rect(fill = NA)) +labs(x = "Price group", y = "Number of apps")
      
      rr = data %>% select(ePrice) %>% rowwise() %>% mutate("Price2"=ifelse(ePrice==0, "Free", "Costs"))
      rr = rr %>% group_by(Price2) %>% summarise("count"=n())
      
      g2 = ggplot(rr, aes(x=factor(Price2), y=count)) + geom_bar(stat="identity", width = 0.1) + 
        theme(plot.subtitle = element_text(vjust = 1), 
              plot.caption = element_text(vjust = 1), 
              panel.grid.major = element_line(colour = "gray47"), 
              panel.grid.minor = element_line(colour = "gray80", 
                                              linetype = "blank"), axis.title = element_text(size = 15), 
              axis.text = element_text(size = 14), 
              axis.text.x = element_text(size = 14), 
              plot.title = element_text(size = 14), 
              panel.background = element_rect(fill = NA)) +labs(x = "Price group", y = "Number of apps")
      
      gridExtra::grid.arrange(g2, g1, ncol=2)
    }
    # which category made most money
    else if (input$radioInputPlots == 6) {
      d = data %>% select(Category, Sales) %>% group_by(Category) %>% summarise("sum"=sum(Sales), "count"=n()) %>% arrange(desc(sum))
      ggplot(d, aes(x=factor(Category), y=sum)) + geom_bar(stat="identity") + coord_flip() + theme(plot.subtitle = element_text(vjust = 1), 
      plot.caption = element_text(vjust = 1), 
      panel.grid.major = element_line(colour = "gray67"), 
      panel.grid.minor = element_line(linetype = "blank"), 
      axis.text.y = element_text(size = 8), 
      panel.background = element_rect(fill = NA)) +labs(x = "Category", y = "Ammount of money")
    }
    # review length based on sentiment
    else if (input$radioInputPlots == 7) {
      rvs = rvs %>% mutate("Length"=nchar(Translated_Review))
      d = rvs %>% select(Sentiment, Length) %>% group_by(Sentiment) %>% summarise("avg"=mean(Length))
      ggplot(d, aes(x=Sentiment, y=avg, fill=Sentiment)) +
        geom_bar(stat="identity") +
        scale_fill_manual(values=c("#CC0000", "#e0e0e0", "#00C851")) +
        geom_hline(yintercept=mean(d$avg), col="blue") + 
        theme(plot.subtitle = element_text(vjust = 1), 
              plot.caption = element_text(vjust = 1), 
              panel.grid.major = element_line(colour = "gray83"), 
              panel.grid.minor = element_line(colour = "snow3"), 
              panel.background = element_rect(fill = NA)) +labs(y = "Average length")
    }
    # reviews and installs
    else if (input$radioInputPlots == 8) {
      d = joined %>% select(Category, Sentiment) %>% group_by(Category, Sentiment) %>% 
        summarise("count"=n()) %>% arrange(desc(count))
      
      ggplot(data=d, aes(x=factor(Category), y=count, fill=Sentiment)) + 
        geom_bar(stat="identity") + coord_flip() +
        scale_fill_manual("legend", values=c("Positive"="#00C851", "Neutral"="#e0e0e0", "Negative" = "#CC0000")) +
        ylab("Number of reviews") + xlab("Number of installs") + 
        theme(plot.subtitle = element_text(vjust = 1), 
         plot.caption = element_text(vjust = 1), 
         panel.grid.major = element_line(colour = "lavender"), 
         panel.grid.minor = element_line(linetype = "blank"), 
         axis.text = element_text(size = 11), 
         axis.text.y = element_text(size = 9, 
          vjust = 0.3), plot.title = element_text(size = 10, 
          hjust = 0.5), legend.text = element_text(size = 12), 
         legend.title = element_text(size = 13), 
         panel.background = element_rect(fill = NA, 
         linetype = "twodash"), legend.background = element_rect(fill = NA)) +labs(title = "Reviews and Installs")
    }
    # app name length based on installs
    else if (input$radioInputPlots == 9) {
      r = data %>% select(NameRangeLen, eInstalls) %>% group_by(eInstalls) %>% summarise("len"=mean(NameRangeLen)) %>% arrange(desc(eInstalls))
      #r$eInstalls <- factor(r$eInstalls, levels = r$eInstalls[order(r$len, decreasing = TRUE)])
      ggplot(r, aes(x=eInstalls, y=len, group=1)) + geom_line(colour="red", size=1.5) + geom_point(colour="black", size=1.5) + 
        theme(plot.subtitle = element_text(vjust = 1), 
        plot.caption = element_text(vjust = 1), 
        panel.grid.major = element_line(colour = "gray88", 
        linetype = "blank"), panel.grid.minor = element_line(colour = "lightsteelblue"), 
        axis.title = element_text(size = 13), 
        plot.title = element_text(size = 15, 
        hjust = 0.5), panel.background = element_rect(fill = NA)) +labs(title = "App name length and installs") + 
        scale_x_continuous(labels = comma)+labs(x = "Number of installs", y = "Length of name")
    }
    # installs and app name length boxplot
    else if (input$radioInputPlots == 10) {
      ggplot(data, aes(x=factor(eInstalls), y=NameRangeLen)) + 
        geom_boxplot(fill='#56B4E9', color="black") + coord_flip() + 
        theme(plot.subtitle = element_text(vjust = 1), 
        plot.caption = element_text(vjust = 1), 
        panel.grid.major = element_line(colour = "gray75"), 
        axis.title = element_text(size = 12), 
        axis.text.x = element_text(size = 12, 
        vjust = 0), axis.text.y = element_text(vjust = 0.4), 
        plot.title = element_text(size = 14, 
        hjust = 0.5), panel.background = element_rect(fill = NA)) +labs(title = "Number of installs and app name length", 
        x = "Number of installs", y = "Length of app name")
    }
    # installs and average price
    else if (input$radioInputPlots == 11) {
      # see how price and installs correlate
      d1 = data %>% select(eInstalls, ePrice) %>% group_by(eInstalls) %>% summarise(avg=mean(ePrice)) %>% arrange(desc(eInstalls))
      ggplot(d1, aes(x=factor(eInstalls), y=avg, fill=avg)) + geom_bar(stat="identity") + coord_flip()
    }
    # average prices based on categories
    else if (input$radioInputPlots == 12) {
      d1 = data %>% select(Category, ePrice) %>% group_by(Category) %>% summarise(avg=mean(ePrice)) %>% arrange(desc(avg))
      ggplot(d1, aes(y=avg, x=Category)) + 
        geom_bar(stat="identity") +
        geom_hline(yintercept=mean(d1$avg), col="red") + 
        geom_text(aes(-1,1,label = 1.8, vjust = -1)) +
        coord_flip() +
        ggtitle("Price by Category") + 
        ylab("Average Price") + xlab("Category")
    }
    # reviews based on number of installs
    else if (input$radioInputPlots == 13) {
      d2 = joined %>% select(eInstalls, Sentiment) %>% group_by(eInstalls, Sentiment) %>% summarise("sum"=n()) %>% arrange(desc(eInstalls))
      ggplot(data=d2, aes(x=factor(eInstalls), y=sum, fill=Sentiment)) + 
        geom_bar(stat="identity") +
        scale_fill_manual("legend", values=c("Positive"="#00C851", "Neutral"="#e0e0e0", "Negative" = "#CC0000")) +
        ylab("Number of reviews") + xlab("Number of installs") + theme(plot.subtitle = element_text(vjust = 1), 
        plot.caption = element_text(vjust = 1), 
        panel.grid.major = element_line(colour = "gray80"), 
        panel.background = element_rect(fill = NA))
      
    }
    # 
    else if (input$radioInputPlots == 14) {
      
    }
    # 
    else if (input$radioInputPlots == 15) {
      
    }
    
   
  })



  
  
  
  
  
  
  # !!!!
  # put in another tabs for printing tables
  output$someTables <- DT::renderDataTable({
    if (input$radioInputPlots == 1) {
      # see which apps made most money
      data %>% select(App, Sales) %>% group_by(App) %>% 
        summarise("Sales"=max(Sales), "SalesOut"=formatC(Sales, format="f", big.mark=",", digits=0)) %>% 
        arrange(desc(Sales))
    }
    # most expensive apps
    else if (input$radioInputPlots == 2) {
      data %>% select(App, App2, ePrice, eInstalls) %>% filter(ePrice>300)
    }
    # apps that made most money
    else if (input$radioInputPlots == 3) {
      data %>% select(App, Sales) %>% group_by(App) %>% 
        summarise("Sales"=max(Sales), "SalesOut"=formatC(Sales, format="f", big.mark=",", digits=0)) %>% 
        arrange(desc(Sales))
    }
  })
  
  
  
  

}




# Run the application 
shinyApp(ui = ui, server = server)

