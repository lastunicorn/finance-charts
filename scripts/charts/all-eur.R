# ------------------------------------------------------------------------------
# All money (EUR) - ever

all |> 
  rowwise() |> 
  mutate(
    total_amount = sum(bcr_amount, ing_amount, brd_amount, bt_amount,
                       revolut_amount, cash_amount, gold_amount, teletrade_amount,
                       quanloop_amount, mintos_amount, peerberry_amount, xtb_amount,
                       bonds_amount, na.rm = TRUE)
  ) |>
  select(c(date, total_amount)) |> 
  left_join(exchange_rates, by = join_by(date)) |> 
  mutate(
    total_amount_eur = total_amount / exchange_eur
  ) |> 
  ggplot(aes(x = date, y = total_amount_eur)) +
  geom_line() +
  geom_area(fill = "gray50", alpha = .75) +
  labs(
    title = "All money (EUR) - ever",
    x = "Date",
    y = "Amount"
  )

save_plot("all-eur.png", width = 60, height = 10)
