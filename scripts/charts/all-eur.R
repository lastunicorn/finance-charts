# ------------------------------------------------------------------------------
# All money (EUR) - ever

all |> 
  mutate(
    liquid_amount = sum(bcr_amount, ing_amount, brd_amount, bt_amount,
                        revolut_amount, cash_amount, na.rm = TRUE),
  ) |> 
  select(c(date, total_amount, liquid_amount)) |> 
  left_join(exchange_rates, by = join_by(date)) |> 
  mutate(
    total_amount_eur = total_amount / exchange_eur,
    liquid_amount_eur = liquid_amount / exchange_eur
  ) |> 
  ggplot(aes(x = date)) +
  geom_line(aes(y = total_amount_eur)) +
  geom_area(aes(y = total_amount_eur), fill = "lightgreen") +
  geom_line(aes(y = liquid_amount_eur)) +
  geom_area(aes(y = liquid_amount_eur), fill = "gray60") +
  scale_y_continuous(labels = function(x) format(x, big.mark = " ", scientific = FALSE)) +
  labs(
    title = "All money (EUR) - ever",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("all-eur.png", width = 60, height = 10)
