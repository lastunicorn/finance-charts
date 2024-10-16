finance.charts_dir <- "charts"

ensure_dir <- function(path) {
  ifelse(dir.exists(path), FALSE, dir.create(path))
}

save_plot <- function(name, width = 30, height = 20) {
  ensure_dir(finance.charts_dir)
  filePath <- file.path(finance.charts_dir, name)
  ggsave(filePath, width = width, height = height, units="cm", dpi=300)
}
