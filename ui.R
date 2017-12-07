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
                     p("In this tab, we calculate the win-rates of all players who have played competitive league of legends games between
                      2015 and 2017. From the dropdown menus on the left, the user can select the two players whose's win-rate he/she wants
                      to compare. Also, we compare the champions the selected players have played on the basis of the number
                      of games played on each champion."),
                     br(),
                     h2("Winrate Comparison"),
                     p("This plot compares the win-rates for the two selected players. Also, the use of a stacked bar plot enables us to compare
                      the win-rates for each player on the basis of the side they play on- blue or red."),
                     br(),
                     plotlyOutput("winrateplot"),
                     br(),
                     br(),
                     br(),
                     p("Generally, we can see a trend that the win-rate on the blue side is higher than the win-rate on the red side. This supports
                     the fact that most teams opt to play on the blue side when given the option."),
                     br(),
                     h2("Player's Champion Pools"),
                     p("The two plots below display the number of games each player has played on respective champions between 2015 and 2017."),
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
                          p("We plan to find what objectives affect the outcome of the game the most. Also, we use correlation matrices to compare
                          the different correlations and try to know the difference between a competitive game and a non-competitive game."),
                          br(),
                          h2("Non-Competitive Games"),
                          plotOutput("noncompplot"),
                          br(),
                          p("From this plot, we can observe that there is decent correlation between winning the games and getting
                          objectives such as towers, and inhibitors. However, there is one interesting observation. The correlation
                          of winning a game and getting a baron is lower as compared to the correlation with getting Dragons. This
                          is indeed surprising because baron is the strongest objective in the game, and usually can turn the tide towards
                          a team."),
                          br(),
                          h2("Competitive Games"),
                          plotOutput("compplot"),
                          br(),
                          p("Just like the correlation matrix plot for the non-competitive games, we can observe a strong correlation between winning
                          games and getting objectives such as towers and inhibitors. However, there is one major difference which we can observe-
                          the correlation between winning and getting baron is much higher, and similar to getting dragons. This is more consistent
                          with the logic of the game. Moreover, in competitive games all teams and players play much more seriously and focus to get
                          objectives in the game to win. Once a team gets baron, which is the strongest objective in the game, it's less likely that
                          they will throw away the lead, thus the higher correlation."),
                          br(),
                          h2("Conclusion"),
                          p("From this analysis, we can conclude that non-competitive games mostly depend on getting objectives such as turrets and
                          inhibitors. Barons and dragons don't have as big an influence as these objectives have, so don't lose hope if you lose
                          a baron or drake! In order to win more games, you should concentrate in getting turrets, and pushing lanes in order to get
                          inhibitors!"),
                          br()
                        )),
               tabPanel("Sources/Contact Us")
             )
)