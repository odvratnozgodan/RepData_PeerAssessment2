calculate_damage <- function(arg1, arg2, ... ){
  multiplier <-0
  if(toupper(arg2) == "B"){
    multiplier <- 10e9
  }else if(toupper(arg2) == "M"){
    multiplier <- 10e6
  }else if(toupper(arg2) == "K"){
    multiplier <- 10e3
  }else{
    return(0);
  }
  return(arg1*multiplier)
}

population_summary = (
  df %>% select(EVTYPE, FATALITIES, INJURIES) %>% group_by(EVTYPE) 
  %>% summarize(FATALITIES=sum(FATALITIES), INJURIES=sum(INJURIES))
  %>% mutate(TOTAL=FATALITIES + INJURIES)
  %>% arrange(desc(TOTAL))
)
dim(population_summary)
head(population_summary)

economic_summary = (
  df %>% mutate(damadge = calculate_damage(PROPDMG, PROPDMGEXP) + calculate_damage(CROPDMG, CROPDMGEXP))
  %>% select(EVTYPE, damadge) %>% group_by(EVTYPE) 
  %>% summarize(damadge=sum(damadge))
  %>% arrange(desc(damadge))
)
dim(economic_summary)
head(economic_summary)