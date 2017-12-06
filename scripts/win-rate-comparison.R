library("dplyr")
library("stringr")
library("plotly")
# This data has all player names (lane-wise), and whether the team has won or not. 
league.data <- read.csv("data/_LeagueofLegends.csv", stringsAsFactors = FALSE)

# Making everything title case in the dataset so that there are no duplicates based on case.
league.data <- league.data %>%
  mutate_if(is.character, funs(str_to_title(.)))

# This function groups the data by the role specified, and calculates the win rate for each player
# both at the blue side and the red side.
winrateRole <- function(role) {
  blue.role <- paste0("blue", role)
  blue <- league.data %>%
    group_by_(blue.role) %>%
    summarise(winrate.blue = round((sum(bResult) / n() * 100), digits = 2)) %>%
    arrange_(blue.role) %>%
    select(player = blue.role, winrate.blue)
  
  red.role <- paste0("red", role)
  red <- league.data %>%
    group_by_(red.role) %>%
    summarise(winrate.red = round((sum(rResult) / n() * 100), digits = 2)) %>%
    arrange_(red.role) %>%
    select(player = red.role, winrate.red)
  return (left_join(blue, red))
}

champPlayRate <- function(role) {
  blue.role <- paste0("blue", role)
  blue.champ <- paste0("blue", role, "Champ")
  blue <- league.data %>%
    group_by_(blue.role, blue.champ) %>%
    summarise(games.played = n()) %>%
    arrange_(blue.role, blue.champ) %>%
    select(player = blue.role, champion = blue.champ, games.played) 

  red.role <- paste0("red", role)
  red.champ <- paste0("red", role, "Champ")
  red <- league.data %>%
    group_by_(red.role, red.champ) %>%
    summarise(games.played = n()) %>%
    arrange_(red.role, red.champ) %>%
    select(player = red.role, champion = red.champ, games.played)
  return(aggregate(games.played~., rbind(blue, red), sum))
}

playRatePlot <- function(role, inputplayer) {

  tmp <- champPlayRate(role)
  tmp <- tmp %>%
    filter(player == inputplayer) %>%
    select(Player = player, Champion = champion, p1 = games.played)
  
  plot <- plot_ly(tmp, x = ~Champion, y = ~p1, name = inputplayer,
               type = "scatter",
               mode='lines+markers') %>% 
    layout(title = paste0(inputplayer,"'s Champion Pool"),
           margin = list(b = 160), xaxis = list(tickangle = 45),
           yaxis = list(title = "Games Played"),
           xaxis = list(title = "Champion Name"))
  return(plot)
}

# This function makes a stacked bar plot of two selected players and their respective win rates on 
# the red and blue sides.
winratePlot <- function(role, player1, player2) {
  tmp <- winrateRole(role)
  players <- c(player1, player2)
  tmp <- tmp %>%
    filter(player %in% players) %>%
    select(Player = player, Blue = winrate.blue, Red = winrate.red)
  
  plot <- plot_ly(data = tmp, x = ~Player, y = ~Blue, type = 'bar', name = "Blue side", height = "600px") %>%
    add_trace(y = ~Red, name = "Red side") %>%
    layout(title = paste0(player1, " vs ", player2, " Winrate Comparison"),
           yaxis = list(title = "Winrate"), barmode = 'stack')
  return (plot)
}

playerTabOverview <- function() {
  return ("In this tab, we calculate the win-rates of all players who have played competitive league of legends games between
          2015 and 2017. From the dropdown menus on the left, the user can select the two players whose's win-rate he/she wants
          to compare. Also, we compare the champions the selected players have played on the basis of the number
          of games played on each champion.")
}

winratePlotDesc <- function() {
  return("This plot compares the win-rates for the two selected players. Also, the use of a stacked bar plot enables us to compare
         the win-rates for each player on the basis of the side they play on- blue or red.")
}

playratePlotDesc <- function() {
  return("Write description for the second plot as well.")
}