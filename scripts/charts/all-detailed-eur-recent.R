# ------------------------------------------------------------------------------
# All money detailed (EUR) - recent

all |> 
  filter(date >= "2021-08-01") |> 
  left_join(exchange_rates, by = join_by(date)) |> 
  mutate(
    liquid_amount = sum(bcr_amount, ing_amount, brd_amount, bt_amount, revolut_amount, cash_amount, na.rm = TRUE),
    liquid_amount_eur = liquid_amount / exchange_eur,
    
    plus_gold_amount = liquid_amount + gold_amount,
    plus_gold_amount_eur = plus_gold_amount / exchange_eur,
    
    plus_xtb_amount = plus_gold_amount + xtb_amount,
    plus_xtb_amount_eur = plus_xtb_amount / exchange_eur,
    
    plus_quanloop_amount = plus_xtb_amount + quanloop_amount,
    plus_quanloop_amount_eur = plus_quanloop_amount / exchange_eur,
    
    plus_mintos_amount = plus_quanloop_amount + mintos_amount,
    plus_mintos_amount_eur = plus_mintos_amount / exchange_eur,
    
    plus_peerberry_amount = plus_mintos_amount + peerberry_amount,
    plus_peerberry_amount_eur = plus_peerberry_amount / exchange_eur,
    
    plus_bonds_amount = plus_peerberry_amount + bonds_amount,
    plus_bonds_amount_eur = plus_bonds_amount / exchange_eur,
    
    plus_teletrade_amount = plus_bonds_amount + teletrade_amount,
    plus_teletrade_amount_eur = plus_teletrade_amount / exchange_eur,
    
    total_amount_eur = total_amount / exchange_eur
  ) |> 
  
  ggplot(aes(x = date)) +
  
  # --- total
  geom_area(aes(y = total_amount_eur), fill = "lightgreen") +
  geom_line(aes(y = total_amount_eur), color = "gray10", size = .2) +
  #geom_point(aes(y = total_amount_eur), size = 1, color = "darkgreen", alpha = .25) +
  #geom_point(aes(y = total_amount_eur), size = .25, color = "darkgreen", alpha = .5) +
  
  # --- teletrade
  geom_area(aes(y = plus_teletrade_amount_eur), fill = "gray90") +
  geom_line(aes(y = plus_teletrade_amount_eur), color = "gray10", size = .2) +
  
  # --- bonds
  geom_area(aes(y = plus_bonds_amount_eur), fill = "gray") +
  geom_line(aes(y = plus_bonds_amount_eur), color = "gray10", size = .2) +
  
  # --- peerberry
  geom_area(aes(y = plus_peerberry_amount_eur), fill = "green") +
  geom_line(aes(y = plus_peerberry_amount_eur), color = "gray10", size = .2) +
  
  # --- mintos
  geom_area(aes(y = plus_mintos_amount_eur), fill = "darkgreen") +
  geom_line(aes(y = plus_mintos_amount_eur), color = "gray10", size = .2) +
  
  # --- quanloop
  geom_area(aes(y = plus_quanloop_amount_eur), fill = "lightblue") +
  geom_line(aes(y = plus_quanloop_amount_eur), color = "gray10", size = .2) +
  
  # --- xtb
  geom_area(aes(y = plus_xtb_amount_eur), fill = "red") +
  geom_line(aes(y = plus_xtb_amount_eur), color = "gray10", size = .2) +
  
  # --- gold
  geom_area(aes(y = plus_gold_amount_eur), fill = "gold") +
  geom_line(aes(y = plus_gold_amount_eur), color = "gray10", size = .2) +
  
  # --- liquid
  geom_area(aes(y = liquid_amount_eur), fill = "gray60") +
  geom_line(aes(y = liquid_amount_eur), color = "gray10", size = .2) +
  #geom_point(aes(y = liquid_amount_eur), size = .75) +
  
  scale_y_continuous(labels = function(x) format(x, big.mark = " ", scientific = FALSE)) +
  labs(
    title = "All money detailed (EUR) - recent",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("all-detailed-eur-recent.png", width = 30, height = 10)
