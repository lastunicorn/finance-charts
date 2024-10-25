# ------------------------------------------------------------------------------
# All money (EUR) - recent

all |> 
  filter(date >= "2021-08-01") |> 
  left_join(exchange_rates, by = join_by(date)) |> 
  mutate(
    total_amount_eur = total_amount / exchange_eur,
    liquid_amount = sum(bcr_amount, ing_amount, brd_amount, bt_amount, revolut_amount, cash_amount, na.rm = TRUE),
    liquid_amount_eur = liquid_amount / exchange_eur
  ) |> 
  ggplot(aes(x = date)) +
  geom_line(aes(y = total_amount_eur), color = "darkgreen") +
  geom_area(aes(y = total_amount_eur), fill = "lightgreen") +
  #geom_point(aes(y = total_amount_eur), size = 1, color = "darkgreen", alpha = .25) +
  #geom_point(aes(y = total_amount_eur), size = .25, color = "darkgreen", alpha = .5) +
  geom_line(aes(y = liquid_amount_eur)) +
  geom_area(aes(y = liquid_amount_eur), fill = "gray60") +
  #geom_point(aes(y = liquid_amount_eur), size = .75) +
  scale_y_continuous(labels = function(x) format(x, big.mark = " ", scientific = FALSE)) +
  labs(
    title = "All money (EUR) - recent",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("all-eur-recent.png", width = 30, height = 10)
