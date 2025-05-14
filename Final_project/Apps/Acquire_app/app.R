library(shiny)
library(bslib)
library(DBI)
library(RPostgres)

# Database connection function
connect_to_db <- function() {
  dbConnect(
    Postgres(),
    dbname = "", ## 
    user = "", ## change
    password = "", ##
    host = "",
    port = 5432 #,
    #options = "-c search_path=acquire"
  )
}

# UI
ui <- page_sidebar(
  title = "Game Data Entry",
  sidebar = sidebar(
    numericInput("game", "Game number", value = 1, min = 1, max = 10),
    numericInput("player", "Player number", value = 1, min = 1, max = 5),
    textInput("piece_1", "Piece 1"),
    textInput("piece_2", "Piece 2"),
    textInput("piece_3", "Piece 3"),
    textInput("piece_4", "Piece 4"),
    textInput("piece_5", "Piece 5"),
    textInput("piece_6", "Piece 6"),
    numericInput("total_cash", "Total cash", value = 1, min = 1, max = 250000),
    numericInput("stock_Sackson", "Stock - Sackson", value = 0, min = 0, max = 5000),
    numericInput("stock_Tower", "Stock - Tower", value = 0, min = 0, max = 5000),
    numericInput("stock_American", "Stock - American", value = 0, min = 0, max = 5000),
    numericInput("stock_Festival", "Stock - Festival", value = 0, min = 0, max = 5000),
    numericInput("stock_Worldwide", "Stock - Worldwide", value = 0, min = 0, max = 5000),
    numericInput("stock_Continental", "Stock - Continental", value = 0, min = 0, max = 5000),
    numericInput("stock_Imperial", "Stock - Imperial", value = 0, min = 0, max = 5000),
    textInput("merger_decisions", "Merger Decisions"),
    textInput("chain_chosen", "Hotel chain chosen"), ## hotel created
    actionButton("submit", "Submit", class = "btn-primary")
  ),
  card(
    card_header("Submitted Data"),
    tableOutput("data_table")
  )
)

# Server
server <- function(input, output, session) {
  # Reactive values to store submitted data
  submitted_data <- reactiveVal(data.frame())
  
  observeEvent(input$submit, {
    new_data <- data.frame(
      game = input$game,
      player = input$player,
      piece1 = input$piece_1,
      piece2 = input$piece_2,
      piece3 = input$piece_3,
      piece4 = input$piece_4,
      piece5 = input$piece_5,
      piece6 = input$piece_6,
      total_cash = input$total_cash,
      stock_Sackson = input$stock_Sackson,
      stock_Tower = input$stock_Tower,
      stock_American = input$stock_American,
      stock_Festival = input$stock_Festival,
      stock_Worldwide = input$stock_Worldwide,
      stock_Continental = input$stock_Continental,
      stock_Imperial = input$stock_Imperial,
      merger_decisions = input$merger_decisions,
      chain_chosen = input$chain_chosen
    )
    
    submitted_data(rbind(submitted_data(), new_data))
    
    tryCatch({
      conn <- connect_to_db()
      dbWriteTable(conn, "acquire_data_updated", new_data, append = TRUE, row.names = FALSE)
      dbDisconnect(conn)
      showNotification("Data successfully written to the database.", type = "message")
    }, error = function(e) {
      showNotification(paste("Error writing to database:", e$message), type = "error")
    })
    
    # Reset inputs
    updateNumericInput(session, "game", value = 1)
    updateNumericInput(session, "player", value = 1)
    updateTextInput(session, "piece_1", value = "")
    updateTextInput(session, "piece_2", value = "")
    updateTextInput(session, "piece_3", value = "")
    updateTextInput(session, "piece_4", value = "")
    updateTextInput(session, "piece_5", value = "")
    updateTextInput(session, "piece_6", value = "")
    updateNumericInput(session, "total_cash", value = 1)
    updateNumericInput(session, "stock_Sackson", value = 0)
    updateNumericInput(session, "stock_Tower", value = 0)
    updateNumericInput(session, "stock_American", value = 0)
    updateNumericInput(session, "stock_Festival", value = 0)
    updateNumericInput(session, "stock_Worldwide", value = 0)
    updateNumericInput(session, "stock_Continental", value = 0)
    updateNumericInput(session, "stock_Imperial", value = 0)
    updateTextInput(session, "merger_decisions", value = "")
    updateTextInput(session, "chain_chosen", value = "")
  })
  
  # Output submitted data
  output$data_table <- renderTable({
    submitted_data()
  })
}

# Run the app
shinyApp(ui, server)