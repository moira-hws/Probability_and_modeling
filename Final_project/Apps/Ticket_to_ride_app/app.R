library(shiny)
library(bslib)
library(DBI)
library(RPostgres)

# Database connection function
connect_to_db <- function() {
  dbConnect(
    Postgres(),
    dbname = "",
    user = "",
    password = "",
    host = "",
    port = 5432
  )
}

ui <- page_sidebar(
  title = "Ticket to Ride Data Entry",
  sidebar = sidebar(
    numericInput("game", "Game Number", value = 1, min = 1),
    numericInput("turn", "Turn Number", value = 1, min = 1),
    numericInput("player", "Player ID", value = 1, min = 1),
    
    selectInput("draw_claim", "Action Taken", choices = c("Draw Cards", "Claim Route", "Draw Tickets")),
    textInput("route", "Route ID or Endpoints"),
    numericInput("length", "Route Length", value = 1, min = 1, max = 20),
    
    checkboxInput("ticket_overlap", "Contributes to Multiple Tickets?", value = FALSE),
    selectInput("region", "Region", choices = c("West Coast", "Northeast", "Midwest", "South", "Other")),
    
    numericInput("points", "Total Points", value = 0, min = 0),
    numericInput("routes_completed", "Destination Tickets Completed", value = 0, min = 0),
    
    checkboxInput("longest_route", "Longest Continuous Route?", value = FALSE),
    selectInput("win_loss", "Game Result", choices = c("Win", "Loss")),
    
    actionButton("submit", "Submit", class = "btn-primary")
  ),
  card(
    card_header("Submitted Data"),
    tableOutput("data_table")
  )
)

server <- function(input, output, session) {
  submitted_data <- reactiveVal(data.frame())
  
  observeEvent(input$submit, {
    new_data <- data.frame(
      game = input$game,
      turn = input$turn,
      player = input$player,
      draw_claim = input$draw_claim,
      route = input$route,
      length = input$length,
      ticket_overlap = input$ticket_overlap,
      region = input$region,
      points = input$points,
      routes_completed = input$routes_completed,
      longest_route = input$longest_route,
      win_loss = input$win_loss
    )
    
    submitted_data(rbind(submitted_data(), new_data))
    
    tryCatch({
      conn <- connect_to_db()
      dbWriteTable(conn, "ticket_to_ride_data", new_data, append = TRUE, row.names = FALSE)
      dbDisconnect(conn)
      showNotification("Data successfully written to the database.", type = "message")
    }, error = function(e) {
      showNotification(paste("Error writing to database:", e$message), type = "error")
    })
    
    # Reset all inputs
    updateNumericInput(session, "game", value = 1)
    updateNumericInput(session, "turn", value = 1)
    updateNumericInput(session, "player", value = 1)
    updateSelectInput(session, "draw_claim", selected = "Draw Cards")
    updateTextInput(session, "route", value = "")
    updateNumericInput(session, "length", value = 1)
    updateCheckboxInput(session, "ticket_overlap", value = FALSE)
    updateSelectInput(session, "region", selected = "West Coast")
    updateNumericInput(session, "points", value = 0)
    updateNumericInput(session, "routes_completed", value = 0)
    updateCheckboxInput(session, "longest_route", value = FALSE)
    updateSelectInput(session, "win_loss", selected = "Win")
  })
  
  output$data_table <- renderTable({
    submitted_data()
  })
}

shinyApp(ui, server)
