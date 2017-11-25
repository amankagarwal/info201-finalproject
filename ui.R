# library("dplyr")
# library("snakecase")
# library("plotly")
# 
# # This data has all player names (lane-wise), and whether the team has won or not. 
# league.data <- read.csv("data/_LeagueofLegends.csv", stringsAsFactors = FALSE)
# 
# # Making everything title case in the dataset so that there are no duplicates based on case
# league.data <- league.data %>%
#   mutate_if(is.character, funs(str_to_title(.)))
# 
# 
# # Use a user-defined function to get a dataframe which has all player names by role
# # 
# 
# 
# # 
# # blue.mid <- data.frame(league.data$blueMiddle) %>%
# #   select(mid = league.data.blueMiddle)
# # red.mid <- data.frame(league.data$redMiddle) %>%
# #   select(mid = league.data.redMiddle)
# 
# # Issue, these player names are all lowercase (had to do that otherwise unique() would not filter out everything)
# # Should I titleCase() everything?
# # mid.players <- unique(rbind(blue.mid, red.mid)) # a dataframe with one column, mid, which has all midlaners's name (for search bar)
# 
# # returns a dataframe which has all players by role, and their winrates at both the blue side and the red side.
# 
# winrateRole <- function(role) {
#   blue.role <- paste0("blue", role)
#   blue <- league.data %>%
#     group_by_(blue.role) %>%
#     summarise(winrate.blue = round((sum(bResult) / n() * 100), digits = 2)) %>%
#     arrange_(blue.role) %>%
#     select(player = blue.role, winrate.blue)
#   
#   red.role <- paste0("red", role)
#   red <- league.data %>%
#     group_by_(red.role) %>%
#     summarise(winrate.red = round((sum(rResult) / n() * 100), digits = 2)) %>%
#     arrange_(red.role) %>%
#     select(player = red.role, winrate.red)
#   return (left_join(blue, red))
# }
# 
# # Testing the winrate.by.role function for Mid lane ->
# 
# function()
#   winrates.top <- winrateRole("Top")
# winrates.jungle <- winrateRole("Jungle")
# winrates.mid <- winrateRole("Middle")
# winrates.adc <- winrateRole("ADC")
# winrates.support <- winrateRole("Support")
# 
# # Plot a stacked bar chart (dont differentiate between blue and red)
# 
# winrates <- c()


library("shiny")
library("shinythemes")
source("player-win-rates.R")
shinyUI <- fluidPage(title = "League Analysis", theme = shinytheme("spacelab"),
                     
                     mainPanel(
                       navbarPage(strong("League of Legends"),
                                  tabPanel("Tab1",
                                           sidebarLayout(
                                             sidebarPanel(
                                               
                                             ),
                                  tabPanel("Tab2"),
                                  tabPanel("Tab3"),
                                  tabPanel("Tab4"))
                     )
)