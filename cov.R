library(dplyr)
library(lubridate)
library(ggplot2)


df <- read.csv("covid.csv")
df$date <- mdy(df$date)
df$new_cases <- c(diff(df$total_cases),NA)
df$pos_rate_total <- round(df$new_cases/df$everyday_tests , 4)
df$pos_rate_idiotiki <- round(df$idiotiki_protovoulia.cases/df$idiotiki_protovoulia.test,4)
df$idiot_perc <- round(df$idiotiki_protovoulia.test/df$everyday_tests,4)
df$not_idiot_perc <- round(1-df$idiot_perc,4)

ggplot(df, aes(x=date, y= total_cases))+ geom_line()
ggplot(df, aes(x=date, y= everyday_tests)) + geom_line() + geom_smooth()
ggplot(df, aes(x=date, y=idiotiki_protovoulia.test)) + geom_line(colour="Red") + 
  geom_line(aes(x=date, y= everyday_tests), colour="Blue")


ggplot(df[50:229,], aes(x=date,y=pos_rate_total)) + geom_line(colour="Red") + 
  geom_line(aes(x=date,y=pos_rate_idiotiki), colour="Blue")


ggplot(df, aes(x=date,y=idiot_perc))+ geom_line() + geom_smooth(span=0.1) + 
  geom_line(aes(x=date,y=not_idiot_perc))  + geom_smooth(aes(x=date,y=not_idiot_perc),span=0.1)
