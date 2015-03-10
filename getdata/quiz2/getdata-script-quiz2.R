## question 1
library(httr)
app = oauth_app(appname = "github", key = "28c895885231451b173a", secret = "6bf514dd6463632e3f88cfba8b566be0a6a7572e")
github_token = oauth2.0_token(oauth_endpoints("github"), app)
token = config(token = github_token)
req = GET("https://api.github.com/users/jtleek/repos", token)
repos = content(req)
for (repo in repos) {
  if (repo$name == 'datasharing') {
    message('the datasharing repo was created at ', repo$created_at)
    break
  }
}

## question 2
download.file(url = "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = 'getdata-data-ss06pid.csv')
acs = read.csv('getdata-data-ss06pid.csv')
head(sqldf("select pwgtp1 from acs where AGEP < 50"))
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

## question 3
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
lines = readLines(con)
close(con)
nchar(lines[10])
nchar(lines[20])
nchar(lines[30])
nchar(lines[100])

## question 4
df = read.fwf(
  file=url("http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
  widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4),
  skip=4
)
sum(df[,4])