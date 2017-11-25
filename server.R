library("dplyr")
library("plotly")
source("scripts/win-rate-comparison.R")
shinyServer <- function(input, output) {
  
  # Creates the first drop down menu through which the user can select the first player.
  output$firstdropdown <- renderUI({
    selectizeInput("player1", label = "Choose Player 1:", choices = winrateRole(input$role)$player,
                   selected = NULL, multiple = FALSE, options = NULL)
  })
  
  # Creates the second drop down menu. User cannot select the same player he/she select as the first player.
  output$seconddropdown <- renderUI({
    all.choices <- winrateRole(input$role)$player
    without.player1 <- all.choices[which(all.choices != input$player1)]
    selectizeInput("player2", label = "Choose Player 2:", choices = without.player1,
                   selected = NULL, multiple = FALSE, options = NULL)
  })
  
  # Generates the plot of two pro player's win rate on both the red side and the blue side.
  output$winrateplot <- renderPlotly({
    tmp <- winrateRole(input$role)
    players <- c(input$player1, input$player2)
    tmp <- tmp %>%
      filter(player %in% players) %>%
      select(Player = player, Blue = winrate.blue, Red = winrate.red)
    
    plot_ly(data = tmp, x = ~Player, y = ~Blue, type = 'bar', name = "Blue side") %>%
      add_trace(y = ~Red, name = "Red side") %>%
      layout(title = paste0(input$player1, " vs ", input$player2, " Winrate Comparison"),
             yaxis = list(title = "Winrate"), barmode = 'stack', height = "600px")
  })
  
  output$winratesummary <- renderText({
    
    
    
    return(paste("Among the two player in the", input$role, "lane,", highest.combined.winrate$player, "had the highest combined winrate for the
                 blue and red side.", highest.combined.winrate$player, "had a winrate of", highest.combined.winrate$winrate.blue,
                 "% at the blue side and", highest.combined.winrate$winrate.red, "% at the red side. In general, from the plot, we
                 can also observe that the winrate at the blue side is usually higher. This supports the fact that most teams prefer
                 to play at the blue side, mainly because it gives the jungler a better chance to help out his teammates." ))
  })
}

