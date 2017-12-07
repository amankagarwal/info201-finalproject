library("shiny")
library("plotly")
library("shinythemes")

shinyUI <- fluidPage(title = "LoL Analysis", theme = shinytheme('sandstone'),
                     
            tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
            ),
            
             navbarPage("League of Legends",
                tabPanel("Project Overview",
                  fluidRow(
                    includeMarkdown("scripts/Overview.Rmd")
                  )
                ),
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
                      2015 and 2017. From the dropdown menus on the left, the user can select the two players whose win-rate he/she wants
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
                            h2("Overview"),
                            p("League of legends is game that is very much dependent on a player's skill, but at the
                              same time, the champions one picks matter ALOT. Most champions can play in one role(Top, Mid, Jungle, ADC and Support)
                              Meanwhile, some champions can be played in multiple roles. In this panel, we compare 2 champions with respect
                              to their win rates and ban rates. The champions picked will define the flow and pace of the game. Some champions
                              tend to play extremely aggressive and upclose whereas some tend to scale better and deal
                              damage from a distance. What makes professional esports and their champion selections interesting is the banning
                              champions phase at the beginning of the game. Each team gets to ban 5 champions and pick 5 champions. Studying the
                              ban rates and win rates gives us a general idea of which champions are currently very good or versatile"),
                            br(),
                            h2("Win Rates Comparison"),
                            p("The plot below compares the win rates of the 2 champions selected from the dropdown menu :"),
                            br(),
                            plotlyOutput("winplot"),
                            br(),
                            h2("Ban Rates Comparison"),
                            p("The plot below compares the win rates of the 2 champions selected from the dropdown menu :"),
                            br(),
                            plotlyOutput("banplot")
                          )
                        )
               ),
               tabPanel("How to win more games?",
                        fluidRow(
                          h2("Overview"),
                          p("We plan to find what objectives affect the outcome of the game the most. Also, we use correlation matrices to compare
                          the different correlations and try to know the difference between a competitive game and a non-competitive game."),
                          br(),
                          h2("Non-Competitive Games"),
                          plotOutput("noncompplot"),
                          p("From this plot, we can observe that there is decent correlation between winning the games and getting
                          objectives such as towers, and inhibitors. However, there is one interesting observation. The correlation
                          of winning a game and getting a baron is lower as compared to the correlation with getting Dragons. This
                          is indeed surprising because baron is the strongest objective in the game, and usually can turn the tide towards
                          a team."),
                          br(),
                          h2("Competitive Games"),
                          plotOutput("compplot"),
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
               tabPanel("Sources/Contact Us",
                        fluidRow(
                          h2("Reach Us"),
                          p("We are here to answer any questions you might have about our League of Legends application.
                            Reach out to us and we'll respond as soon as we can!
                            Please use the contact information provided below to reach us."),
                          h2("Contact Information"),
                          h4(strong("E-mail")),
                          p("Aman Agarwal: aman28@uw.edu"),
                          p("Siddharth Jadav: jadavs@uw.edu"),
                          p("Mahir Bathija: mahirb@uw.edu"),
                          br(),
                          h4(strong("Mobile")),
                          p("Aman Agarwal: +1 (206) 565-7896"),
                          p("Siddharth Jadav: +1 (206) 245-3623"),
                          p("Mahir Bathija: +1 (206) 693-0757"),
                          br(),
                          h4(strong("Summoner ID")),
                          p("Aman Agarwal: seraastark"),
                          p("Siddharth Jadav: sjadav"),
                          h2("Resources"),
                          helpText(a("Competitive Games dataset", href="https://www.kaggle.com/chuckephron/leagueoflegends/data")),
                          helpText(a("Non-Competitive Games dataset", href="https://www.kaggle.com/datasnaek/league-of-legends/data"))
                          )
               )
             )
)