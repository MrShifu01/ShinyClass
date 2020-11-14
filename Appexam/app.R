library(shiny)
library(shinydashboard)
library(ggplot2)
library(tidyverse)


ui <- dashboardPage(
    dashboardHeader(
        title = "Titanic Analytics"
    ),
    dashboardSidebar(
        selectInput(inputId = "select_gender", label = "Select Gender:",
                    choices = c("Male"= "male", "Female"= "female"))
    ),
    dashboardBody(
        plotOutput("gender_plot")
    )
)
    
server <- function(input, output, session) {
    df <- read.csv("train.csv")
    df$Survived <- as.factor(df$Survived)
    
    data_gender <- reactive({
        d <- df %>% filter(Sex==input$select_gender) %>%
            group_by(Survived) %>% count()
        return (d)
    })
    
    output$gender_plot <- renderPlot({
        
        data_gender() %>% ggplot(aes(x = Survived, y = n, fill=Survived))+
            geom_col()+
            labs(x="Survived", y="Not Survived", title="Titanic Survived by Gender")+
            theme(plot.title = element_text(hjust=0.5))
    })
}
shinyApp(ui, server)



