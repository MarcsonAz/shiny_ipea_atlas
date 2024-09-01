# setup.R

# # Read and prepare data
# users <-
#   read_csv("data/users.csv") |>
#   mutate(evaluation = factor(evaluation, levels = c("None", "A", "B")),
#          propensity = factor(propensity, levels = c("Good", "Average", "Poor")))
# 
# users_by_group <-
#   users |>
#   group_by(industry, propensity, contract, evaluation) |>
#   summarize(success_rate = round(mean(outcome == "Won")* 100),
#             avg_amount = round(mean(amount)),
#             avg_days = round(mean(days)),
#             n = n(),
#             .groups = "drop")
# 
# 
# # Make layout elements
# industries = c("Academia",
#                "Energy",
#                "Finance",
#                "Government",
#                "Healthcare",
#                "Insurance",
#                "Manufacturing",
#                "Non-Profit",
#                "Pharmaceuticals",
#                "Technology")
# propensities = c("Good", "Average", "Poor")
# contracts = c("Monthly", "Annual")
# 
# sidebar_content <-
#   list(
#     selectInput("industries",
#                 "Select industries",
#                 choices = industries,
#                 selected = "",
#                 multiple  = TRUE),
#     selectInput("propensities",
#                 "Select propensities to buy",
#                 choices = propensities,
#                 selected = "",
#                 multiple  = TRUE),
#     selectInput("contracts",
#                 "Select contract types",
#                 choices = contracts,
#                 selected = "",
#                 multiple  = TRUE),
#     "This app compares the effectiveness of two types of free trials at converting users into customers, A (30-days) and B (100-days)."
#   )

## NOVO

pak::pak(c('readr','dplyr','tidyr'))
dados_tabela <- read_csv2('./data/dados_final.csv')


anos <- 1985:2021
nivel_federativos <- c("Federal","Estadual","Municipal")
poders <- c("Executivo","Legislativo","Judiciário")


sidebar_content <-
  list(
    selectInput("anos",
                "Selecionar anos",
                choices = anos,
                selected = "",
                multiple  = TRUE),
    selectInput("nivel_federativos",
                "Selecionar Nível Federativo",
                choices = nivel_federativos,
                selected = "",
                multiple  = TRUE),
    selectInput("poders",
                "Selecionar Poder",
                choices = poders,
                selected = "",
                multiple  = TRUE),
    "Esta painel busca explorar os dados do Atlas do Estado Brasileiro - Ipea"
  )


