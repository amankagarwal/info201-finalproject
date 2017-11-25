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
    makePlot(input$role, input$player1, input$player2)
  })
  
  # Generates the summary paragraph
  output$winratesummary <- renderText({
    
    higher.blue <- higherBlueWinrate(input$player1, input$player2, input$role)
    higher.red <- higherRedWinrate(input$player1, input$player2, input$role)
    
    return(paste0("Among the two players in the ", input$role, " lane, ", higher.blue$player, " had the higher winrate, ",
                higher.blue$winrate.blue,"%, on the blue side, and ",higher.red$player, " had a higher winrate, ",higher.red$winrate.red,
                "% on the red side.", " In general, from the plot, we can also observe that the winrate at the blue
                side is usually higher compared to the red side. This supports the fact that most teams prefer
                to play at the blue side, mainly because it gives the jungler a better chance to help out his teammates." ))
  })
}

