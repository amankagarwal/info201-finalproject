library("dplyr")
library("plotly")
source("scripts/win-rate-comparison.R")
source("scripts/championAnalysis.R")
source("scripts/correlation.R")
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
  
  # Creates the third dropdown menu for champion 1
  output$thirddropdown<- renderUI({
    selectizeInput("champ1", label = "Choose Champion 1:", choices = championRole(input$role1),
                   selected = NULL, multiple = FALSE, options = NULL)
  })
  
  # Creates the fourth dropdown menu for champion 1
  output$fourthdropdown <- renderUI({
    choice <- championRole(input$role1)
    selectizeInput("champ2", label = "Choose Champion 2:", choices = choice,
                   selected = choice[[2]], multiple = FALSE, options = NULL)
  })
  
  # Generates the winrate plot of the 2 champions based on their roles
  output$winplot <- renderPlotly({
    plotTheWinData(input$champ1, input$champ2, input$role1)
  })
  
  # Generates the banrate plot of the 2 champions
  output$banplot <- renderPlotly({
    plotTheBanData(input$champ1, input$champ2)
  })
  
  # Generates the plot of two pro player's win rate on both the red side and the blue side.
  output$winrateplot <- renderPlotly({
    winratePlot(input$role, input$player1, input$player2)
  })
  
  # Generate a champion pool line plot for the player 1 selected
  output$p1champplot <- renderPlotly({
    playRatePlot(input$role, input$player1)
  })
  
  # Generate a champion pool plot for the player 2 selected
  output$p2champplot <- renderPlotly({
    playRatePlot(input$role, input$player2)
  })
  
  # Generates a correlation matrix plot of competitive games.
  output$compplot <- renderPlot({
    compPlot()
  })
  
  # Generates a correlation matrix plot of non-competitive games.
  output$noncompplot <- renderPlot({
    nonCompPlot()
  })
  
  # Tab5 overview 
  output$corrbrief <- renderText({
    correlationBrief()
  })
  
  # Non-competitive plot brief
  output$textnoncomp <- renderText({
    textNonComp()
  })
  
  #Competititive plot brief
  output$textcomp <- renderText({
    textComp()
  })
  
  # Tab5 conclusion.
  output$corrconclusion <- renderText({
    corrConclusion()
  })
  
  # Tab2 overview.
  output$playeroverview <- renderText({
    playerTabOverview()
  })
  
  # Winrate plot description.
  output$winratedesc <- renderText({
    winratePlotDesc()
  })
  
  # Playrate plot description.
  output$playratedesc <- renderText({
    playratePlotDesc()
  })
  
  # Winrate plot conclusion.
  output$winrateconc <- renderText({
    winratePlotConc()
  })
}