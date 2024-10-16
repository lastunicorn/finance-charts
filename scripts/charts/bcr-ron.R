# ------------------------------------------------------------------------------
# BCR (RON) - ever

bcr |> 
  ggplot(aes(x = date, y = amount)) +
  geom_line() +
  geom_area(fill = "gray60") +
  labs(
    title = "BCR (RON) - ever",
    x = "Date",
    y = "Amount (RON)"
  )

save_plot("bcr-ron.png")