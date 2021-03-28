# Load R packages
library(ggplot2)
library(dplyr)
library(lubridate)
library(DT)
library(zoo)

# Read data
glucose <- read.csv("sirpi_glucose_data.csv")
glucose$Time <- as.POSIXct(glucose$Time,format="%Y-%m-%dT%H:%M:00Z", usetz = FALSE)
iris <- read.csv("sirpi_iris.csv")
crime <- read.csv("kaggle_crime_data_india-2001-2010.csv")

shinyServer(function(input, output, session) {
  
  output$Plot1 <- renderPlot({
    ggplot(df, aes(x=Time,y=Glucose)) + 
      geom_line() + 
      labs(title="Glucose vs Time", 
           y="Glucose")
  })
  
  output$Plot2 <- renderPlot({
    glucose %>%
      filter(glucose$Time>="2020-10-01 00:00:00 IST" & glucose$Time<"2020-10-02 00:00:00 IST" )%>%
      ggplot(aes(x=Time,y=Glucose)) +
      geom_line() + 
      labs(title="Glucose Levels on 1st October", 
           y="Glucose")
  })
  
  output$tabledata <- renderDataTable({
    datatable(
      glucose %>%
        mutate(date = date(Time)) %>%
        group_by(date) %>%
        summarize(mean_Glucose = round(mean(Glucose),digits = 0))
    )
  })
  
  output$Plot3 <- renderPlot({
    ggplot(iris, aes(x=sepal_length, y=sepal_width, color=species)) +
      geom_point(size=3)+
      labs(title="Iris plot", x="Sepal Length",color='Species',
           y="Sepal Width")
  })
  
  output$Plot4a <- renderPlot({
    crime %>%
      group_by(year) %>%
      summarize(
        n=sum(cases_property_stolen)
      ) %>%
      ggplot(aes(y=n))+
      geom_line(aes(x=year),color="red",size=3)+
      labs(title="Year wise trend of Property Stolen Cases",
           subtitle = "Data source: Kaggle",
           caption = "www.sirpi.io", x=" ",
           y="Total Cases")+
      scale_x_yearmon(format = "%Y",n = 8)
  })
  
  output$Plot4b <- renderPlot({
    crime %>%
      group_by(year) %>%
      summarize(
        n=sum(cases_property_recovered)
      ) %>%
      ggplot(aes(y=n))+
      geom_line(aes(x=year),color="#2B60DE",size=3)+
      labs(title="Year wise trend of Property Recovered Cases",
           subtitle = "Data source: Kaggle",
           caption = "www.sirpi.io", x=" ",
           y="Total Cases")+
      scale_x_yearmon(format = "%Y",n = 8)
  })
  
  output$Plot4c <- renderPlot({
    
    crime %>%
      filter(crime$area_name == "Andhra Pradesh" | crime$area_name == "Rajasthan" | crime$area_name == "Karnataka" | crime$area_name == "Punjab") %>%
      group_by(year,area_name) %>%
      summarize(
        n=sum(cases_property_recovered)
      ) %>%
      ggplot(aes(y=n))+
      geom_line(aes(x=year),color="#2B60DE",size=3)+
      labs(title="Year wise trend of Property Recovered Cases(AP,KA,PB,RJ)",
           subtitle = "Data source: Kaggle",
           caption = "www.sirpi.io", x=" ",
           y="Total Cases")+
      facet_wrap(~area_name,ncol = 2)+
      scale_x_yearmon(format = "%Y",n = 8)+
      theme_bw()+
      theme(strip.background =element_rect(fill="black"))+
      theme(strip.text = element_text(colour = 'white'))
  })
  
})