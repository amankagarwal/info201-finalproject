library("shiny")
library("plotly")

shinyUI <- fluidPage(title = "LoL Analysis",
                     
             navbarPage(strong("League of Legends"),
               tabPanel("Overview"),
               tabPanel("Player Analysis",
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
                     h3(strong("Overview")),
                     textOutput("playeroverview"),
                     br(),
                     h3(strong("Winrate Comparison")),
                     textOutput("winratedesc"),
                     br(),
                     plotlyOutput("winrateplot"),
                     br(),
                     br(),
                     br(),
                     textOutput("winrateconc"),
                     br(),
                     h3(strong("Player's Champion Pools")),
                     textOutput("playratedesc"),
                     br(),
                     plotlyOutput("p1champplot"),
                     plotlyOutput("p2champplot")
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
               tabPanel("TSM"),
               tabPanel("How to win more?",
                        mainPanel(
                          h3(strong("Overview")),
                          textOutput("corrbrief"),
                          br(),
                          h3(strong("Non-Competitive Games")),
                          plotOutput("noncompplot", height = 500),
                          br(),
                          textOutput("textnoncomp"),
                          br(),
                          h3(strong("Competitive Games")),
                          plotOutput("compplot", height = 500),
                          br(),
                          textOutput("textcomp"),
                          br(),
                          h3(strong("Conclusion")),
                          textOutput("corrconclusion"),
                          br()
                        )),
               tabPanel("Contact us- Mahir")
             )
)