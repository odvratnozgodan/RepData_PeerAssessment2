suppressPackageStartupMessages(library(dplyr))
if(file.exists("StormData.csv.bz2")){
  df = data.frame(read.csv("StormData.csv.bz2"));
}else{
  download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",destfile = "StormData.csv.bz2", method = "curl");
  df = data.frame(read.csv("StormData.csv.bz2"));
}