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
    choice <- winrateRole(input$role)$player
    selectizeInput("player2", label = "Choose Player 2:", choices = choice,
                   selected = choice[[2]], multiple = FALSE, options = NULL)
  })
  
  # Generates the plot of two pro player's win rate on both the red side and the blue side.
  output$winrateplot <- renderPlotly({
    makePlot(input$role, input$player1, input$player2)
  })
}

