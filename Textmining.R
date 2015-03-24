cname <- file.path("C:", "texts")   
cname   
dir(cname)   
Load the R package for text mining and then load your texts into R.

library(tm)   
docs <- Corpus(DirSource(cname))   

summary(docs)   
ocs <- tm_map(docs, removePunctuation)   
 
# Processing the texts
for(j in seq(docs))   
{   
  docs[[j]] <- gsub("/", " ", docs[[j]])   
  docs[[j]] <- gsub("@", " ", docs[[j]])   
  docs[[j]] <- gsub("\\|", " ", docs[[j]])   
}   

  
docs <- tm_map(docs, removeNumbers)   

docs <- tm_map(docs, tolower)   

docs <- tm_map(docs, removeWords, stopwords("english"))   
   

library(SnowballC)   
docs <- tm_map(docs, stemDocument)   
  

docs <- tm_map(docs, stripWhitespace)   
 

# To treat your preprocessed documents as text documents.

docs <- tm_map(docs, PlainTextDocument)  


dtm <- DocumentTermMatrix(docs)   
dtm   
tdm <- TermDocumentMatrix(docs)   
tdm 
freq <- colSums(as.matrix(dtm))   
length(freq) 

m <- as.matrix(dtm)   
dim(m)   
write.csv(m, file="dtm.csv") 
 # This makes a matrix that is 10% empty space, maximum.   
dtms <- removeSparseTerms(dtm, 0.1) 
inspect(dtms)  

# Now creating bag of words 
freq[head(ord)]  
freq[tail(ord)] 

head(table(freq), 20)   
tail(table(freq), 20) 

freq <- colSums(as.matrix(dtms))   
freq 
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)   
head(freq, 14) 
wf <- data.frame(word=names(freq), freq=freq)   
head(wf) 

# plot bag of words
library(ggplot2)   
p <- ggplot(subset(wf, freq>2), aes(word, freq))    
p <- p + geom_bar(stat="identity")   
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))   
p
