library(readr)
library(dplyr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

str(hd)
str(gii)
summary(hd)
summary(gii)


colnames(hd)=c("HDIRank","Country","HDI","Life.Exp","Edu.Exp","MeanYrsEdu","GNI","GNI_HDI_RANK")
colnames(gii)=c("GIIrank","Country","GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")

gii =gii %>%mutate(edu2Ratio = Edu2.F/Edu2.M, labRatio = Labo.F/Labo.M)

human =inner_join(hd, gii, by = "Country")
dim(human) # 195 obs and 19 variables

write_csv(human,file="./data/human_data.csv")

human=read_csv("./data/human_data.csv")
str(human)
summary(human)
## 195 rows and 19 columns

library(dplyr)
colnames(human)
keep = c("Country", "edu2Ratio", "labRatio", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human = select(human, one_of(keep))
dim(human)


human_cc =filter(human, complete.cases(human))
dim(human_cc)

#Removing the region-related observations.
tail(human_cc, 10)
last = nrow(human_cc) - 7
human_= human_cc[1:last, ]
dim(human_)


write.csv(human_, file = "./data/human_data.csv")
