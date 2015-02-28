best <- function(state, outcome) {
  
  ## Read outcome data
  data = read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  states = unique(data[, 7])

  if(! state %in% states) {
    stop("invalid state")    
  } 
  
  outcomes = c('heart attack', 'heart failure', 'pneumonia')

  if(! outcome %in% outcomes) {
    stop("invalid outcome")    
  } 
  
  ## Return hospital name in that state with lowest 30-day death rate
  cols = c(11, 17, 23)
  names(cols) = outcomes
  col = cols[outcome]
  data = data[data[, 7] == state, ]
  data[, col] <- as.numeric(data[, col])
  data = data[order(data[, col], data[, 2]), ]
  data[1, 2]
}
