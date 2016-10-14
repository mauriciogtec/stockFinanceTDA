library(quantmod)
library(readr)
library(lubridate)
library(dplyr)
library(tidyr)
library(MASS)
source("R/statUtils.R")
sourceCpp("R/distUtilsCpp.cpp")

# read
returnData <- read_csv("data/stockHistReturn.csv")
returnData <- xts(returnData[ ,-1], returnData[[1]])

# # covarianceMatrix
# wt <- optimist_wt(nrow(returnData), halflife = 30)
# # retMeans <- as.numeric(apply(returnData, 2, function(x) sum(x*wt)))
# matA <- matB <- coredata(returnData)
# for (i in 1:ncol(mat)) {
#   matB[ ,i] <- matA[ ,i]*wt[i]
# }
# cov <- (t(matA) %*% matB)/(1 - sum(wt^2)) # covarianza corregida por sesgo
# rm(matA, matB)

# correlationMatrix
cor <- cor(coredata(returnData))

# distance matrix
dis <- 1/cor^2 - 1

