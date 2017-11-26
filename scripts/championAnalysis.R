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

plotTheBanData <- function(champion1, champion2) {
  champTable <- dataNeeded(champion1, champion2, "", "Ban")
  p <- plot_ly(champTable, x = ~year, y = ~bans1, name = champion1,
          type = "scatter", text = paste(champion1,"<br>Year:", champTable$year),
          mode='lines+markers') %>% 
    layout(title = paste(champion1, "vs", champion2, "ban rate from 2015-17"),
           yaxis = list(title = "Ban Rate"),
           xaxis = list(title = "Year")) %>% 
    add_trace(y = ~bans2, name = champion2, mode = 'lines+markers', text = paste(champion2,"<br>Year:", champTable$year) )
  return(p)
}

getWinRate <- function(champion, role, year) {
  blue <- paste0("blue", role, "Champ")
  red <- paste0("red", role, "Champ")
  year.data <- filter(match.data, Year == year)
  games.played <- year.data %>% 
                  filter(eval(parse(text = blue)) == champion | eval(parse(text = red)) == champion) %>% nrow()
  games.won <- filter(year.data, eval(parse(text = blue)) == champion & bResult == 1) %>% nrow() + 
               filter(year.data, eval(parse(text = red)) == champion & rResult == 1) %>% nrow()
  win.rate <- games.won * 100 / games.played
  return (win.rate)
}

plotTheWinData <- function(champion1, champion2, role) {
  champTable <- dataNeeded(champion1, champion2, role, "Win")
  p <- plot_ly(champTable, x = ~year, y = ~wins1, name = champion1,
               type = "scatter", text = paste(champion1,"<br>Year:", champTable$year),
               mode='lines+markers') %>% 
    layout(title = paste(champion1, "vs", champion2, "win rate from 2015-17"),
           yaxis = list(title = "Win Rate"),
           xaxis = list(title = "Year")) %>% 
    add_trace(y = ~wins2, name = champion2, mode = 'lines+markers', text = paste(champion2,"<br>Year:", champTable$year) )
  return(p)
}

dataNeeded <- function(champion1, champion2, role, banOrWin) {
  if(banOrWin == "Ban") {
    bans1 <- c(getBanRate(champion1, "2015"), getBanRate(champion1, "2016"), getBanRate(champion1, "2017"))
    bans2 <- c(getBanRate(champion2, "2015"), getBanRate(champion2, "2016"), getBanRate(champion2, "2017"))
    year <- c("2015", "2016", "2017")
    return(data.frame(year, bans1, bans2))
  } else {
    wins1 <- c(getWinRate(champion1, role, "2015"), getWinRate(champion1, role, "2016"), getWinRate(champion1, role, "2017"))
    wins2 <- c(getWinRate(champion2, role, "2015"), getWinRate(champion2, role, "2016"), getWinRate(champion2, role, "2017"))
    year <- c("2015", "2016", "2017")
    return(data.frame(year, wins1, wins2))
  }
}




