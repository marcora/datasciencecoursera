setwd("~/Documents/datasciencecoursera/getdata/quiz3")

library(jpeg)
library(dplyr)
library(Hmisc)

download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'getdata-data-ss06hid.csv', method = 'curl')

df = read.csv('getdata-data-ss06hid.csv')

agricultureLogical = (df$ACR == 3 & df$AGS == 6)

which(agricultureLogical)

download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', destfile = 'jeff.jpg', method = 'curl')
img = readJPEG('jeff.jpg', native = TRUE)

quantile(img, probs = c(0.3, 0.8))

download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = 'getdata-data-GDP.csv', method = 'curl')
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile = 'getdata-data-EDSTATS_Country.csv', method = 'curl')

gdp = read.csv('getdata-data-GDP.csv', skip = 5, header = FALSE, nrows = 190, col.names = c('CountryCode', 'Ranking', 'Blank1', 'CountryName', 'GDP', 'Blank2', 'Blank3', 'Blank4', 'Blank5', 'Blank6'))
edstats = read.csv('getdata-data-EDSTATS_Country.csv')


gdp = tbl_df(gdp)
edstats = tbl_df(edstats)

gdp = gdp %>%
  select(-starts_with('Blank')) %>%
  mutate(GDP = as.numeric(gsub(',', '', GDP)), Ranking.Percentile = cut2(Ranking, g=5))

merged = merge(gdp, edstats, by = 'CountryCode', all = FALSE)
merged = tbl_df(merged)
merged = arrange(merged, GDP)
merged = group_by(merged, Income.Group)

head(merged, n = 13)
nrow(merged)

summarise(merged, Average.Ranking = mean(Ranking))

table(merged$Income.Group, merged$Ranking.Percentile)
