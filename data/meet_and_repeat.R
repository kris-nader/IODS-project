## load some packages

library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyr)


## load the data
bprs=read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
rats=read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# some exploring
colnames(bprs)
colnames(rats)

dim(bprs) # 40 11
dim(rats) # 16 13

str(bprs)
str(rats)

summary(bprs)
summary(rats)

## convert categorical values to factors
bprs$treatment=factor(bprs$treatment)
bprs$subject=factor(bprs$subject)

rats$ID=factor(rats$ID)
rats$Group=factor(rats$Group)

## convert the data to a long form
bprs_long= pivot_longer(bprs, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)
bprs_long= bprs_long %>% mutate(week = as.integer(substr(weeks,5,5)))
rats_long=pivot_longer(rats, cols=-c(ID,Group), names_to = "WD",values_to = "Weight") %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)

# take a look
dim(bprs_long) # 360 5
dim(rats_long) # 176 5

colnames(bprs_long)
colnames(rats_long)

str(bprs_long)
str(rats_long)

summary(bprs_long)
summary(rats_long)


# Long data: week and time data in the same column for different treatment/subject/ID/Group,
# for example, for each treatment and subject in the bprs_long dataset, we have all the week data and bprs data

write_csv(bprs_long,"./data/bprs_long.csv")
write_csv(rats_long,"./data/rats_long.csv")
