library(shiny); library(tm); library(stringr)
Unigram_data2<-readRDS("./data/Uni_gram.rds")
Bigram_data2<-readRDS("./data/Bi_gram.rds")
Trigram_data2<-readRDS("./data/Tri_gram.rds")
Fourgram_data2<-readRDS("./data/four_gram.rds")

StringClean <- function(String)
{
        
        StringIn <- iconv(String,"latin1","ASCII",sub = "");
        corpus_In <- VCorpus(VectorSource(StringIn))
        toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
        corpus_In <- tm_map(corpus_In, toSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")
        corpus_In <- tm_map(corpus_In, toSpace, "@[^\\s]+")
        corpus_In <- tm_map(corpus_In, content_transformer(tolower))
        corpus_In <- tm_map(corpus_In, removePunctuation)
        corpus_In <- tm_map(corpus_In, removeNumbers)
        corpus_In <- tm_map(corpus_In, stripWhitespace)
        corpus_In <- tm_map(corpus_In, PlainTextDocument)
        corpus_In<-as.character(corpus_In[[1]])
        
        if (nchar(corpus_In) > 0) {
                return(corpus_In); 
        } else {
                return("");
        }
}

WordPrediction<-function(String)
{
        StringInput<-unlist(strsplit(String,split = " "));
        StringInputLength<-length(StringInput);
        match<-F
        
        if (StringInputLength >=3 & !match)  {
                Search <- paste(StringInput[(StringInputLength-2):StringInputLength], collapse=" "); 
                Search <- paste("^",Search, sep = "");
                MatchStr <- Fourgram_data2[grep(Search, Fourgram_data2$word), ];
                
                if (length(MatchStr[,1]) > 0) {
                        NextWord <- MatchStr[1,1];
                        Gram <- 4;
                        match <- T;
                }
        }
        
        if (StringInputLength >=2 & !match)  {
                Search <- paste(StringInput[(StringInputLength-1):StringInputLength], collapse=" "); 
                Search <- paste("^",Search, sep = "");
                MatchStr <- Trigram_data2[grep(Search, Trigram_data2$word), ];
                
                if (length(MatchStr[,1]) > 0) {
                        NextWord <- MatchStr[1,1];
                        Gram <- 3;
                        match <- T;
                }
        }
        
        if (StringInputLength >=1 & !match)  {
                Search <- StringInput[StringInputLength]; 
                Search <- paste("^",Search, sep = "");
                MatchStr <- Bigram_data2[grep(Search, Bigram_data2$word), ];
                
                if (length(MatchStr[,1]) > 0) {
                        NextWord <- MatchStr[1,1];
                        Gram <- 2;
                        match <- T;
                }
        }
        
        if (StringInputLength >0 & !match)  {
                NextWord <- Unigram_data2$word[1];
                Gram <- 1;
                match <- T;
        }
        
        if (StringInputLength >0 & match) {
                OutputResults <- data.frame(UserInputString = String, PredictedWord = word(NextWord, -1 ,sep=" "), AppPrediction = NextWord, Gram_number = Gram);
                return(OutputResults);
        } else {
                OutputResults <- data.frame(UserInputString = "None", PredictedWord ="None", AppPrediction = "None", GramType_number = "None");
                return(OutputResults);
        } 
}

shinyServer(function(input,output){
        observeEvent(input$do, {
                CleanString <- StringClean(input$InputString);
                Predict <- WordPrediction(CleanString);
                output$PredictedWord <- renderText({as.character(Predict[1,2])});
        })
}
)