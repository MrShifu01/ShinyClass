library(shiny)
library(shinydashboard)


ui <- dashboardPage(
    dashboardHeader(
        title = "Titanic Analytics"
    ),
    dashboardSidebar(),
    dashboardBody()
)
    
server <- function(input, output, session) {
}
shinyApp(ui, server)



