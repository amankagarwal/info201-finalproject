library("corrplot")
library("dplyr")

data <- read.csv("data/games.csv", stringsAsFactors = FALSE)
comp.data <- read.csv("data/_LeagueofLegends.csv", stringsAsFactors = FALSE)

listToLength <- function(col) {
  col = eval(parse(text = col))
  return (unlist(lapply(strsplit(data$col, ","), length)))
}
comp.data$bTowers <- listToLength(bTowers)
comp.data$bDragons <- listToLength(bDragons)
comp.data$bInhibs <- listToLength(bInhibs)
comp.data$rTowers <- listToLength(rTowers)
comp.data$rDragons <- listToLength(rDragons)
comp.data$rInhibs <-listToLength(rInhibs)

# 1 for blue win, 0 for red win
comp.data <- comp.data %>%
  select(Winner = bResult, Tower1 = bTowers, Dragon1 = bDragons, Inhib1 = bInhibs,
         Tower2 = rTowers, Dragon2 = rDragons, Inhib2 = rInhibs)
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