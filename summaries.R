population_summary = (
  complete_events_df %>% select(EVTYPE, FATALITIES, INJURIES) %>% group_by(EVTYPE) 
  %>% summarize(FATALITIES=sum(FATALITIES), INJURIES=sum(INJURIES))
  %>% mutate(TOTAL=FATALITIES + INJURIES)
  %>% arrange(desc(TOTAL))
)
dim(population_summary)
head(population_summary)

economic_summary = (
  complete_events_df
  %>% select(EVTYPE, prop_damage, crop_damage)
  %>% group_by(EVTYPE) 
  %>% summarize(prop_damage=sum(prop_damage), crop_damage=sum(crop_damage))
  %>% mutate(TOTAL=prop_damage+crop_damage)
  %>% arrange(desc(TOTAL))
)

dim(economic_summary)
tbl_df(economic_summary)