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
                     h1(strong("Comparing Win Rates")),
                     br(),
                     plotlyOutput("winrateplot")
                     
                   )
                 )
               ), 
               tabPanel("Champion Analysis",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput(inputId = "role1",
                                    label = "Choose a role:",
                                    choice = c("Top", "Jungle","Middle", "ADC", "Support")),
                            br(),
                            uiOutput("thirddropdown"),
                            br(),
                            uiOutput("fourthdropdown")
                          ),
                          
                          # Show a plot of the generated distribution
                          mainPanel(
                            plotlyOutput("winplot"),
                            br(),
                            plotlyOutput("banplot")
                          )
                        )
               ),
               tabPanel("Sid&Aman"),
               tabPanel("Contact us- Mahir")
             )
)