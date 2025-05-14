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
    #options = "-c search_path=cribbage"
  )
}


ui <- page_sidebar(
  title = "Person Data Entry",
  sidebar = sidebar(
    numericInput("player_id", "Player ID", value = 1, min = 1, max = 10),
    numericInput("round_number", "Round number", value = 1, min = 1, max = 15),
    textInput("hand_initial_1", "Initial card 1"),
    textInput("hand_initial_2", "Initial card 2"),
    textInput("hand_initial_3", "Initial card 3"),
    textInput("hand_initial_4", "Initial card 4"),
    textInput("hand_initial_5", "Initial card 5"),
    textInput("hand_final_1", "Final card 1"),
    textInput("hand_final_2", "Final card 2"),
    textInput("hand_final_3", "Final card 3"),
    textInput("hand_final_4", "Final card 4"),
    textInput("hand_final_5", "Final card 5"),
    textInput("starter_card", "Starter card"),
    numericInput("pegging_points", "Pegging points gained/lost", value = 0, min = 0, max = 100),
    numericInput("total_score", "Total score", value = 0, min = 0, max = 150),
    textInput("win_status", "Win?"),
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
      player_id = input$player_id,
      round_number = input$round_number,
      hand_initial_1 = input$hand_initial_1,
      hand_initial_2 = input$hand_initial_2,
      hand_initial_3 = input$hand_initial_3,
      hand_initial_4 = input$hand_initial_4,
      hand_initial_5 = input$hand_initial_5,
      hand_final_1 = input$hand_final_1,
      hand_final_2 = input$hand_final_2,
      hand_final_3 = input$hand_final_3,
      hand_final_4 = input$hand_final_4,
      hand_final_5 = input$hand_final_5,
      starter_card = input$starter_card,
      pegging_points = input$pegging_points,
      total_score = input$total_score,
      win_status = input$win_status
    )
    
    # Add new data to the reactive value
    submitted_data(rbind(submitted_data(), new_data))
    
    # Write data to PostgreSQL database
    tryCatch({
      conn <- connect_to_db()
      dbWriteTable(conn, "cribbage_data", new_data, append = TRUE, row.names = FALSE)
      dbDisconnect(conn)
      showNotification("Data successfully written to the database.", type = "message")
    }, error = function(e) {
      showNotification(paste("Error writing to database:", e$message), type = "error")
    })
    
    # Clear input fields
    updateNumericInput(session, "player_id", value = 1)
    updateNumericInput(session, "round_number", value = 1)
    updateTextInput(session, "hand_initial_1", value = "")
    updateTextInput(session, "hand_initial_2", value = "")
    updateTextInput(session, "hand_initial_3", value = "")
    updateTextInput(session, "hand_initial_4", value = "")
    updateTextInput(session, "hand_initial_5", value = "")
    updateTextInput(session, "hand_final_1", value = "")
    updateTextInput(session, "hand_final_2", value = "")
    updateTextInput(session, "hand_final_3", value = "")
    updateTextInput(session, "hand_final_4", value = "")
    updateTextInput(session, "hand_final_5", value = "")
    updateTextInput(session, "starter_card", value = "")
    updateNumericInput(session, "pegging_points", value = 0)
    updateNumericInput(session, "total_score", value = 0)
    updateTextInput(session, "win_status", value = "")
  })
  
  # Display submitted data in a table
  output$data_table <- renderTable({
    submitted_data()
  })
}

shinyApp(ui, server)