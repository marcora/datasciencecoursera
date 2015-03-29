library(dplyr)

setwd("~/Documents/datasciencecoursera/getdata/quiz4")

download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'getdata-data-ss06hid.csv', method = 'curl')

df = read.csv('getdata-data-ss06hid.csv')

strsplitnames = strsplit(names(df), split = 'wgtp')

strsplitnames[123]

download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = 'getdata-data-GDP.csv', method = 'curl')

gdp = read.csv('getdata-data-GDP.csv', skip = 5, header = FALSE, nrows = 190, col.names = c('CountryCode', 'Ranking', 'Blank1', 'CountryName', 'GDP', 'Blank2', 'Blank3', 'Blank4', 'Blank5', 'Blank6'))

gdp = tbl_df(gdp)

gdp %<>% 
  select(-starts_with('Blank')) %>%
  mutate(GDP = as.numeric(gsub(',', '', GDP)))

mean(gdp$GDP, na.rm = TRUE)

countryNames = as.character(gdp$CountryName)

sum(grepl("^United", countryNames, useBytes = TRUE))


download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile = 'getdata-data-EDSTATS_Country.csv', method = 'curl')

edstats = read.csv('getdata-data-EDSTATS_Country.csv')

edstats = tbl_df(edstats)

merged = merge(gdp, edstats, by = 'CountryCode', all = FALSE)
merged = tbl_df(merged)

specialNotes = as.character(merged$Special.Notes)
sum(grepl("^Fiscal year end: June", specialNotes, useBytes = TRUE))

library(quantmod)
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)
sum(sapply(sampleTimes, function(d){year(d) == 2012}))
sum(sapply(sampleTimes, function(d){year(d) == 2012 & wday(d, label = TRUE, abbr = FALSE) == 'Monday'}))
