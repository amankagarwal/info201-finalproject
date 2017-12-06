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
cor1.data <- comp.data %>%
  select(Tower1 = bTowers, Inhib1 = bInhibs, Drag1 = bDragons, Baron1 = bBarons,
         Tower2 = rTowers, Inhib2 = rInhibs, Drag2 = rDragons, Baron2 = rBarons, Winner = bResult)
cor1.data <- as.matrix(cor1.data)
cor1 <- cor(cor1.data)
competitive.corr <- corrplot.mixed(cor1, title = "Competitive Game's Correlations")

  
# Generating a correlation plot for non-competitive games.
cor2.data <- data %>%
  select("Tower1" = t1_towerKills,"Inhib1" = t1_inhibitorKills, "Drag1" = t1_dragonKills,
         "Baron1" = t1_baronKills, "Tower2" = t2_towerKills, "Inhib2" = t2_inhibitorKills,
         "Drag2" = t2_dragonKills,"Baron2" = t2_baronKills, "Winner" = winner)
cor2.data <- as.matrix(cor2.data)
cor2 <- cor(cor2.data)
non.competitive.corr <- corrplot.mixed(cor2, title = "Non-Competitive Game's Correlations")