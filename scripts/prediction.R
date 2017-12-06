library("corrplot")
library("dplyr")

data <- read.csv("data/games.csv", stringsAsFactors = FALSE)
comp.data <- read.csv("data/_LeagueofLegends.csv", stringsAsFactors = FALSE)

# 1 for blue win, 0 for red win
comp.data <- comp.data %>%
  select(Winner = bResult, Tower1 = bTowers, Dragon1 = bDragons, Inhib1 = bInhibs,
         Tower2 = rTowers, Dragon2 = rDragons, Inhib2 = rInhibs)

# Need to mutate all the rBarons, blah blah with the length of the list (num of times they got the objective data)
# Otherwise I don't think I can calculate the correlation between the two. Yes I cannot calculate because they have to 
# be numeric values. Otherwise I cannot calculate it.
cor1.data <- as.matrix(comp.data)
cor1 <- cor(cor1.data)
corrplot.mixed(cor1, "Competitive games correlations")

  

# This is for the non-competitive data. I wish to compare this with the competitive data.
cor.data <- data %>%
  select("Tower1" = t1_towerKills,"Inhib1" = t1_inhibitorKills, "Drag1" = t1_dragonKills,
         "Baron1" = t1_baronKills, "Tower2" = t2_towerKills, "Inhib2" = t2_inhibitorKills,
         "Drag2" = t2_dragonKills,"Baron2" = t2_baronKills, "Winner" = winner)
cor.data <- as.matrix(cor.data)
cor <- cor(cor.data)
corrplot.mixed(cor, title = "Correlation between objectives and game outcome")

a1 <- c("Hello", "World")
b1 <- c("[1, 2]", "[1,2,3]")
c1 <- c("[1, 2, 3, 3]", "[1, 4, 5, 6]")

data <- data.frame(a1, b1, c1)
