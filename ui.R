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
cpi <- readRDS("./data/cpi.RDS")
weights <- readRDS("./data/weights.RDS")


sidebar <- dashboardSidebar(
  sidebarMenu(id = 'tabs',
              menuItem("Plot", tabName='plot', 
                       icon=icon("line-chart"),
                       selected=TRUE),
              menuItem('Weights', tabName = 'weights',
                       icon=icon('adjust')),
              menuItem("Calculator", tabName = "calculator",
                       icon = icon("calculator")),
              menuItem("ReadMe", tabName = "readme", 
                       icon=icon("mortar-board")),
              menuItem("About", tabName = "about", 
                       icon=icon("question"))
            
))


body <- dashboardBody(
<<<<<<< HEAD
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css",
              href = "custom.css")
=======
  tags$head(tags$style(HTML('
      .skin-blue .main-sidebar {
        background-color: #696969;
      }
      .skin-blue .sidebar-menu>li.active>a, .skin-blue .sidebar-menu>li:hover>a {
        background-color: #00008B;
      }
    '))
    # tags$link(rel = "stylesheet", type = "text/css",
    #           href = "custom.css")
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
  ),
  tabItems(
    tabItem(tabName = 'calculator',
            fluidPage(
              titlePanel("CPI Calculator"),
              sidebarLayout(
                sidebarPanel(
                  helpText("This app calculates the equivalent current dollars value of a basket of goods and services from any year between 1914-2018."),            
                  br(),            
                  selectInput("year1",
                              label = h6("What is the value of a basket of goods and services [$] in year:"),
                              choices = unique(cpi$Year),
                              selected = 1), 
                  
                  br(),            
                  numericInput("num_principal",
                               label = h6("that cost:"),
                               value = 100),
                  br(),            
                  selectInput("year2",
                              label = h6("in year:"),
                              choices = unique(cpi$Year),
                              selected = 2017)
                ),
                mainPanel(
                  tabsetPanel(
                    tabPanel("Output",
                             p(h5(tags$b("Result:"))),
                             textOutput("text_principal"),
                             br(),
                             p(h5(tags$b("Number of Years:"))),
                             textOutput("text_intrate"),
                             br(),
                             p(h5(tags$b("Per cent change (%):"))),
                             textOutput("text_num"),
                             br(),
                             p(h5(tags$b("Average Annual Rate of Inflation (%) / Decline in the Value of Money:"))),
                             textOutput("text_time"),
                             br(),
                             p(h5(tags$b("CPI for first year: "))),
                             textOutput("text_int"),
                             br(),
                             p(h5(tags$b("CPI for second year: "))),
                             textOutput("text_amt")
                    ),
                    tabPanel("Documentation",
                             p(h4("About the Inflation Calculator:")),
                             HTML(#"<u><b>Equation for calculation: </b></u>
                               "<br>The Inflation Calculator uses monthly consumer price index (CPI) data
                               from 1914 to the present to show changes in the cost of a fixed basket of consumer purchases.
                               These include food, shelter, furniture, clothing, transportation, and recreation. 
                               An increase in this cost is called inflation.
                               <br>
                               <br>
                               The calculator's results are based on the most recent month for which the CPI data are available. 
                               This will normally be about two months prior to the current month. <br>
                               ")                
                    )
                  )
                )
              )
            )
    ),
    tabItem(tabName = 'weights',
            fluidPage(
              titlePanel("Weights"),
              sidebarLayout(
                sidebarPanel(
                  selectInput('item2', 'CPI item(s)',
<<<<<<< HEAD
                              choices = unique(weights$Item),
                              selected = 'Food', multiple = FALSE),
                  
                  selectInput('geo2', 'Region(s)',
                              choices = unique(weights$Region),
                              selected = 'CAN', multiple = TRUE),
=======
                              choices = unique(weights$item),
                              selected = 'Meat', multiple = FALSE),
                  
                  selectInput('geo2', 'Region(s)',
                              choices = unique(weights$geo),
                              selected = 'Canada', multiple = TRUE),
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
                  
                  selectInput("showTable2", "Show Data As:",
                              choices = list("Chart", "Table", "Both"),
                              selected = "No")
                ),
                mainPanel(
                  conditionalPanel(
                    condition = "input.showTable2 != 'Table'",
<<<<<<< HEAD
                    box(  width = NULL, plotlyOutput("weights_plot",height="500px"), collapsible = TRUE,
                          title = "Plot", status = "primary", solidHeader = TRUE)
                    # plotOutput("weights_plot")
=======
                    plotOutput("weights_plot")
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
                  ),
                  
                  
                  conditionalPanel(
                    condition = "input.showTable2 != 'Chart'",
<<<<<<< HEAD
                    box(  width = NULL, DTOutput("weights_tbl",height="500px"), collapsible = TRUE,
                          title = "Table", status = "primary", solidHeader = TRUE)
                    # DTOutput("weights_tbl")
=======
                    DTOutput("weights_tbl")
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
                  )
                  
                )
              )
            )
    ),
    tabItem(tabName = "readme",
            withMathJax(),
            img(src="images/banner.png", width=1200),
            includeMarkdown("./ReadMe.Rmd")
    ),
    tabItem(tabName = "about",
            img(src="images/amigos.jpg", width=500),
            fluidPage(titlePanel("Authors:"), 
<<<<<<< HEAD
                      mainPanel(p(h4("- Atai Akunov / atai.akunov@gmail.com")), p(h4("- Liam Peet-Pare / l.peetpare@gmail.com")), p(h4("- Manolo Malaver-Vojvodic / mmala027@uottawa.ca"))))
=======
                      mainPanel(p(h4("Atai Akunov")), p(h4("Liam Peet-Pare")), p(h4("Manolo Malaver-Vojvodic"))))
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
    ),
    tabItem(tabName = 'plot',
           fluidPage(
             titlePanel("Consumer Prices Index (CPI)"),
             sidebarLayout(
               sidebarPanel(
                 selectInput('dataset', 'Choose Dataset', 
                             choices = c("Monthly CPI" = "1", "Month over month CPI growth" = "2",
                                         "Year over year CPI growth (monthly change)" = "3", "Yearly CPI" = "4",
                                          "Year over year CPI growth" = "5")),
                 uiOutput("item"),
                 uiOutput("date"),
                 uiOutput("geo"),
<<<<<<< HEAD
                 
                 selectInput("graphType", "Type of Chart:",
                             choices = list("Line Chart", 
=======
                 # selectInput("item","CPI Item(s)",
                 #             choices = unique(df$Item),
                 #             multiple = TRUE,
                 #             selected = 'Meat'
                 # ),
                 
                 
                 # THIS GIVES YOU REACTIVE UI
                 #numericInput("num", "Maximum slider value", 5),
                 #uiOutput("hierarchy"),
                 
                 # selectInput("geo","Region(s):",
                 #             choices = unique(df$Region),
                 #             multiple=TRUE,
                 #             selected = 'Canada'),
                 selectInput("graphType", "Type of Chart:",
                             choices = list("Line Chart", "Bar Chart",
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
                                            "Scatter Plot"),
                             selected = "Line Chart"),
                 selectInput("showTable", "Show Data As:",
                             choices = list("Chart", "Table", "Both"),
                             selected = "No"),
<<<<<<< HEAD
                
=======
                 # sliderInput("date",
                 #             label = "Select a range of years:",
                 #             min = min(df$t),
                 #             max = max(df$t),
                 #             value = c(min(df$t), max(df$t))),
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
                 downloadButton('export', 'Download')
                          ),
               
               mainPanel(
                 conditionalPanel(
                   condition = "input.showTable != 'Table'",
<<<<<<< HEAD
                   box(  width = NULL, plotlyOutput("lineChart",height="500px"), collapsible = TRUE,
                         title = "Plot", status = "primary", solidHeader = TRUE)
                   #plotlyOutput("lineChart", height = 580)
                 ),
                 conditionalPanel(
                   condition = "input.showTable != 'Chart'",
                   box(  width = NULL, DTOutput("tbl",height="500px"), collapsible = TRUE,
                         title = "Table", status = "primary", solidHeader = TRUE)
                   #DTOutput("tbl")
=======
                   plotOutput("lineChart")
                 ),
                 conditionalPanel(
                   condition = "input.showTable != 'Chart'",
                   DTOutput("tbl")
>>>>>>> 31ac5cbcfc588ccfa7c67f6a01ec476bc614f6ba
                 )
               )
             )
             )      
           )
          )
      
      )



dashboardPage(
  skin = 'blue',
  dashboardHeader(title = "CPI Dashboard"),
  sidebar,
  body
)