library("dplyr")
library("stringr")

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

champPlayRateBlue <- function(role) {
  blue.role <- paste0("blue", role)
  blue.champ <- paste0("blue", role, "Champ")
  blue <- league.data %>%
    group_by_(blue.role, blue.champ) %>%
    summarise(games.played = n()) %>%
    arrange_(blue.role, blue.champ) %>%
    select(player = blue.role, champion = blue.champ, games.played) 
  return (blue)
}

champPlayRateRed <- function(role) {
  red.role <- paste0("red", role)
  red.champ <- paste0("red", role, "Champ")
  red <- league.data %>%
    group_by_(red.role, red.champ) %>%
    summarise(games.played = n()) %>%
    arrange_(red.role, red.champ) %>%
    select(player = red.role, champion = red.champ, games.played)
  return(red)
}

playratePlot <- function(role, player1, player2) {
  
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