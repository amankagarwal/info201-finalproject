library(dplyr)
library(plotly)

# This script will analyze champions and what their ban rate is every year

# This contains all the match history and other such data
match.data <- read.csv("data/_LeagueofLegends.csv", stringsAsFactors = FALSE)
# This contains the banned champions on each game
ban.data <- read.csv("data/banValues.csv", stringsAsFactors = FALSE)
combined.data <- left_join(ban.data, match.data, by = "MatchHistory")

# Takes in a champion and year, then returns the ban rate of that champion that year
getBanRate <- function(champion, year) {
  total.games <- combined.data %>% 
                 filter(Year == year) %>% 
                 nrow() / 2
  year.data <- combined.data %>% 
               filter(Year == year) %>% 
               filter(ban_1 == champion | ban_2 == champion | ban_3 == champion | ban_4 == champion | ban_5 == champion) %>%
               nrow()
  return (year.data * 100 / total.games)
}

plotTheData <- function(champion) {
  bans <- c(getBanRate(champion, "2015"), getBanRate(champion, "2016"), getBanRate(champion, "2017"))
  year <- c("2015", "2016", "2017")
  champTable <- data.frame(year, bans)
  p <- plot_ly(champTable, x = ~year, y = ~bans,
          type = "scatter", text = paste(champion, "<br>Year:", champTable$year),
          mode='lines') %>% 
    layout(title = paste(champion, "ban rate from 2015-17"),
           yaxis = list(title = "Ban Rate"),
           xaxis = list(title = "Year"))
  return(p)
}






