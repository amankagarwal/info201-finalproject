library("dplyr")
library("stringi")

# This data has all player names (lane-wise), and whether the team has won or not. 
league.data <- read.csv("data/_LeagueofLegends.csv", stringsAsFactors = FALSE)

# Need a way so that I can change all string values in a dataframe to lowercase.

league.data$blueMiddle = tolower(league.data$blueMiddle)
league.data$redMiddle = tolower(league.data$redMiddle)

# Use a user-defined function to get a dataframe which has all player names by role


blue.mid <- data.frame(league.data$blueMiddle) %>%
  select(mid = league.data.blueMiddle)
red.mid <- data.frame(league.data$redMiddle) %>%
  select(mid = league.data.redMiddle)

# Issue, these player names are all lowercase (had to do that otherwise unique() would not filter out everything)
# Should I titleCase() everything?
mid.players <- unique(rbind(blue.mid, red.mid)) # a dataframe with one column, mid, which has all midlaners's name (for search bar)