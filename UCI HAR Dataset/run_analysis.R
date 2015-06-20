## 0. Download and unzip files
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileUrl,destfile="UCI_HAR_Dataset.zip",mode="wb")
unzip("UCI_HAR_Dataset.zip")
##########################################################

##########################################################
## OBJECTIVE #1: Merges the training and the test sets to create one data set.
## 1. Creating of the combined data frame
## 1.a. Combining X datasets - data from accelerometer and gyroscope
## Loading Data from X_train and X_test
Xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
Xtest<-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
Xlabels<-read.table("./UCI Har Dataset/features.txt")
##
## Combining the Raw Data from the Xtrain and the Xtest tables and the column headers from Xlabels
X<-rbind(Xtrain,Xtest)
names(X)<-Xlabels[,2]
##########################################################

##########################################################
## 1.b. Combining Y datasets - data regarding activity levels
## Loading Data from Y_train and Y_test
Ytrain<-read.table("./UCI HAR Dataset/train/Y_train.txt",header=FALSE)
Ytest<-read.table("./UCI HAR Dataset/test/Y_test.txt",header=FALSE)
##
## Combining the Raw Data from the Ytrain and the Ytest tables
Y<-rbind(Ytrain,Ytest)
names(Y)<-"activityCode"
###########################################################

###########################################################
## OBJECTIVE #3: Uses descriptive activity names to name the activities in the data set
## 1.c. (Also OBJECTIVE 3) Load lookup table of acivity_labels
Ylabels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
names(Ylabels)<-c("activityCode","activity")
## Create new column in Y converting the numeric codes to activity labels
Y$activity<-as.character(Ylabels[match(Y$activityCode,Ylabels$activityCode),"activity"])
## THIS COMPLETES OBJECTIVE #3
## The names provided in the activity_labels file were used to convert the number values in the activityCode column to alphanumeric values in the activity column.
##############################################################

##############################################################
## 1.d. Combining subject datasets - identity of test subject
## Loading Data from subject_train and subject_test
subjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
subjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
##
## Combining the Raw Data from the subjecttrain and the subjecttest tables
subject<-rbind(subjecttrain,subjecttest)
names(subject)<-"subject"
###########################################################

###########################################################
## 1.e.Merging all data sets
df<-cbind(subject,Y,X)
## THIS COMPLETES OBJECTIVE 1
## X_train,X_test,Y_train,Y_test,subject_train,and subject_test were combined. Variables are labeled using the labels in the features.txt file.
###########################################################

###########################################################
## OBJECTIVE #2: Extracts only the measurements on the mean and standard deviation for each measurement. 
## 2. Creation of new data frame containing only mean and standard deviations
idx<-grep("-mean\\(\\)|-std\\(\\)",Xlabels[,2])
dfRed<-df[,c(1,3,idx+3)]
## THIS COMPLETES OBJECTIVE #2
## Data frame has been reduced from 564 columns (subject, activityCode, activity, and 561 readings from the smart phone) to a data frame containing only 69 variables (subject, activityCode, activity, and 66 mean and std data.)
###########################################################

###########################################################
## 4. OBJECTIVE #4: Appropriately labels the data set with descriptive variable names.
## 4.a. Extracts labels from dfReduced
labelsRed<-names(dfRed)
## 4.b. Remove parentheses
labelsRed<-gsub("\\(|\\)","",names(dfRed))
## THIS COMPLETES OBJECTIVE 4
###########################################################

###########################################################
## OBJECTIVE #5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## 5. Calculate mean per subject per activity
## Calculate the mean of each of the columns
tidy<-aggregate(dfRed[,3:68],by=list(dfRed$subject,dfRed$activity),mean)
## Provide new labels
names(tidy)<-labelsRed
## Write data frame to file
write.table(tidy,"tidyDataset.txt",row.name=FALSE)
## THIS COMPLETES OBJECTIVE 5
## New tidy data set created with the variables subject, activity, and 66 means and standard deviations.
###########################################################
