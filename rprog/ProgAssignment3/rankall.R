rankall <- function(outcome, num = 'best') {

  ## Read outcome data
  data = read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## column 2 = hospital name
  ## column 7 = state
  ## column 11 = 30-day death rate for 'heart attack' outcome
  ## column 17 = 30-day death rate for 'heart failure' outcome
  ## column 23 = 30-day death rate for 'pneumonia' outcome
  
  ## Check that outcome is valid
  states = unique(data[, 7])

  outcomes = c('heart attack', 'heart failure', 'pneumonia')
  
  if(! outcome %in% outcomes) {
    stop("invalid outcome")    
  } 

  ## For each state, find the hospital of the given rank
  df = data.frame('hospital' = vector('character'), 'state' = vector('character'))
  
  cols = c(11, 17, 23)
  names(cols) = outcomes
  col = cols[outcome] # col for that outcome

  for (state in sort(states)) {
    statedata = data[data[, 7] == state, ] # filter by that state
    
    statedata[, col] <- as.numeric(statedata[, col]) # convert death rate to numeric for proper sorting
    if (num == 'worst') {
      statedata = statedata[order(-statedata[, col], statedata[, 2]), ] # sort by death rate (descending) and hospital name
    } else {
      statedata = statedata[order(statedata[, col], statedata[, 2]), ] # sort by death rate (ascending) and hospital name    
    }
    
    if (num %in% c('worst', 'best')) {
      hospital = statedata[1, 2] # hospital with the worst/best rank
    } else {
      if (num > nrow(statedata)) {
        hospital = NA # NA if given rank is invalid
      } else {
        hospital = statedata[num, 2] # hospital with the given rank      
      }
    }
    
    df = rbind(df, data.frame('hospital' = hospital, 'state' = state))
  }
  
  ## Return a data frame with the hospital names and the (abbreviated) state name
  df
}
