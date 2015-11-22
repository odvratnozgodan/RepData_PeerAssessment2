suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(reshape2))

top_popuplation = head(population_summary, 10) %>% gather(TYPE, value, FATALITIES:TOTAL)

(
ggplot(top_popuplation, aes(EVTYPE, value))
  + geom_bar(aes(fill = TYPE), position = "dodge", stat="identity")
  + xlab("EVENT TYPE")
  + ylab("NUMBER OF PEOPLE")
  + ggtitle("Top most harmful events with respect to population health between 1999 and 2012")
  + coord_flip()
)


top_economic = (
  head(economic_summary, 10) 
  %>% mutate(prop_damage=prop_damage/10e9, crop_damage=crop_damage/10e9, TOTAL=TOTAL/10e9)
  %>% gather(TYPE, value, prop_damage:TOTAL) %>% arrange(desc(value))
)

(
ggplot(top_economic, aes(EVTYPE, value))
+ geom_bar(aes(fill = TYPE), position = "dodge", stat="identity")
+ xlab("EVENT TYPE")
+ ylab("BILLIONS OF $")
+ ggtitle("Top most harmful events with respect to population health between 1999 and 2012")
+ coord_flip()
)