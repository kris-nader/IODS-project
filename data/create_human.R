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

