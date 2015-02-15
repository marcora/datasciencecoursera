pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)

  files = list.files(path = directory, pattern = '^\\d\\d\\d\\.csv$', full.names = TRUE)
  files = files[id] # filter list of files by id
  
  values = numeric(0) # create empty numeric vector
  
  for (file in files) {
    monitor = read.csv(file)
    values = c(values, monitor[, pollutant])
  }
  
  mean(values, na.rm = TRUE)

}