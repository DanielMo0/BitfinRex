library(dplyr)

GetCandles <- function(timeFrame = "1m",
                       symbol = "BTCUSD",
                       start = "0",
                       end = 1608508800000,
                       limit = "10000")
{
  url <- paste("https://api.bitfinex.com/v2/candles/trade:", timeFrame,":t", symbol,"/hist?start=", start, "&end=", end, "&limit=", limit, "&sort=1", sep="")
  data <- httr::GET(url)

  print(data$url)

  data %<>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON() %>%
    matrix(ncol=6) %>%
    tibble::as_tibble() %>%
    setNames(c("mts", "open", "close", "high", "low", "volume")) %>%
    dplyr::mutate(mts_dt = lubridate::as_datetime(mts/1000)) %>%
    timetk::tk_tbl(preserve_index = FALSE) %>%
    dplyr::select(mts_dt,dplyr::everything())
  return(data)
}

GetCandles()
