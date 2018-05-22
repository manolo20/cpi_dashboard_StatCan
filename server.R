library(shinydashboard)
<<<<<<< HEAD
library(dplyr)
library(DT)
#library(openxlsx)
library(plotly)
library(ggplot2)

setwd("/home/atai/Downloads/CPI dashboard/CPI")
=======
library(tidyverse)
library(DT)
library(openxlsx)

setwd("/home/atai/Downloads/CPI dashboard/Prototype_1")
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
#datafiles <- readRDS("./data/choices.rda")
datafiles <- readRDS("./data/choices.RDS")
cpi <- readRDS('./data/cpi.RDS')
weights <- readRDS("./data/weights.RDS")
  
 shinyServer(function(input, output) {
  
   # CALCULATOR
   myfunction <- function(x){
     amount <- x %>% filter(Year == input$year1) %>% select(Value) 
     amount2 <- x %>% filter(Year == input$year2) %>% select(Value) 
     amount3 <- input$num_principal*amount2/amount
     return(as.character(amount3))
   }
   
   myfun <- function(x){
     amount <- x %>% filter(Year == input$year1) %>% select(Value) 
     amount2 <- x %>% filter(Year == input$year2) %>% select(Value) 
     amount3 <- input$num_principal*amount2/amount
     return(as.numeric(amount3))
   }
   
   yeardiff <- function(x){
     amo <- x %>% filter(Year == input$year1) %>% select(Year) 
     amo2 <- x %>% filter(Year == input$year2) %>% select(Year) 
     amo3 <- amo2-amo
     return(as.character(amo3))
   }
   
   year1 <- function(x){
     amo <- x %>% filter(Year == input$year1) %>% select(Value) 
     return(as.character(amo))
   }
   
   year2 <- function(x){
     amo <- x %>% filter(Year == input$year2) %>% select(Value) 
     return(as.character(amo))
   }
   
   perc <- function(x){
     amo <- x %>% filter(Year == input$year1) %>% select(Year) 
     amo2 <- x %>% filter(Year == input$year2) %>% select(Year) 
     amo3 <- amo2-amo
     return(as.character(amo3))
   }
   
   output$text_principal <- renderText({
     myfunction(cpi)
     #amount <- cpi %>% filter(Year == input$year1) %>% select(Value) %>% as.character()
   })
   
   output$text_num <- renderText({
     (myfun(cpi)/input$num_principal*100)-100
   })
   
   output$text_intrate <- renderText({
     yeardiff(cpi)
   })
   
   output$text_time <- renderText({
     ((as.numeric(year2(cpi))/as.numeric(year1(cpi)))^(1/as.numeric(yeardiff(cpi)))-1)*100
   })
   
   output$text_int <- renderText({
     year1(cpi)
   })
   
   output$text_amt <- renderText({
     year2(cpi)
   })
   
   #WEIGHTS
<<<<<<< HEAD
   output$weights_plot <- renderPlotly({
     df <- weights %>% filter(Region %in% input$geo2,Item == input$item2)
     
     graph <- ggplotly(
       ggplot(data = df, aes(y = Value, x = Region)) + 
       geom_col(aes(fill = Region), size = 1.5, alpha = 0.75) + 
       theme(text = element_text(size=10), axis.text.x = element_text( hjust = 1, vjust = .5)) +
       labs(x = "")+
       labs(y = "")+
       guides(fill=guide_legend(title="Region:")))
     print(graph)
   })
   

   
   output$weights_tbl <- renderDT({
     df <- weights %>% filter(Region %in% input$geo2,Item == input$item2)
=======
   output$weights_plot <- renderPlot({
     df <- weights %>% filter(geo %in% input$geo2,item == input$item2)
     
     graph <- ggplot(data = df, aes(y = value, x = geo)) + 
       geom_col(aes(fill = geo), size = 1, alpha = 0.75) + 
       theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5))
     
     print(graph)
   })
   
   output$weights_tbl <- renderDT({
     df <- weights %>% filter(geo %in% input$geo2,item == input$item2)
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
     
   })
   
   
   
  # PLOTS
   outVar <- reactive({
    temp <- datafiles[[as.numeric(input$dataset)]]
  })
  
<<<<<<< HEAD

=======
  
  output$date <- renderUI({
    sliderInput("date", "Select a date range:", min = min(outVar()$Date),
                max = max(outVar()$Date),
                value = c(min(outVar()$Date), max(outVar()$Date)))
  })
  
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
  output$item <- renderUI({
    selectInput("item","CPI Item(s):",
                choices = unique(outVar()$Item),
                multiple = TRUE,
<<<<<<< HEAD
                selected = 'All-items'
=======
                selected = 'Meat'
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
    )
  })
  
  output$geo <- renderUI({
    selectInput("geo", "Region(s):", choices = unique(outVar()$Region),
                multiple=TRUE,
                selected = 'CAN')
  })
    
<<<<<<< HEAD
  filters1 <- reactive({
    check <- outVar() %>%
      filter(Region %in% input$geo,
             Item %in% input$item
      )
  })
  
  output$date <- renderUI({
    if (is.null(input$item)){return()}
    if (is.null(input$geo)){return()}
    sliderInput("date", "Select a date range:", min = min(filters1()$Date),
                max = max(filters1()$Date),
                value = c(min(filters1()$Date), max(filters1()$Date)))
    
  })
  
  filtered <- reactive({
    if (is.null(input$date)) {
      return(NULL)
    } 
    check <- filters1() %>%
      filter(Date >= input$date[1],
=======
  filtered <- reactive({
     if (is.null(input$date)) {
       return(NULL)
     } 
    check <- outVar() %>%
      filter(Region %in% input$geo,
             Item %in% input$item,
             Date >= input$date[1],
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
             Date <= input$date[2]
      )
  })
  
<<<<<<< HEAD
  
=======
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
  output$tbl <- renderDT({
    filtered()
  })
  
  output$export <- downloadHandler(
      filename = function() {
        paste('plot_table', Sys.Date(), '.xlsx', sep='')
      },
      content = function(con) {
        write.xlsx(filtered(), con)
    })
    
<<<<<<< HEAD
  output$lineChart <- renderPlotly({
    if (is.null(filtered())) {
      return()
    }
    if (is.null(input$item)){return()}
    if (is.null(input$geo)){return()}
    
    df <- filtered()
    
   
    if (input$graphType == "Line Chart") {
      graph <- ggplotly( 
        ggplot(data=df, aes( y=Value, x=Date)) + 
        geom_line(aes(colour = Region:Item)) + 
        #ggtitle("Placeholder") +
        xlab("Date") + 
        ylab("Inflation Rate")) %>%
        layout(paper_bgcolor='#ecf0f5', plot_bgcolor='#ffffff',
          legend = list(
          orientation = "h",
          x = 0.5,
          y = -0.2))
    } 

    else {
      graph <-ggplotly( 
        ggplot(data=df, aes( y=Value, x=Date)) +
        geom_point(aes(colour = Region:Item), size=0.2) +
        #ggtitle("Placeholder") +
        xlab("Date") +
        ylab("Inflation Rate")) %>%
        layout(paper_bgcolor='#ecf0f5', plot_bgcolor='#ffffff',
          legend = list(
          orientation = "h",
          x = 0.5,
          y = -0.2))  
    }
    graph <- ggplotly(graph)
    return(graph)
=======
  output$lineChart <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    
    df <- filtered()
    
    if (input$graphType == "Line Chart") {
      graph <- ggplot(data=df,
                      aes( y=Value, x=Date))
      graph <- graph + geom_line(aes(colour = Region:Item), 
                                 size=1,alpha=.75) +
        ggtitle("Placeholder") +
        theme(text = element_text(size = 16, face = "bold"),
              plot.title = element_text(hjust = 0.5,
                                        size = 24,
                                        face = "bold")) +
              #legend.position = "bottom") +
        xlab("Date") + 
        ylab("Inflation Rate") + theme(plot.background = element_rect(fill = "#ebf9f6"))


    } else if (input$graphType == "Bar Chart") {
      graph <- ggplot(data=df,
                      aes( y=Value, x=Date))
      graph <- graph + geom_col(aes(fill = Region:Item),
                                size=1,alpha=.75,
                                position = "dodge") +
        ggtitle("Placeholder") +
        theme(text = element_text(size = 16, face = "bold"),
              plot.title = element_text(hjust = 0.5,
                                        size = 24,
                                        face = "bold")) +
        xlab("Date") +
        ylab("Inflation Rate")
    } else {
      graph <- ggplot(data=df,
                      aes( y=Value, x=Date))
      graph <- graph + geom_point(aes(colour = Region:Item), 
                                  size=1,alpha=.75) +
        ggtitle("Placeholder") +
        theme(text = element_text(size = 16, face = "bold"),
              plot.title = element_text(hjust = 0.5,
                                        size = 24,
                                        face = "bold")) +
        xlab("Date") +
        ylab("Inflation Rate")
    }
    print(graph)
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
  })
  

  
})
