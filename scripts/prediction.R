library("corrplot")
library("dplyr")

data <- read.csv("data/games.csv", stringsAsFactors = FALSE)
comp.data <- read.csv("data/_LeagueofLegends.csv", stringsAsFactors = FALSE)

# 1 for blue win, 0 for red win
comp.data <- comp.data %>%
  mutate(Winner = comp.data[, "bResult"])

# Need to mutate all the rBarons, blah blah with the length of the list (num of times they got the objective data)
# Otherwise I don't think I can calculate the correlation between the two.
num.of.red.towers <- comp.data %>%
  
# Plot is made, have to see how to make the logistic model and predict the outcome.
# This is for the non-competitive data. I wish to compare this with the competitive data.
cor.data <- data %>%
  select("FBlood" = firstBlood, "Tower1" = t1_towerKills,"Inhib1" = t1_inhibitorKills, "Drag1" = t1_dragonKills,
         "Baron1" = t1_baronKills, "Tower2" = t2_towerKills, "Inhib2" = t2_inhibitorKills,
         "Drag2" = t2_dragonKills,"Baron2" = t2_baronKills, "Winner" = winner)
cor.data <- as.matrix(cor.data)
cor <- cor(cor.data)
corrplot.mixed(cor, title = "Correlation between objectives and game outcome")
