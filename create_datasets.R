library(tm);library(NLP);library(R.utils); library(stringi);library(quanteda);library(readtext);library(stringr);library(SnowballC)
library(dplyr)

#four gram
mytf4 <- readtext("C:/Users/may/Desktop/DataScience/Data_Science_Capstone/final/en_US/*.txt", cache = FALSE,encoding="UTF-8")
corpus<-corpus(mytf4)
corpus_4gram<- tokens(corpus, what = "word", remove_numbers = TRUE, remove_punct = TRUE,
                      remove_symbols = TRUE, remove_separators = TRUE,
                      remove_twitter = TRUE, remove_hyphens = TRUE, remove_url = TRUE, ngrams = 4)
corpus_4gram_dfm<-dfm(corpus_4gram)
topfeatures(corpus_4gram_dfm,20)
corpus_4gram_dfm<-dfm_sort(corpus_4gram_dfm)
corpus_4gram_dfm<-dfm_trim(corpus_4gram_dfm,min_termfreq=2)
#convert dfm to dataframe
Fourgram<-convert(corpus_4gram_dfm, to="data.frame")
Fourgram[1:3,1:5]
#remove unessesary column 
Fourgram$document<-NULL
#calculate column freqencies
freq<-colSums(Fourgram)
head(freq)
#create a new data frame with words and frequncy
Fourgram_data <- data.frame(word=names(freq),frequency=freq)
Fourgram_data2<-Fourgram_data[with(Fourgram_data,order(-frequency)), ]

saveRDS(Fourgram_data2, file = "C:/Users/may/Desktop/DataScience/Data_Science_Capstone/CapstoneProject/data/four_gram.rds")

#three gram
corpus<-corpus(mytf4)
corpus_3gram<- tokens(corpus, what = "word", remove_numbers = TRUE, remove_punct = TRUE,
                      remove_symbols = TRUE, remove_separators = TRUE,
                      remove_twitter = TRUE, remove_hyphens = TRUE, remove_url = TRUE, ngrams = 3)
corpus_3gram_dfm<-dfm(corpus_3gram)
topfeatures(corpus_3gram_dfm,20)
corpus_3gram_dfm<-dfm_sort(corpus_3gram_dfm)
corpus_3gram_dfm<-dfm_trim(corpus_3gram_dfm,min_termfreq=2)
#convert dfm to dataframe
Trigram<-convert(corpus_3gram_dfm, to="data.frame")
Trigram[1:3,1:5]
#remove unessesary column 
Trigram$document<-NULL
#calculate column freqencies
freq<-colSums(Trigram)
head(freq)
#create a new data frame with words and frequncy
Trigram_data <- data.frame(word=names(freq),frequency=freq)
Trigram_data2<-Trigram_data[with(Trigram_data,order(-frequency)), ]

saveRDS(Trigram_data2, file = "C:/Users/may/Desktop/DataScience/Data_Science_Capstone/CapstoneProject/data/Tri_gram.rds")

#two gram
corpus<-corpus(mytf4)
corpus_2gram<- tokens(corpus, what = "word", remove_numbers = TRUE, remove_punct = TRUE,
                      remove_symbols = TRUE, remove_separators = TRUE,
                      remove_twitter = TRUE, remove_hyphens = TRUE, remove_url = TRUE, ngrams = 2)
corpus_2gram_dfm<-dfm(corpus_2gram)
topfeatures(corpus_2gram_dfm,20)
corpus_2gram_dfm<-dfm_sort(corpus_2gram_dfm)
corpus_2gram_dfm<-dfm_trim(corpus_2gram_dfm,min_termfreq=2)
#convert dfm to dataframe
Bigram<-convert(corpus_2gram_dfm, to="data.frame")
Bigram[1:3,1:5]
#remove unessesary column 
Bigram$document<-NULL
#calculate column freqencies
freq<-colSums(Bigram)
head(freq)
#create a new data frame with words and frequncy
Bigram_data <- data.frame(word=names(freq),frequency=freq)
Bigram_data2<-Bigram_data[with(Bigram_data,order(-frequency)), ]

saveRDS(Bigram_data2, file = "C:/Users/may/Desktop/DataScience/Data_Science_Capstone/CapstoneProject/data/Bi_gram.rds")

#one gram
corpus<-corpus(mytf4)
corpus_1gram<- tokens(corpus, what = "word", remove_numbers = TRUE, remove_punct = TRUE,
                      remove_symbols = TRUE, remove_separators = TRUE,
                      remove_twitter = TRUE, remove_hyphens = TRUE, remove_url = TRUE, ngrams = 1)
corpus_1gram_dfm<-dfm(corpus_1gram)
topfeatures(corpus_1gram_dfm,20)
corpus_1gram_dfm<-dfm_sort(corpus_1gram_dfm)
corpus_1gram_dfm<-dfm_trim(corpus_1gram_dfm,min_termfreq=2)
#convert dfm to dataframe
Unigram<-convert(corpus_1gram_dfm, to="data.frame")
Unigram[1:3,1:5]
#remove unessesary column 
Unigram$document<-NULL
#calculate column freqencies
freq<-colSums(Unigram)
head(freq)
#create a new data frame with words and frequncy
Unigram_data <- data.frame(word=names(freq),frequency=freq)
Unigram_data2<-Unigram_data[with(Unigram_data,order(-frequency)), ]

saveRDS(Unigram_data2, file = "C:/Users/may/Desktop/DataScience/Data_Science_Capstone/CapstoneProject/data/Uni_gram.rds")
