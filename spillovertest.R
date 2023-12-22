library(tidyverse)
library(fixest)
library(kableExtra)
library(fixest)
library(ggpubr)
library(RColorBrewer)
library(haven)
library(fwildclusterboot)
library(modelsummary)
library(scales)
library(lme4)
library(did2s)
library(readxl)
library(Spillover)


ltc <- read_xlsx("LTC.xlsx")
btc <- read_xlsx("BTC.xlsx")
xrp <- read_xlsx("XRP.xlsx")goldsub <- subset(gold, select = c("date","close"))
gold <- read_xlsx("financialmarket.xlsx",sheet="GOLD") 
vix <- read_xlsx("financialmarket.xlsx",sheet="VIX")
sp500 <- read_xlsx("financialmarket.xlsx",sheet="SP500") 

goldsub <- subset(gold, select = c("date","close"))
vixsub <- subset(vix, select = c("date","close"))
sp500sub <- subset(sp500, select = c("date","close"))

btcsub <- subset(btc, select = c("date","close"))
ltcsub <- subset(ltc, select = c("date","close"))
xrpsub <- subset(xrp, select = c("date","close"))

cryptomerged <- merge(btcsub, ltcsub, by="date",all.x = TRUE)
colnames(cryptomerged) <- c('date','btc','ltc') 
cryptomerged <- merge(cryptomerged, xrpsub, by="date",all.x = TRUE)
colnames(cryptomerged) <- c('date','btc','ltc', 'xrp') 
cryptomerged2 <- subset(cryptomerged, date>"2015-01-30")

dy_results <- dynamic.spillover(data=cryptomerged2, width=200, na.fill = T, remove.own = FALSE)
 
