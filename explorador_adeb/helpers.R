# helpers.R


# choose_recommendation <- function(data) {
#   recommendation <-
#     data |>
#     group_by(evaluation) |>
#     summarise(rate = mean(outcome == "Won"), .groups = "drop") |>
#     filter(rate == max(rate)) |>
#     pull(evaluation)
# 
#   as.character(recommendation[1])
# }

# compute_average_spend <- function(data){
#   x <-
#     data |>
#     filter(outcome == "Won") |>
#     summarise(spend = round(mean(amount))) |>
#     pull(spend)
# 
#   str_glue("${x}")
# }

# count_users <- function(data) {
#   sum(data$outcome == "Won") |>
#     format(big.mark = ",")
# }
# 
# filter_users <- function(industries, propensities, contracts) {
# 
#   users |>
#     filter(industry %in% industries,
#            propensity %in% propensities,
#            contract %in% contracts)
# }
# 
# filter_users_by_group <- function(industries, propensities, contracts) {
#   users_by_group |>
#     filter(industry %in% industries,
#            propensity %in% propensities,
#            contract %in% contracts)
# }

# select_columns <- function(anos,nivel_federativo,poder){
#   dados_tabela %>% 
#     dplyr::select()
# }


anos_validos <- function(input){
  print(input$ano)
  print("-------------")
  print(anos[30])
  #return(if (is.null(input$ano)) anos else input$ano)
  return(anos[30])
}

nivel_federativos_validos <- function(input){
  #if (is.null(input$ano)) anos else input$ano
  print(input$nivel_federativo)
  print("-------------")
  print(nivel_federativos[1])
  #return(nivel_federativos[1])
  return(if (is.null(input$nivel_federativo)) nivel_federativos else input$nivel_federativo)
}

poders_validos <- function(input){
  #if (is.null(input$ano)) anos else input$ano
  print(input$poder)
  print("-------------")
  print(poders[2])
  return(poders[2])
}

filter_data_by_group <- function(selected_anos, selected_nivel_federativos,selected_poders) {
  
  # an.error.occured <- FALSE
  # tryCatch( { result <- is_character(selected_anos); print(res) }
  #           , error = function(e) {an.error.occured <<- TRUE;print(e)})
  # print(an.error.occured)
  
  
  print(c(selected_anos, selected_nivel_federativos,selected_poders))
  
  saida = dados_tabela_agrupados %>%
    filter(ano %in% as.numeric(selected_anos),
           poder %in% selected_poders,
           nivel_federativo %in% selected_nivel_federativos) 
  
  #%>% 
   # head()
  
  return(saida)

  #head(mtcars)
  
  # dados_tabela |>
  #   filter(ano %in% anos,
  #          poder %in% poders,
  #          nivel_federativo %in% nivel_federativos)
  # return(dados_tabela)
}


make_table <- function(data_by_group) {
  #head(mtcars)
  data_by_group
}



# plot_conversions_by_group <- function(data_by_group){
#   data_by_group |>
#     group_by(evaluation) |>
#     summarise(rate = round(sum(n * success_rate) / sum(n), 2)) |>
#     ggplot(aes(x = evaluation, y = rate, fill = evaluation)) +
#     geom_col() +
#     guides(fill = "none") +
#     theme(axis.title = element_blank()) +
#     scale_y_continuous(limits = c(0, 100))
# }
# 
# plot_conversions_over_time <- function(data){
#   data |>
#     mutate(date = floor_date(date, unit = "month")) |>
#     group_by(date, evaluation) |>
#     summarize(n = sum(outcome == "Won"), .groups = "drop") |>
#     ggplot(aes(x = date, y = n, color = evaluation)) +
#       geom_line() +
#       theme(axis.title = element_blank()) +
#       labs(color = "Trial Type")
# }


