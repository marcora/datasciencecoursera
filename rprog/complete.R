complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  files = list.files(path = directory, pattern = '^\\d\\d\\d\\.csv$', full.names = TRUE)
  files = files[id] # filter list of files by id
  
  # create empty data frame
  df = data.frame(data.frame(id = numeric(), nobs = numeric()))
  
  for (file in files) {
    monitor = read.csv(file)
    # append row to data frame
    df = rbind(df, data.frame(id = monitor[1, 'ID'], nobs = sum(complete.cases(monitor))))
  }
  
  df

}