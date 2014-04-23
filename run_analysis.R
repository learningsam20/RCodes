##
## This is a code snippet for assignment on data cleansing course
##

library(sqldf)

##
## The following code gets the feature and activity names for the dataset
##

coln <- read.csv("features.txt",sep=" ",header=FALSE)
actn <- read.csv("activity_labels.txt",sep=" ",header=FALSE)

##
## This section is for handling data from test datasets and combining them to form complete test dataset
##

seqtestx <- c(seq(17,8977,by=16))
sqltestx <- "select "
for(i in 1:length(seqtestx))
{
 sqltestx <- paste(sqltestx, "substr(V1,",((i-1)*16+1),",16),")
}
sqltestx <- substring(sqltestx,1,nchar(sqltestx)-1)
sqltestx <- paste(sqltestx, " from filetestx")
filetestx <- file("X_test.txt")
ftestx <- sqldf(sqltestx)
colnames(ftestx) <- as.character(coln$V2)
testy <- read.fwf("y_test.txt",widths=(2),header=FALSE)
testyname <- merge(testy,actn,by="V1")
ftestx$activity <- as.character(testyname$V2)
testsubject <- read.fwf("subject_test.txt",widths=(2),header=FALSE)
ftestx$subject <- testsubject$V1

##
## This section is for handling data from training datasets and combining them to form complete training dataset
##

seqtrainx <- c(seq(17,8977,by=16))
sqltrainx <- "select "
for(i in 1:length(seqtrainx))
{
 sqltrainx <- paste(sqltrainx, "substr(V1,",((i-1)*16+1),",16),")
}
sqltrainx <- substring(sqltrainx,1,nchar(sqltrainx)-1)
sqltrainx <- paste(sqltrainx, " from filetrainx")
filetrainx <- file("X_train.txt")
ftrainx <- sqldf(sqltrainx)
colnames(ftrainx) <- as.character(coln$V2)
trainy <- read.fwf("y_train.txt",widths=(2),header=FALSE)
trainyname <- merge(trainy,actn,by="V1")
ftrainx$activity <- as.character(trainyname$V2)
trainsubject <- read.fwf("subject_train.txt",widths=(2),header=FALSE)
ftrainx$subject <- trainsubject$V1

##
## This section combined the complete datasets obtained above into one dataset
## fcombined is frame with all the data combined together
##

fcombined <- rbind(ftestx,ftrainx)

## fstdmean is the frame containing mean and std deviation of all the observations

fstdmean <- fcombined[,c("subject","activity",colnames(fcombined)[grepl("mean",colnames(fcombined))|grepl("std",colnames(fcombined))])]

##
## The following section calculates the mean/averages of all the std deviation and mean variables
##

fsql <- "select subject, activity, "
cstdmean <- colnames(fstdmean)

## Following block replaces ( and space with _ as it is done while sending data to SQLite
for(i in 3:length(cstdmean))
{
 fsql <- paste(fsql," avg(",gsub('([[:punct:]])|\\s+','_',cstdmean[i]),"),",sep="")
}
fsql <- substring(fsql,1,nchar(fsql)-1)
fsql <- paste(fsql, " from fstdmean group by subject,activity",sep="")
dstdmeanframe <- sqldf(fsql)

## Following block changes the names back to Avg prefixed variable names as specified in observations data
colnames(dstdmeanframe) <- c("subject","activity",paste("Avg ",colnames(fstdmean)[3:81],sep=""))

## dstmeanframe is the frame containing average of all mean and standard observations
## Write the csv file with above dataframe
fw <- file("meandata.txt","w")
write.csv(dstdmeanframe,fw)
close(fw)
