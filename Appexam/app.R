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
                    choices = c("Male"= "male", "Female"= "female", "Both" = "b"))
    ),
    dashboardBody(
        column(width = 6,
               plotOutput("gender_plot")
               ),
        column(width = 6,
               tableOutput("table1")
               )
    )
)
    
server <- function(input, output, session) {
    df <- read.csv("train.csv")
    df$Survived <- as.factor(df$Survived)
    
    data_gender <- reactive({
        if(input$select_gender != "b"){
            d <- df %>% filter(Sex==input$select_gender) %>%
                group_by(Survived) %>% count()
        }else{
            d <- df %>% group_by(Survived) %>% count()
        }
        return (d)
    })
    
    output$gender_plot <- renderPlot({
        
        data_gender() %>% ggplot(aes(x = Survived, y = n, fill=Survived))+
            geom_col()+
            labs(x="Survived", y="Not Survived", title="Titanic Survived by Gender")+
            theme(plot.title = element_text(hjust=0.5))
    })
    
    output$table1 <- renderTable({
        head(df %>% select(Survived, Pclass, Sex, Age))
    })
    
}
shinyApp(ui, server)



