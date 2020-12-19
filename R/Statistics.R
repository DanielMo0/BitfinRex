library(jsonlite)


GetPositionSize <- function(symbol, position)
{
  base <- "https://api-pub.bitfinex.com/v2/stats1/pos.size:1m:t"
  url <- paste(base, symbol, ":", position, "/last", sep = "")
  position <- jsonlite::fromJSON(url)

  return(position[2])
}

GetPositionSizeHistorical <- function(symbol, position)
{
  base <- "https://api-pub.bitfinex.com/v2/stats1/pos.size:1m:t"
  url <- paste(base, symbol, ":", position, "/hist", sep = "")
  position <- jsonlite::fromJSON(url)
  colnames(position) <- c("timestamp", "size")

  return(position)
}

GetPositionPercentage <- function(symbol, position)
{
  longSize <- bitfinex_getPositionSize(symbol, "long")
  shortSize <- bitfinex_getPositionSize(symbol, "short")
  total <- longSize + shortSize

  if (position == "long")
    return(longSize / total * 100)
  else
    return(shortSize / total * 100)
}
