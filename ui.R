library("shiny")
library("shinythemes")
source("scripts/win-rate-comparison.R")
shinyUI <- fluidPage(title = "League Analysis", theme = shinytheme("spacelab"),
                     
                     mainPanel(
                       navbarPage(strong("League of Legends"),
                                  tabPanel("Overview"),
                                  tabPanel("Player Win Rates",
                                           sidebarLayout(
                                             sidebarPanel(
                                               selectInput(inputId = "role",
                                                           label = "Choose a role:",
                                                           choice = c("Top", "Jungle","Middle", "ADC", "Support",
                                                                      selected = "Middle")),
                                             
                                               uiOutput("firstdropdown"),
                                               
                                               uiOutput("seconddropdown")
                                             ),
                                               mainPanel(
                                                 plotlyOutput("winrateplot")
                                               )
                                           )
                                  ), 
                                  tabPanel("Sid"),
                                  tabPanel("Sid&Aman"),
                                  tabPanel("Contact us- Mahir"))
                     )
)