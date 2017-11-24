library("shiny")
library("shinythemes")

shinyUI <- fluidPage(title = "League Analysis", theme = shinytheme("spacelab"),
                     
                     mainPanel(
                       navbarPage(strong("League of Legends"),
                                  tabPanel("Tab1"),
                                  tabPanel("Tab2"),
                                  tabPanel("Tab3"),
                                  tabPanel("Tab4"))
                     )
)