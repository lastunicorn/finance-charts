# install.packages("readODS")
library(readODS)
library(tidyverse)

# ------------------------------------------------------------------------------
# Functions

import_finance <- function(file_path, sheet_name) {
  df <- read_ods(file_path, sheet = sheet_name) |> 
    select(c(1, 2)) |> 
    janitor::clean_names() |> 
    rename(
      amount = total_lei
    ) |> 
    filter(amount != 0)
  
  return (df)
}

# ------------------------------------------------------------------------------
# Import from excel

dates <- read_ods("data-raw/finanțe.ods", sheet = "Dates") |> 
  janitor::clean_names()

exchange_rates <- read_ods("data-raw/finanțe.ods", sheet = "Curs_Valutar") |> 
  janitor::clean_names() |> 
  rename(
    exchange_eur = curs,
    exchange_gold = curs_aur
  )

bcr <- import_finance("data-raw/finanțe.ods", sheet = "BCR")
ing <- import_finance("data-raw/finanțe.ods", sheet = "ING")
brd <- import_finance("data-raw/finanțe.ods", sheet = "BRD")
bt <- import_finance("data-raw/finanțe.ods", sheet = "BT")
revolut <- import_finance("data-raw/finanțe.ods", sheet = "Revolut")
cash <- import_finance("data-raw/finanțe.ods", sheet = "Cash")
gold <- import_finance("data-raw/finanțe.ods", sheet = "Gold")
teletrade <- import_finance("data-raw/finanțe.ods", sheet = "TeleTrade")
quanloop <- import_finance("data-raw/finanțe.ods", sheet = "Quanloop")
mintos <- import_finance("data-raw/finanțe.ods", sheet = "Mintos")
peerberry <- import_finance("data-raw/finanțe.ods", sheet = "PeerBerry")
xtb <- import_finance("data-raw/finanțe.ods", sheet = "XTB")
bonds <- import_finance("data-raw/finanțe.ods", sheet = "Titluri de stat")

all <- dates |> 
  left_join(bcr, by = join_by(date)) |> 
  rename(bcr_amount = amount) |> 
  left_join(ing, by = join_by(date)) |> 
  rename(ing_amount = amount) |> 
  left_join(brd, by = join_by(date)) |> 
  rename(brd_amount = amount) |> 
  left_join(bt, by = join_by(date)) |> 
  rename(bt_amount = amount) |> 
  left_join(revolut, by = join_by(date)) |> 
  rename(revolut_amount = amount) |> 
  left_join(cash, by = join_by(date)) |> 
  rename(cash_amount = amount) |> 
  left_join(gold, by = join_by(date)) |> 
  rename(gold_amount = amount) |> 
  left_join(teletrade, by = join_by(date)) |> 
  rename(teletrade_amount = amount) |> 
  left_join(quanloop, by = join_by(date)) |> 
  rename(quanloop_amount = amount) |> 
  left_join(mintos, by = join_by(date)) |> 
  rename(mintos_amount = amount) |> 
  left_join(peerberry, by = join_by(date)) |> 
  rename(peerberry_amount = amount) |> 
  left_join(xtb, by = join_by(date)) |> 
  rename(xtb_amount = amount) |> 
  left_join(bonds, by = join_by(date)) |> 
  rename(bonds_amount = amount)
