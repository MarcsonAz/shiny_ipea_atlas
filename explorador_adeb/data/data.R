# Assemble fake Demo Co data
# library(tidyverse)
# 
# set.seed(2000)
# 
# industry <- c("Academia",
#               "Energy",
#               "Finance",
#               "Government",
#               "Healthcare",
#               "Insurance",
#               "Manufacturing",
#               "Non-Profit",
#               "Pharmaceuticals",
#               "Technology")
# 
# propensity <- c("Good", "Average", "Poor")
# contract <- c("Monthly", "Annual")
# 
# probs <- c(4, 3, 2, 2, 0.5, 1)
# probs <- c(1 * probs,
#            2 * probs,
#            3 * probs,
#            2 * probs,
#            1 * probs,
#            2 * probs,
#            4 * probs,
#            2 * probs,
#            3 * probs,
#            2 * probs)
# n <- sample(1:60, size = 75000, replace = TRUE, prob = probs) |> table()
# 
# industry_adjust <- c("Academia" = 0.05,
#                      "Energy" = 0.1,
#                      "Finance" = 0,
#                      "Government" = 0,
#                      "Healthcare" = 0.2,
#                      "Insurance" = -0.1,
#                      "Manufacturing" = -0.2,
#                      "Non-Profit" = 0,
#                      "Pharmaceuticals" = 0.2,
#                      "Technology" = 0.3)
# propensity_adjust <- c("Good" = 0.1, "Average" = 0, "Poor" = -0.1)
# contract_adjust <- c("Monthly" = 0, "Annual" = 0.2)
# 
# scramble <- function(vec){
#   names(vec) <- sample(names(vec))
#   vec
# }
# 
# expansion_rates <-
#   expand_grid(industry, propensity, contract) |>
#   mutate(n = as.numeric(n),
#          None = pmax(0.1, 0.2 + industry_adjust[industry] + propensity_adjust[propensity] + contract_adjust[contract]),
#          A = pmax(0.1, 0.6 + scramble(industry_adjust)[industry] + scramble(propensity_adjust)[propensity] + scramble(contract_adjust[contract])),
#          B = pmax(0.1, 0.7 + scramble(industry_adjust)[industry] + scramble(propensity_adjust)[propensity] + scramble(contract_adjust[contract])),
#          None = round(None / (max(None) + 0.1), 2),
#          A = round(A / (max(A) + 0.1), 2),
#          B = round(B / (max(B) + 0.1), 2))
# 
# # Build the raw data
# make_obs <- function(industry, propensity, contract, n, None, A, B) {
#   none_won <- round(n * .34 * None)
#   none_lost  <- round(n * .34 - none_won)
#   A_won    <- round(n * .33 * A)
#   A_lost     <- round(n * .33 - A_won)
#   B_won    <- round(n * .33 * B)
#   B_lost     <- round(n * .33 - B_won)
#   
#   outcome <- c(rep("Won", none_won), rep("Lost", none_lost),
#                rep("Won", A_won), rep("Lost", A_lost),
#                rep("Won", B_won), rep("Lost", B_lost))
#   evaluation = c(rep("None", none_lost + none_won),
#                  rep("A", A_lost + A_won),
#                  rep("B", B_lost + B_won))
#   tibble(outcome = outcome,
#          evaluation = evaluation,
#          industry = industry,
#          propensity = propensity,
#          contract = contract)
# }
# 
# make_dates <- function(industry){
#   n <- length(industry)
#   industry <- industry[1]
#   
#   dates <-
#     if (industry == "Academia") {
#       update(as.Date("2022-01-01") + rnorm(n, 0, 15) + c(rep(0, n/2), rep(214, n - (n/2))),
#              year = 2022)
#     } else if (industry == "Government") {
#       update(as.Date("2022-01-01") + rnorm(n, 0, 30),
#              year = 2022)
#     } else if (industry == "Energy") {
#       numbers <- rep(0:364, times = floor((365:1) / 3))
#       as.Date("2022-01-01") + sample(numbers, size = n, replace = TRUE)
#     } else if (industry == "Manufacturing") {
#       numbers <- rep(0:364, times = floor((365:1) / 4))
#       as.Date("2022-01-01") + sample(numbers, size = n, replace = TRUE)
#     } else if (industry == "Healthcare") {
#       numbers <- rep(0:364, times = floor((1:365) / 5))
#       as.Date("2022-01-01") + sample(numbers, size = n, replace = TRUE)
#     } else if (industry == "Pharmaceuticals") {
#       numbers <- rep(0:364, times = floor((1:365) / 2.5))
#       as.Date("2022-01-01") + sample(numbers, size = n, replace = TRUE)
#     } else if (industry == "Insurance") {
#       update(as.Date("2022-01-01") + rnorm(n, 182, 60),
#              year = 2022)
#     } else if (industry == "Finance") {
#       update(as.Date("2022-01-01") + rpois(n, 7) + c(rep(0, n/4), rep(91, n/4), rep(182, n/4), rep(273, n - (3 * floor(n / 4)))),
#              year = 2022)
#     } else {
#       as.Date("2022-01-01") + runif(n, 0, 364)
#     }
#   
#   sample(dates)
# }
# 
# users <-
#   expansion_rates |>
#   pmap(make_obs) |>
#   list_rbind() |>
#   group_by(industry) |>
#   mutate(date = make_dates(industry))|>
#   ungroup()
# 
# n <- nrow(users)
# 
# contract_amount <- c("Monthly" = 1, "Annual" = 0.9)
# industry_amount <- c("Academia" = 40,
#                      "Energy" = 50,
#                      "Finance" = 55,
#                      "Government" = 50,
#                      "Healthcare" = 50,
#                      "Insurance" = 50,
#                      "Manufacturing" = 45,
#                      "Non-Profit" = 40,
#                      "Pharmaceuticals" = 65,
#                      "Technology" = 60)
# 
# users |>
#   group_by(date) |>
#   sample_frac(1) |>
#   ungroup() |>
#   mutate(account = 1:n, .before = outcome) |>
#   mutate(amount = (industry_amount[industry] + rnorm(n, 0, 5)) * contract_amount[contract],
#          days = pmax(1, amount - runif(n, 15, 20) + rnorm(n, 0, 10))) |>
#   write_csv("data/users.csv")
# 
# 
# 
# 

pak::pak(c('readr','dplyr','tidyr','stringr'))

anos <- 1985:2021
nivel_federativo <- c("Federal","Estadual","Municipal")
poder <- c("Executivo","Legislativo","Judiciário")


dados_tabela <- read_csv2('./explorador_adeb/data/data_total_publico_por_poder_e_nivel_federativo.csv')

dados_tabela2 <- dados_tabela %>% 
  pivot_longer(!ano,
               names_to = "categoria_1",
               values_to = "soma_vinculos") %>% 
  mutate(nivel_federativo = str_split_i(categoria_1,"_",3),
         poder = str_split_i(categoria_1,"_",2)) %>% 
  mutate(
    nivel_federativo = case_when(
    nivel_federativo == 'federal' ~ 'Federal',
    nivel_federativo == 'estadual' ~ 'Estadual',
    nivel_federativo == 'municipal' ~ 'Municipal',
    .default = NA_character_
  ),
  poder = case_when(
    poder == 'executivo' ~ 'Executivo',
    poder == 'legislativo' ~ 'Legislativo',
    poder == 'judiciario' ~ 'Judiciário',
    .default = NA_character_
  )
  ) %>% 
  select(ano, poder, nivel_federativo, soma_vinculos)

write_csv2(dados_tabela2,"./explorador_adeb/data/dados_final.csv")

