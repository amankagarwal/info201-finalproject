library("corrplot")
library("dplyr")

data <- read.csv("data/games.csv", stringsAsFactors = FALSE)
comp.data <- read.csv("data/_LeagueofLegends.csv", stringsAsFactors = FALSE)

comp.data <- data.frame(apply(comp.data,2,function(x) gsub(pattern = "\\[", "", x)), stringsAsFactors = F)
comp.data <- data.frame(apply(comp.data,2,function(x) gsub(pattern = "\\]", "", x)), stringsAsFactors = F)

# Data-wrangling: replacing the lists with the length to generate the correlation plot.
comp.data$bTowers <- as.numeric(unlist(lapply(strsplit(comp.data$bTowers, ","), length)))
comp.data$bDragons <- as.numeric(unlist(lapply(strsplit(comp.data$bDragons, ","), length)))
comp.data$bBarons <- as.numeric(unlist(lapply(strsplit(comp.data$bBarons, ","), length)))
comp.data$rBarons <- as.numeric(unlist(lapply(strsplit(comp.data$rBarons, ","), length)))
comp.data$bInhibs <- as.numeric(unlist(lapply(strsplit(comp.data$bInhibs, ","), length)))
comp.data$rTowers <- as.numeric(unlist(lapply(strsplit(comp.data$rTowers, ","), length)))
comp.data$rDragons <- as.numeric(unlist(lapply(strsplit(comp.data$rDragons, ","), length)))
comp.data$rInhibs <- as.numeric(unlist(lapply(strsplit(comp.data$rInhibs, ","), length)))
comp.data$bResult <- as.numeric(comp.data$bResult)

# Generating a correlation plot for competitive games.

compPlot <- function() {
  cor1.data <- comp.data %>%
    select(Tower1 = bTowers, Inhib1 = bInhibs, Drag1 = bDragons, Baron1 = bBarons,
           Tower2 = rTowers, Inhib2 = rInhibs, Drag2 = rDragons, Baron2 = rBarons, Winner = bResult)
  cor1.data <- as.matrix(cor1.data)
  cor1 <- cor(cor1.data)
  return(corrplot.mixed(cor1))
}

# Generating a correlation plot for non-competitive games.

nonCompPlot <- function() {
  cor2.data <- data %>%
    select("Tower1" = t1_towerKills,"Inhib1" = t1_inhibitorKills, "Drag1" = t1_dragonKills,
           "Baron1" = t1_baronKills, "Tower2" = t2_towerKills, "Inhib2" = t2_inhibitorKills,
           "Drag2" = t2_dragonKills,"Baron2" = t2_baronKills, "Winner" = winner)
  cor2.data <- as.matrix(cor2.data)
  cor2 <- cor(cor2.data)
  return (corrplot.mixed(cor2))
}

correlationBrief <- function() {
  return ("We plan to find what objectives affect the outcome of the game the most. Also, we use correlation matrices to compare
          the different correlations and try to know the difference between a competitive game and a non-competitive game.")
}
textNonComp <- function() {
  return("From this plot, we can observe that there is decent correlation between winning the games and getting
         objectives such as towers, and inhibitors. However, there is one interesting observation. The correlation
         of winning a game and getting a baron is lower as compared to the correlation with getting Dragons. This
         is indeed surprising because baron is the strongest objective in the game, and usually can turn the tide towards
         a team.")
}

textComp <- function() {
  return ("Just like the correlation matrix plot for the non-competitive games, we can observe a strong correlation between winning
          games and getting objectives such as towers and inhibitors. However, there is one major difference which we can observe-
          the correlation between winning and getting baron is much higher, and similar to getting dragons. This is more consistent
          with the logic of the game. Moreover, in competitive games all teams and players play much more seriously and focus to get
          objectives in the game to win. Once a team gets baron, which is the strongest objective in the game, it's less likely that
          they will throw away the lead, thus the higher correlation.")
}

corrConclusion <- function() {
  return("From this analysis, we can conclude that non-competitive games mostly depend on getting objectives such as turrets and
         inhibitors. Barons and dragons don't have as big an influence as these objectives have, so don't lose hope if you lose
         a baron or drake! In order to win more games, you should concentrate in getting turrets, and pushing lanes in order to get
         inhibitors!")
}