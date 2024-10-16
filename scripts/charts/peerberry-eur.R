# ------------------------------------------------------------------------------
# PeerBerry (EUR) - ever

peerberry |> 
  add_row(
    date = ymd("2023-01-01"),
    amount = 1
  ) |> 
  left_join(exchange_rates, by = join_by(date)) |> 
  mutate(
    amount_eur = amount / exchange_eur
  ) |> 
  ggplot(aes(x = date, y = amount_eur)) +
  geom_line() +
  geom_area(fill = "gray60") +
  scale_y_continuous(labels = function(x) format(x, big.mark = " ", scientific = FALSE)) +
  labs(
    title = "PeerBerry (EUR) - ever",
    x = "Date",
    y = "Amount"
  )

save_plot("peerberry-eur.png", width = 30, height = 10)
