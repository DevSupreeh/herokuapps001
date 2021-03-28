# Load R packages
library(shiny)
library(shinythemes)

fluidPage(
theme = shinytheme("flatly"),
                navbarPage(
                  "Shiny Application",
                  tabPanel("Question 1",
                           sidebarPanel(
                             tags$h2("Question 1"),
                             HTML("<br>Using sirpi_glucose_data.csv, Plot Glucose vs Time graph for the entire dataset.")
                             
                             
                           ), # sidebarPanel
                           mainPanel(
                             h1("Output"),
                             plotOutput(outputId = "Plot1")
                             
                           ) # mainPanel
                  ),
                  tabPanel("Question 2",
                           sidebarPanel(
                             tags$h2("Question 2"),
                             HTML("<br>For the given dataset (sirpi_glucose_data.csv) plot the Glucose Levels for 1st October")
                             
                             
                           ), # sidebarPanel
                           mainPanel(
                             h1("Output"),
                             plotOutput(outputId = "Plot2")
                             
                           ) # mainPanel
                  ),
                  tabPanel("Question 3",
                           sidebarPanel(
                             tags$h2("Question 3"),
                             HTML("<br>Calculate the average Glucose Level of the patient for each day in the dataset.")
                             
                             
                           ), # sidebarPanel
                           mainPanel(
                             h1("Output"),
                             dataTableOutput('tabledata')
                             
                           ) # mainPanel
                  ),
                  tabPanel("Question 4",
                           sidebarPanel(
                             tags$h2("Question 4"),
                             HTML("<br>Using sirpi_iris.csv plot the following graph")
                             
                             
                           ), # sidebarPanel
                           mainPanel(
                             h1("Output"),
                             plotOutput(outputId = "Plot3")
                             
                           ) # mainPanel
                  ),
                  tabPanel("Question 5",
                           sidebarPanel(
                             tags$h2("Question 5"),
                             HTML("<br>Using kaggle_crime_data_india-2001-2010.csv data plot the following graphs (3 sub parts)")
                             
                             
                           ), # sidebarPanel
                           mainPanel(
                             h1("Output"),
                             fluidRow(
                               splitLayout(cellWidths = c("50%", "50%"), plotOutput("Plot4a"), plotOutput("Plot4b"))
                             ),
                             fluidRow(
                               plotOutput(outputId = "Plot4c")
                             )
                             
                           ) # mainPanel
                  )
                )
)
