## COURSE PROJECT GETTING AND CLEANING DATA

## creating a Data folder, if it hasn't existed yet
if(!file.exists("data")){dir.create("data")}

## downloading the data from internet
fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip",method="auto")

## extracting the data into data folder
unzip("./data/Dataset.zip",exdir="./data")

## reading test and train files
test<-read.table("./data/UCI HAR Dataset/test/X_test.txt",header=F,sep="",nrows=2947)
train<-read.table("./data/UCI HAR Dataset/train/X_train.txt",header=F,sep="",nrows=7352)

## naming the variables in test and train data frames
names(test)<-read.table("./data/UCI HAR Dataset/features.txt",header=F,sep="")[,2]
names(train)<-read.table("./data/UCI HAR Dataset/features.txt",header=F,sep="")[,2]

## creating activity and subject variables in test and training data frames
test$activity<-read.table("./data/UCI HAR Dataset/test/y_test.txt",header=F)[,1]
test$subject<-read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=F)[,1]

train$activity<-table("./data/UCI HAR Dataset/train/y_train.txt",header=F)[,1]
train$subject<-read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=F)[,1]

## "merging" test and train data frames into a single temporary data frame (Step 1)
temp<-rbind(test,train)

## creating new independent data frame with first 2 columns deciding activity and subject nr.
Galaxy<-data.frame(temp$activity,temp$subject)

## adding meaningful names to first 2 columns
names(Galaxy)<-as.vector(c("activity","subject"))

## screening the temporary data frame and adding variables to the new data frame
for (i in 1:561){
  name<-names(temp)[i]
  if(((grepl("mean()",name ) | grepl("std()",name)))&!grepl("meanFreq",name)){ 
    ## only including the variables with mean and standard deviation defined (Step 2)
    newName=""
    ## renaming the column names to make them understandable (Step 3&4)
    if (substr(name,1,1)=="t")      newName<-paste0(newName,"Time")
    if(substr(name,1,1)=="f")       newName<-paste0(newName,"Frequency")
    if (grepl("Body",name))         newName<-paste(newName,"Body")
    if (grepl("Gravity",name))      newName<-paste(newName,"Gravity")
    if(grepl("Gyro",name))          newName<-paste(newName,"Gyroscope")
    if(grepl("Acc",name))           newName<-paste(newName,"Accelerometer")
    if(grepl("Jerk",name))          newName<-paste(newName,"Jerk")
    if(grepl("Mag",name))           newName<-paste(newName,"Magnitude")
    if(grepl("mean()",name))        newName<-paste(newName,"mean")
    if(grepl("std",name))           newName<-paste(newName,"std")
    if(grepl("X",name))             newName<-paste(newName,"X")
    if(grepl("Y",name))             newName<-paste(newName,"Y")
    if(grepl("Z",name))             newName<-paste(newName,"Z")
    
    Galaxy[[newName]]<-temp[[name]]
  }
}

## saving the Galaxy data frame into a text file to be saved in the repository
write.table(Galaxy, "Galaxy.txt", row.names=FALSE)

## loading the library for convenient process of computing the average values
library(reshape2)

## counting the means from Galaxy data (step 5) 
melt<-melt(Galaxy,id=c("activity","subject"))
avg<-dcast(melt,activity+subject~variable,mean)

## adding "-average" to the variable names
for (i in 3:68){
  names(avg)[i]<-paste(names(avg)[i],"- average")
}

## saving avg as averages text file, this will be uploaded
write.table(avg, "averages.txt", row.names=FALSE)
