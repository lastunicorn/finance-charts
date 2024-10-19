# ------------------------------------------------------------------------------
# All money (RON) - ever

all |> 
  mutate(
    liquid_amount = sum(bcr_amount, ing_amount, brd_amount, bt_amount,
                        revolut_amount, cash_amount, na.rm = TRUE),
  ) |> 
  select(c(date, total_amount, liquid_amount)) |> 
  ggplot(aes(x = date)) +
  geom_line(aes(y = total_amount)) +
  geom_area(aes(y = total_amount), fill = "lightgreen") +
  geom_line(aes(y = liquid_amount)) +
  geom_area(aes(y = liquid_amount), fill = "gray60") +
  scale_y_continuous(labels = function(x) format(x, big.mark = " ", scientific = FALSE)) +
  labs(
    title = "All money (RON) - ever",
    x = "Date",
    y = "Amount (lei)"
  )

save_plot("all-ron.png", width = 60, height = 10)
