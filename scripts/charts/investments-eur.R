# ------------------------------------------------------------------------------
# Investments (EUR) - ever

all |> 
  select(
    date,
    gold_amount,
    teletrade_amount,
    quanloop_amount,
    mintos_amount,
    peerberry_amount,
    xtb_amount,
    bonds_amount
  ) |> 
  filter(date >= ymd("2023-01-01")) |> 
  add_row(
    date = ymd("2023-01-01")
  ) |> 
  left_join(exchange_rates, by = join_by(date)) |> 
  mutate(
    gold_amount = gold_amount / exchange_eur,
    teletrade_amount = teletrade_amount / exchange_eur,
    quanloop_amount = quanloop_amount / exchange_eur,
    mintos_amount = mintos_amount / exchange_eur,
    peerberry_amount = peerberry_amount / exchange_eur,
    xtb_amount = xtb_amount / exchange_eur,
    bonds_amount = bonds_amount / exchange_eur,
  ) |> 
  ggplot(aes(x = date)) +
  geom_line(aes(y = gold_amount), color = "orange") +
  geom_line(aes(y = teletrade_amount), color = "gray") +
  geom_line(aes(y = quanloop_amount), color = "gray50") +
  geom_line(aes(y = mintos_amount), color = "darkgreen") +
  geom_line(aes(y = peerberry_amount), color = "lightgreen") +
  geom_line(aes(y = xtb_amount), color = "red") +
  geom_line(aes(y = bonds_amount), color = "blue") +
  scale_y_continuous(labels = function(x) format(x, big.mark = " ", scientific = FALSE)) +
  labs(
    title = "Investments (EUR) - ever",
    x = "Date",
    y = "Amount"
  )



all |> 
  select(
    date,
    gold_amount,
    teletrade_amount,
    quanloop_amount,
    mintos_amount,
    peerberry_amount,
    xtb_amount,
    bonds_amount
  ) |> 
  filter(date >= ymd("2023-01-01")) |> 
  add_row(
    date = ymd("2023-01-01")
  ) |> 
  left_join(exchange_rates, by = join_by(date)) |> 
  mutate(
    gold_amount = gold_amount / exchange_eur,
    teletrade_amount = teletrade_amount / exchange_eur,
    quanloop_amount = quanloop_amount / exchange_eur,
    mintos_amount = mintos_amount / exchange_eur,
    peerberry_amount = peerberry_amount / exchange_eur,
    xtb_amount = xtb_amount / exchange_eur,
    bonds_amount = bonds_amount / exchange_eur,
  ) |> 
  ggplot(aes(x = date)) +
  geom_line(aes(y = gold_amount, color = "Gold")) +
  geom_line(aes(y = teletrade_amount, color = "TeleTrade")) +
  geom_line(aes(y = quanloop_amount, color = "Quanloop")) +
  geom_line(aes(y = mintos_amount, color = "Mintos")) +
  geom_line(aes(y = peerberry_amount, color = "PeerBerry")) +
  geom_line(aes(y = xtb_amount, color = "XTB")) +
  geom_line(aes(y = bonds_amount, color = "Bonds")) +
  scale_color_manual(name = "investments", values = c(
    "Gold" = "gold",
    "TeleTrade" = "gray",
    "Quanloop" = "gray30",
    "Mintos" = "darkgreen",
    "PeerBerry" = "lightgreen",
    "XTB" = "red",
    "Bonds" = "blue"
  )) +
  scale_y_continuous(labels = function(x) format(x, big.mark = " ", scientific = FALSE)) +
  labs(
    title = "Investments (EUR) - ever",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("investments-eur.png", width = 60, height = 10)
