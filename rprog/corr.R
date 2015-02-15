corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  files = list.files(path = directory, pattern = '^\\d\\d\\d\\.csv$', full.names = TRUE)
  
  collect = numeric(0)
  
  for (file in files) {
    monitor = read.csv(file)
    
    complete = complete.cases(monitor)
    
    if (sum(complete) > threshold) {
      collect = c(collect, cor(monitor[complete, ]$nitrate, monitor[complete, ]$sulfate))
    }
    
  }
  
  collect

}