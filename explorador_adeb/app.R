library(shiny)
library(tidyverse)

source("setup.R")
source("helpers.R")

ui <- fluidPage(
  titlePanel("Teste para Shiny do Atlas do Estado Brasileiro - Ipea"),
  sidebarLayout(
    sidebarPanel(
      sidebar_content
    ),
    mainPanel(
      # "Conversions over time",
      # plotOutput("line"),
      # 
      # "Conversion rates",
      # plotOutput("bar"),
      # 
      # "Recommended Trial",
      # textOutput("recommended_eval"),
      # 
      # "Users",
      # textOutput("number_of_users"),
      # 
      # "Avg Spend",
      # textOutput("average_spend"),

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
    reactive(if (is.null(input$nivel_federativo)) nivel_federativos else input$nivel_federativo)
  
  selected_poders <-
    reactive(if (is.null(input$poder)) poders else input$poder)
  
  
  
  
  # selected_data <-
  #   reactive({
  #     filter_users(selected_industries(),
  #                      selected_propensities(),
  #                      selected_contracts())
  #   })

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
  # output$bar <-
  #   renderPlot({
  #     plot_conversions_by_group(selected_data_by_group())
  #   })
  # 
  # 
  # # Compute values for value boxes
  # output$recommended_eval <-
  #   renderText({
  #     choose_recommendation(selected_data())
  #   })
  # 
  # output$number_of_users <-
  #   renderText({
  #     count_users(selected_data())
  #   })
  # 
  # output$average_spend <-
  #   renderText({
  #     compute_average_spend(selected_data())
  #   })


  # Render table
  output$table <-
    renderTable(digits = 0, {
      make_table(selected_data_by_group())
    })
}


# Create the Shiny app
shinyApp(ui = ui, server = server)
