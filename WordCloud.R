install.packages("rJava")
install.packages("memoise")
install.packages("multilinger")
install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"), type = "binary")
install.packages("remotes")

install.packages("workcloud")
install.packages("RColorBrewer")

remotes::install_github('haven-jeon/KoNLP',upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(rJava)
library(RColorBrewer)
library(stringr)
library(wordcloud)
library(KoNLP)

setwd("C:/homework_R")
data <- readLines("testmi.txt")

useSejongDic()
data <- sapply(data, extractNoun, USE.NAMES = F)

data_unlist <- unlist(data)
data_unlist <- gsub('[~!@#$%^&*()_+=?<>]ⓒ', '', data_unlist)
data_unlist <- gsub('[ㄱ-ㅎ]','',data_unlist)
data_unlist <- gsub('[a-z]','',data_unlist)
data_unlist <- gsub('[A-Z]','',data_unlist)
data_unlist <- gsub('[0-9]','',data_unlist)
data_unlist <- gsub("아이폰프로\\S*","아이폰프로",data_unlist)
data_unlist <- gsub("아이폰\\S*","아이폰",data_unlist)
data_unlist <- Filter(function(x){nchar(x)>=2}, data_unlist)
wordcount <- table(data_unlist)

wordcount_top <- head(sort(wordcount, decreasing = T),100)


display.brewer.all()
color <- brewer.pal(11,"Spectral")
windowsFonts(font=windowsFont("a한글사랑L"))
wordcloud(names(wordcount_top), wordcount_top, scale=c(1,0.5),random.order = FALSE, random.color = TRUE, colors = color, family = "font")
