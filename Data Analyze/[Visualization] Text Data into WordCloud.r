library(KoNLP) #한글 처리
library(dplyr) #단어 정리
library(tidytext) #tibble
library(tidyverse)
library(stringr)
library(wordcloud2) #시각화
library(extrafont)
library(RColorBrewer)
data.lines<-readLines("content_0to5.txt",,encoding="UTF-8")
data.txt<-unlist(data.lines)

data.txt %>% tibble(text = .) %>% unnest_tokens(word,text,token=SimplePos09)
data.txt<-gsub("\t","",data.txt) #불필요한 탭 제거
data.txt <- gsub("\\d+","",data.txt)
data.txt <- gsub("-","",data.txt)
data.txt<-gsub("[[:punct:]]","",data.txt)
data.fr<-tibble(data.txt)

data.fr <- data.fr %>%
    unnest_tokens( output=word,input=data.txt, strip_punct=TRUE)
data.tk<-data.fr %>%
    unnest_tokens(output=token,input=word,SimplePos09)
data.tk %>% 
    filter(str_detect(token,"/n")) %>% mutate(pos_done=str_remove(token,"/.*$")) -> n_done
data.tk %>% filter(str_detect(token,"/p")) %>%
    mutate(pos_done=str_replace_all(token,"/.*$","다")) -> p_done

bind_rows(n_done,p_done) %>%
    filter(nchar(pos_done)>2) %>%
    select(pos_done) -> pos_result

pos_result %>%
    count(pos_done,sort=T)%>%
    view() -> pos_result
    
#시각화
#팔레트 불러오기
pal="random-light"
wordcount<-pos_result[c(2:301),]
wordcount_top<-head(wordcount,300)
wordcloud2(wordcount_top,fontFamily = "YDIYGO330",color=pal)