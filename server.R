library("shiny")
library("dplyr")
library("plotly")
source("scripts/win-rate-comparison.R")
shinyServer <- function(input, output) {
  
  # All of this is for the win rate tab
  output$firstdropdown <- renderUI({
    selectizeInput("player1", label = "Choose Player 1:", choices = winrateRole(input$role)$player,
                   selected = NULL, multiple = FALSE, options = NULL)
  })
  
  output$seconddropdown <- renderUI({
    all.choices <- winrateRole(input$role)$player
    without.player1 <- all.choices[which(all.choices != input$player1)]
    selectizeInput("player2", label = "Choose Player 2:", choices = without.player1,
                   selected = NULL, multiple = FALSE, options = NULL)
  })
  
  output$winrateplot <- renderPlotly({
    tmp <- winrateRole(input$role)
    players <- c(input$player1, input$player2)
    tmp <- tmp %>%
      filter(player %in% players) %>%
      select(Player = player, Blue = winrate.blue, Red = winrate.red)
    
    winrates <- c(tmp$Blue, tmp$Red)
    plot_ly(data = tmp, x = ~Player, y = ~Blue, type = 'bar', name = "Blue side") %>%
      add_trace(y = ~Red, name = "Red side") %>%
      layout(title = paste0(input$player1, " vs ", input$player2, " Winrate Comparison"),
             yaxis = list(title = "Winrate"), barmode = 'stack')
  })
}

