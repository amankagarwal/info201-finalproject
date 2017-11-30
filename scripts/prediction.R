library("corrplot")

data <- read.csv("data/games.csv", stringsAsFactors = FALSE)

# Selecting only t
cor.data <- data %>%
  select("Tower1" = t1_towerKills,"Inhib1" = t1_inhibitorKills, "Drag1" = t1_dragonKills,
         "Baron1" = t1_baronKills, "Tower2" = t2_towerKills, "Inhib2" = t2_inhibitorKills,
         "Drag2" = t2_dragonKills,"Baron2" = t2_baronKills, Winner = winner)

cor.data <- as.matrix(cor.data)

cor <- cor(cor.data)

corrplot.mixed(cor, title = "Correlation between objectives and game outcome")
