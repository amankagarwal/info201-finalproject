library("shiny")
library("plotly")
library("shinythemes")

shinyUI <- fluidPage(title = "LoL Analysis", theme = shinytheme('sandstone'),
                     
            tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
            ),
                     
             navbarPage("League of Legends",
               tabPanel("Project Overview"),
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
                     h2("Overview"),
                     textOutput("playeroverview"),
                     br(),
                     h2("Winrate Comparison"),
                     textOutput("winratedesc"),
                     br(),
                     plotlyOutput("winrateplot"),
                     br(),
                     br(),
                     br(),
                     textOutput("winrateconc"),
                     br(),
                     h2("Player's Champion Pools"),
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
               tabPanel("How to win more games?",
                        mainPanel(
                          h2("Overview"),
                          textOutput("corrbrief"),
                          br(),
                          h2("Non-Competitive Games"),
                          plotOutput("noncompplot"),
                          br(),
                          textOutput("textnoncomp"),
                          br(),
                          h2("Competitive Games"),
                          plotOutput("compplot"),
                          br(),
                          textOutput("textcomp"),
                          br(),
                          h2("Conclusion"),
                          textOutput("corrconclusion"),
                          br()
                        )),
               tabPanel("Sources/Contact Us")
             )
)