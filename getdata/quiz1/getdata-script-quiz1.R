setwd("~/Documents/datasciencecoursera/getdata/quiz1")

library(xlsx)
library(XML)
library(data.table)

download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'getdata-data-ss06hid.csv', method = 'curl')
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx', destfile = 'getdata-data-DATA.gov_NGAP.xlsx', method = 'curl')
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', destfile = 'getdata-data-ss06pid.csv', method = 'curl')

csv = read.csv('getdata-data-ss06hid.csv')
sum(csv$VAL == 24, na.rm = TRUE)

dat = read.xlsx("getdata-data-DATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

fileUrl = "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc = xmlTreeParse(fileUrl, useInternal=TRUE)
root = xmlRoot(doc)
xmlSize(xpathSApply(root, "/response/row/row[zipcode='21231']"))

DT = fread('getdata-data-ss06pid.csv')
DT[,mean(pwgtp15),by=SEX]

