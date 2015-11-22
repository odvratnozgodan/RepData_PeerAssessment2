suppressPackageStartupMessages(library(tm))
if(!file.exists("keywords.csv")){
  source("data_loading.R" ,echo = TRUE)
  words_df = (df %>% mutate(EVTYPE = tolower(gsub("[^[:alnum:][:space:]']", " ", as.character(EVTYPE))))
        %>% mutate(EVTYPE = tolower(gsub("and", "", as.character(EVTYPE)))) 
        %>% select(EVTYPE)
      )
  rm(df)
  write.csv(words_df, file="keywords.csv")
}else{
  words_df = data.frame(read.csv("keywords.csv"));
}
set.seed(1)

#words_df = sample_n(words_df, 2000)
words.vectors = as.character(words_df$EVTYPE)
# build a corpus
words.corpus <- Corpus(VectorSource(words.vectors))

# build a term-document matrix
words.dtm <- TermDocumentMatrix(words.corpus)
#words.dtm

# inspect most popular words
findFreqTerms(words.dtm, lowfreq=30)

# remove sparse terms to simplify the cluster plot
# Note: tweak the sparse parameter to determine the number of words.
# About 10-30 words is good.
words.dtm2 <- removeSparseTerms(words.dtm, sparse=0.95)



# convert the sparse term-document matrix to a standard data frame
words.df <- as.data.frame(words.dtm2)

# inspect dimensions of the data frame
nrow(words.df)
ncol(words.df)
'
words.df.scale <- scale(words.df)
d <- dist(words.df.scale, method = "euclidean") # distance matrix
fit <- hclust(d, method="ward")
plot(fit) # display dendogram?

groups <- cutree(fit, k=5) # cut tree into 5 clusters
# draw dendogram with red borders around the 5 clusters
rect.hclust(fit, k=5, border="red")
'