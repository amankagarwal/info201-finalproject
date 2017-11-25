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
