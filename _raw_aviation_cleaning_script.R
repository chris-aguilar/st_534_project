library(readr)
library(dplyr)
library(lubridate)
library(fpp3)

# Leaving this script in as demo of data clean and prep
# THIS WILL NOT RUN SINCE RAW DATA NOT KEPT DUE TO 63MB SIZE
aviation_data_raw <- read_csv("aviation_accident_data_raw.csv")

aviation_provisional <- aviation_data_raw |>
  filter(year(EventDate) >= 1983) |> # source says new attributes after 1983
  filter(State %in% state.name, !is.na(EventDate)) |> # 50 states only for simplicity
  select(EventDate, EventType) |>
  mutate(year_qtr = yearquarter(EventDate)) |> # pull year-quarter from datetime
  count(year_qtr) # find event volumes without accounting for event type


write_csv(aviation_provisional, "aviation_incidents.csv")
