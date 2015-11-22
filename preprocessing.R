suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(lubridate))

calculate_damage <- function(arg1, arg2){
  multiplier <-0
  ch = as.character(arg2)
  if( grepl("B", ch, TRUE) ){
    multiplier <- 10e9
  }else if( grepl("M", ch, TRUE) ){
    multiplier <- 10e6
  }else if( grepl("K", ch, TRUE) ){
    multiplier <- 10e3
  }else if( grepl("[0-9]", ch) ){
    multiplier <- 10**as.numeric(ch)
  }
  return(arg1*multiplier)
}

if(!exists("df") || is.null(df$prop_damage)){
  df = (
    df %>% mutate(BGN_DATE=as.character(BGN_DATE))
    %>% mutate(BGN_TIME=as.character(BGN_TIME))
    %>% mutate(END_DATE=as.character(END_DATE))
    %>% mutate(END_TIME=as.character(END_TIME))
  )
  
  df$prop_damage = mapply(calculate_damage, df$PROPDMG, df$PROPDMGEXP)
  df$crop_damage = mapply(calculate_damage, df$CROPDMG, df$CROPDMGEXP)
  
}
dim(df)
tbl_df(df)

complete_events_df = df %>% filter(as.Date(strptime(BGN_DATE, format="%m/%d/%Y 0:00:00")) > as.Date("1996-01-01"))

head(complete_events_df, 1)$BGN_DATE
tail(complete_events_df, 1)$BGN_DATE

