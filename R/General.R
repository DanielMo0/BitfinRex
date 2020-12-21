PlatformIsOnline <-function()
{
  return(jsonlite::fromJSON("https://api-pub.bitfinex.com/v2/platform/status"))
}

GetAllTradingPairs<-function()
{
  return(jsonlite::fromJSON("https://api-pub.bitfinex.com/v2/conf/pub:list:pair:exchange"))
}
