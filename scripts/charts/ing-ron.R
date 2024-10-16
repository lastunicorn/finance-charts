# ------------------------------------------------------------------------------
# ING (RON)

ing |> 
  uncount(2) |> 
  mutate(
    amount = lag(amount)
  ) |> 
  slice_tail(n = -1) |> 
  ggplot(aes(x = date, y = amount)) +
  geom_line() +
  geom_area(fill = "gray60") +
  labs(
    title = "ING (RON)",
    x = "Date",
    y = "Amount (RON)"
  )

save_plot("ing-ron.png")
