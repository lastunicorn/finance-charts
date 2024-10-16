# ------------------------------------------------------------------------------
# XTB (EUR) - ever

xtb |> 
  left_join(exchange_rates, by = join_by(date)) |> 
  mutate(
    amount_eur = amount / exchange_eur
  ) |> 
  ggplot(aes(x = date, y = amount_eur)) +
  geom_line() +
  geom_area(fill = "gray60") +
  labs(
    title = "BCR (EUR) - ever",
    x = "Date",
    y = "Amount"
  )

save_plot("xtb-eur.png")