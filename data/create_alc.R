# Kristen M Nader
# 12.17.2023
# https://www.archive.ics.uci.edu/dataset/320/student+performance 

library(dplyr)

'%ni%'=Negate('%in%')

student_mat=read.csv("./student-mat.csv",sep=";")
student_por=read.csv("./student-por.csv",sep=";")

str(student_mat)
str(student_por)


cols_a=c("failures","paid","absences","G1","G2","G3")
common_cols=setdiff(colnames(student_por), cols_a)
student_merge=inner_join(student_mat, student_por, by = common_cols,suffix=c(".math",".por"))
student_merge_unique=unique(student_merge) # i have 370 rows and 39 columns

str(student_merge_unique)

notcommon_cols=setdiff(colnames(student_por), common_cols)

alko=select(student_merge_unique, one_of(common_cols))

for(colnames in notcommon_cols) {
    two_cols=select(student_merge_unique, starts_with(colnames))
    first_col=two_cols[,1]
    if(is.numeric(first_col)) {
        alko[colnames]=round(rowMeans(two_cols))
    } else { 
        alko[colnames]=first_col
    }
}

alko$alko_use = (alko$Dalc + alko$Walc)/2
alko$high_use=ifelse(alko_use>2,TRUE,FALSE)

glimpse(alko) # 370 observations
head(alko)
write_csv(alko,"./alko_data.csv")

alko1=read_csv("./alko_data.csv")
