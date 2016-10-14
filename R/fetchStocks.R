### fetchStocks.R ###
# code from 
# http://allthingsr.blogspot.mx/2012/10/pull-yahoo-finance-key-statistics.html

library(quantmod)
library(readr)
library(lubridate)
library(dplyr)
library(tidyr)
source("R/webUtils.R")
source("R/retUtils.R")

ini_date <- ymd(20151231)
fin_date <- ymd(20160930)

# stock_list <- TTR::stockSymbols(exchange = "NYSE")
stock_list <- read_csv(
  "data/sp500.csv", 
  col_names = FALSE
)

priceData <- fetchYahoo(
  symbols = stock_list[[1]], 
  from = ini_date, 
  to = fin_date
)

# fill missing
coredata(priceData) <- 
  as.data.frame(priceData) %>% 
  fill(.direction = "down") %>% 
  fill(.direction = "up")

# returns
returnData <- dlyRet(priceData)
  
write_csv(data.frame(date = index(priceData), priceData), "data/stockHistPrice.csv")
write_csv(data.frame(date = index(returnData), returnData), "data/stockHistReturn.csv")
