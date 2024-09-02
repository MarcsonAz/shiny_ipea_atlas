library(shiny)
library(tidyverse)

source("setup.R")
source("helpers.R")

ui <- fluidPage(
  titlePanel("Teste (após o funcionamento inicial - 02/09/2024) para Shiny do Atlas do Estado Brasileiro - Ipea"),
  sidebarLayout(
    sidebarPanel(
      sidebar_content
    ),
    mainPanel(
      "Tabela para explorar dados do Atlas",
      tableOutput("table")
    )
  )
)




# Define the Shiny server function
server <- function(input, output) {

  ## novo
  ## 
  
  selected_anos <-
    reactive(anos_validos(input)) # funcao especial para testar o erro que esta acontencendo
  
  selected_nivel_federativos <-
    reactive(nivel_federativos_validos(input))  ## if (is.null(input$nivel_federativo)) nivel_federativos else input$nivel_federativo)
  
  selected_poders <-
    reactive(poders_validos(input))   ##if (is.null(input$poder)) poders else input$poder)


  selected_data_by_group <-
    reactive({
      filter_data_by_group(selected_anos(),
                            selected_nivel_federativos(),
                            selected_poders())
    })

  # gt_table <- reactive({
  #   make_table(selected_data_by_group())
  # })
  # 
  # print(gt_table)
  # # Make plots
  # output$line <-
  #   renderPlot({
  #     plot_conversions_over_time(selected_data())
  #   })
  # 
  


  # Render table
  output$table <-
    renderTable(digits = 0, {
      make_table(selected_data_by_group())
    })
}


# Create the Shiny app
shinyApp(ui = ui, server = server)
