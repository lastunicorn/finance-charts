# ------------------------------------------------------------------------------
# Functions

create_chart_ron <- function(df, name, file_name) {
  df |>
    mutate(
      year = year(date)
    ) |>
    ggplot(aes(x = date, y = amount)) +
    geom_line() +
    geom_area(fill = "gray50", alpha = .75) +
    facet_wrap(~ year, scale = "free_x") +
    labs(
      title = paste(name, " (RON) - per year", sep = ""),
      x = "Date",
      y = "Amount"
    )

  save_plot(file_name)
}

create_chart_eur <- function(df, name, file_name) {
  df |>
    left_join(exchange_rates, by = join_by(date)) |>
    mutate(
      amount_eur = amount / exchange_eur,
      year = year(date)
    ) |>
    ggplot(aes(x = date, y = amount_eur)) +
    geom_line() +
    geom_area(fill = "gray50", alpha = .75) +
    facet_wrap(~ year, scale = "free_x") +
    labs(
      title = paste(name, " (EUR) - per year", sep = ""),
      x = "Date",
      y = "Amount"
    )

  save_plot(file_name)
}

create_chart_eur_ever <- function(df, name, file_name) {
  df |> 
    left_join(exchange_rates, by = join_by(date)) |> 
    mutate(
      amount_eur = amount / exchange_eur
    ) |> 
    ggplot(aes(x = date, y = amount_eur)) +
    geom_line() +
    geom_area(fill = "gray50", alpha = .75) +
    labs(
      title = paste(name, " (EUR)", sep = ""),
      x = "Date",
      y = "Amount"
    )
  
  save_plot(file_name, width = 60)
}

create_charts <- function(df, name) {
  file_name = name |> tolower() |> str_trim() |> str_replace_all(" ", "-")
  
  file_name_ron = paste(file_name, "-ron-per-year.png", sep = "")
  create_chart_ron(df, name, file_name_ron)
  
  file_name_eur = paste(file_name, "-eur-per-year.png", sep = "")
  create_chart_eur(df, name, file_name_eur)
  
  file_name_eur_ever = paste(file_name, "-eur-ever.png", sep = "")
  create_chart_eur_ever(df, name, file_name_eur_ever)
}

# ------------------------------------------------------------------------------
# Create charts for each account (RON and EUR)

create_charts(bcr, "BCR")
create_charts(ing, "ING")
create_charts(brd, "BRD")
create_charts(bt, "BT")
create_charts(revolut, "Revolut")
create_charts(cash, "Cash")
create_charts(gold, "Gold")
create_charts(teletrade, "TeleTrade")
create_charts(quanloop, "Quanloop")
create_charts(mintos, "Mintos")
create_charts(peerberry, "PeerBerry")
create_charts(xtb, "XTB")
create_charts(bonds, "Bonds")
