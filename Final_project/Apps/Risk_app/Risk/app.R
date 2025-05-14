library(shiny)
library(bslib)
library(DBI)
library(RPostgres)

# Database connection function
connect_to_db <- function() {
  dbConnect(
    Postgres(),
    dbname = "", ## change
    user = "", ## change
    password = "", ## change
    host = "",
    port = 5432 #,
    #options = "-c search_path=risk"
  )
}


ui <- page_sidebar(
  title = "Game Data Entry",
  sidebar = sidebar(
    numericInput("game", "Game number", value = 1, min = 1, max = 10),
    textInput("player", "Player"),
    numericInput("round_number", "Round number", value = 1, min = 1, max = 50),
    numericInput("roll_attempt", "Roll attempt", value = 1, min = 1, max = 50),
    textInput("starting_continent", "Starting Continent"),
    textInput("position", "Position"),
    numericInput("number_die_rolled", "Number die rolled", value = 1, min = 1, max = 20),
    textInput("roll_outcome", "Roll outcome"),
    numericInput("number_of_territories", "Number of territories", value = 1, min = 1, max = 20),
    numericInput("number_of_troops", "Number of troops", value = 1, min = 1, max = 100),
    numericInput("traded_in_sets", "Traded in sets", value = 0, min = 0, max = 100),
    actionButton("submit", "Submit", class = "btn-primary")
  ),
  card(
    card_header("Submitted Data"),
    tableOutput("data_table")
  )
)

server <- function(input, output, session) {
  # Reactive values to store submitted data
  submitted_data <- reactiveVal(data.frame())
  
  observeEvent(input$submit, {
    # Create a new row of data
    new_data <- data.frame(
      game = input$game,
      player = input$player,
      round_number = input$round_number,
      roll_attempt = input$roll_attempt,
      starting_continent = input$starting_continent,
      position = input$position,
      number_die_rolled = input$number_die_rolled,
      roll_outcome = input$roll_outcome,
      number_of_territories = input$number_of_territories,
      number_of_troops = input$number_of_troops,
      traded_in_sets = input$traded_in_sets
    )
    
    # Add new data to the reactive value
    submitted_data(rbind(submitted_data(), new_data))
    
    # Write data to PostgreSQL database
    tryCatch({
      conn <- connect_to_db()
      dbWriteTable(conn, "risk_data", new_data, append = TRUE, row.names = FALSE)
      dbDisconnect(conn)
      showNotification("Data successfully written to the database.", type = "message")
    }, error = function(e) {
      showNotification(paste("Error writing to database:", e$message), type = "error")
    })
    
    # Clear input fields
    updateNumericInput(session, "game", value = 1)
    updateNumericInput(session, "round_number", value = 1)
    updateTextInput(session, "player", value = "")
    updateNumericInput(session, "roll_attempt", value = 1)
    updateTextInput(session, "starting_continent", value = "")
    updateTextInput(session, "position", value = "")
    updateTextInput(session, "number_die_rolled", value = 1)
    updateTextInput(session, "roll_outcome", value = "")
    updateTextInput(session, "number_of_territories", value = 1)
    updateTextInput(session, "number_of_troops", value = 1)
    updateTextInput(session, "traded_in_sets", value = 1)
  })
  
  # Display submitted data in a table
  output$data_table <- renderTable({
    submitted_data()
  })
}

shinyApp(ui, server)