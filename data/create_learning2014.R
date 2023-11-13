# Kristen Michelle Nader 
# Ex session2
# Data Wrangling 5 points
library(dplyr)
library(readr)

data=read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                   header = TRUE, sep = "\t")
# to explore the structure
str(data) # all variables except gender(chr M/F) are integers
# to check dimensions
dim(data) # 183 rows and 60 columns

#d_sm~D03+D11+D19+D27



d_sm=rowMeans(data[,c("D03","D11","D19","D27")])
#d_ri~D07+D14+D22+D30
d_ri=rowMeans(data[,c("D07","D14","D22","D30")])
#d_ue~D06+D15+D23+D31
d_ue=rowMeans(data[,c("D06","D15","D23","D31")])
#Deep ~ d_sm+d_ri+d_ue; 
data$deep=rowMeans(cbind(d_sm, d_ri, d_ue))

#st_os~ST01+ST09+ST17+ST25
st_os=rowMeans(data[,c("ST01","ST09","ST17", "ST25")])
#st_tm~ST04+ST12+ST20+ST28
st_tm=rowMeans(data[,c("ST04","ST12","ST20", "ST28")])
#stra~st_os+st_tm
data$stra=rowMeans(cbind(st_os, st_tm))

#su_lp~SU02+SU10+SU18+SU26
su_lp=rowMeans(data[,c("SU02","SU10","SU18", "SU26")])
#su_um~SU05+SU13+SU21+SU29
su_um=rowMeans(data[,c("SU05","SU13","SU21", "SU29")])
#su_sb~SU08+SU16+SU24+SU32
su_sb=rowMeans(data[,c("SU08","SU16","SU24", "SU32")])
#surf~su_lp+su_um+su_sb
data$surf=rowMeans(cbind(su_lp, su_um, su_sb))

# attitude~Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj
data$attitude=rowMeans(data[,c("Da","Db","Dc", "Dd","De","Df","Dg","Dh","Di","Dj")])


data_filtr=data[,c("Age","attitude","Points","gender","deep","stra","surf")]
analysis=data_filtr %>% filter(Points!=0)
dim(analysis) # 166 obs and 7 var

write_csv(analysis,file="./data/learning2014.csv")

a1=read_csv("./data/learning2014.csv")
