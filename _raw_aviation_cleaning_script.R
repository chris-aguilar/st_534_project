library(readr)
library(dplyr)
library(lubridate)
library(fpp3)


aviation_data_raw <- read_csv("aviation_accident_data_raw.csv")

aviation_provisional <- aviation_data_raw |>
  filter(year(EventDate) >= 1983) |> # source says new attributes after 1983
  filter(State %in% state.name, !is.na(EventDate)) |> # 50 states only for simplicity
  select(EventDate, EventType) |>
  mutate(year_qtr = yearquarter(EventDate)) |> # pull year-quarter from datetime
  count(year_qtr) |> # find event volumes without accounting for event type
  as_tsibble(index=year_qtr) # create tsibble object for easier date filters


write_csv(aviation_provisional, "aviation_incidents.csv")
