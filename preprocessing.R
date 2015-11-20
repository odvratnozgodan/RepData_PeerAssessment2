suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(lubridate))

if(!exists("df")){
  if(file.exists("StormData.csv.bz2")){
    df = data.frame(read.csv("StormData.csv.bz2"));
  }else{
    download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",destfile = "StormData.csv.bz2", method = "curl");
    df = data.frame(read.csv("StormData.csv.bz2"));
  }
  df = (
    df %>% unite(bgn_date, BGN_DATE, BGN_TIME, sep=" ")
    %>% mutate(bgn_date = as.POSIXct(strptime(bgn_date, format="%m/%d/%Y 0:00:00 %H%M"))) 
    %>% mutate(END_DATE=paste(END_DATE, END_TIME))
    %>% unite(end_date, END_DATE, END_TIME, sep=" ")
    %>% mutate(end_date = as.POSIXct(strptime(end_date, format="%m/%d/%Y 0:00:00 %H%M"))) 
    %>% select(-BGN_TIME, -END_TIME)
  );
}

dim(df)
head(df)