library("shiny")
library("plotly")

shinyUI <- fluidPage(title = "League Analysis",
                     
             navbarPage(strong("League of Legends"),
               tabPanel("Overview"),
               tabPanel("Player Win Rates",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput(inputId = "role",
                       label = "Choose a role:",
                       choice = c("Top", "Jungle","Middle", "ADC", "Support",
                       selected = "Middle")),
                     br(),
                     uiOutput("firstdropdown"),
                     br(),
                     uiOutput("seconddropdown")
                   ),
                   mainPanel(
                     h1(strong("Summary")),
                     br(),
                     textOutput("winratesummary"),
                     br(),
                     h1(strong("Comparing Win Rates")),
                     br(),
                     plotlyOutput("winrateplot")
                     
                   )
                 )
               ), 
               tabPanel("Sid"),
               tabPanel("Sid&Aman"),
               tabPanel("Contact us- Mahir")
             )
)