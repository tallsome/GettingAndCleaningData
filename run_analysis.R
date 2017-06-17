#Basic assumption : the zip file (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is downloaded and unzipped into the R Home Directory of(~/UCI HAR Dataset/)

library(data.table)
library(dtplyr)
library(dplyr)

#Reading in labels for data variables and index for activities 
featurelist<- fread("features.txt")
activityindex<- fread("activity_labels.txt")

#Read train data
subjecttrain<- fread("./train/subject_train.txt")
activitytrain<- fread("./train/y_train.txt")
datatrain<- fread("./train/X_train.txt")

#Read test data
subjecttest<- fread("./test/subject_test.txt")
activitytest<- fread("./test/y_test.txt")
datatest<- fread("./test/X_test.txt")


#Part 1 - Merge the training and the test sets to create one data set.
c_subject<- rbind(subjecttrain, subjecttest)
c_activity<- rbind(activitytrain, activitytest)
c_data<- rbind(datatrain, datatest)

#Apply the labels from features.txt file to column headers of combined data table
colnames(c_data)<- t(featurelist[,2])
#Changing all data table variables to lower case.
colnames(c_data)<- tolower(names(c_data))

#Applying variable names to combined activity and subject data tables.
colnames(c_activity)<- "activity"
colnames(c_subject)<- "subject"

#Part 2- Extracts only the measurements on the mean and standard deviation for each measurement. 
c_data<-select(c_data, grep("mean|std", names(c_data)))
#Merging the subject and activity columns to the data set.
completedata<- cbind(c_subject, c_activity, c_data)
print(dim(completedata))

#Part 3-Uses descriptive activity names to name the activities in the data set
#applying the activity index to the dataset and moving the activity variable to the left of the table.
activitybycat<-merge(completedata, activityindex, by.x = "activity", by.y="V1", all.x=T)
activitybycat$activity<-activitybycat$V2
activitybycat<-select(activitybycat, -V2)

#Part 4-Appropriately labels the data set with descriptive variable names.
names(activitybycat)<-gsub("[(]", "", names(activitybycat))
names(activitybycat)<-gsub("[)]", "", names(activitybycat))
names(activitybycat)<-gsub("acc", "accelerometer", names(activitybycat))
names(activitybycat)<-gsub("gyro", "gyroscope", names(activitybycat))
names(activitybycat)<-gsub("bodybody", "body", names(activitybycat))
names(activitybycat)<-gsub("mag", "magnitude", names(activitybycat))
names(activitybycat)<-gsub("^t", "time", names(activitybycat))
names(activitybycat)<-gsub("^f", "frequency", names(activitybycat))
names(activitybycat)<-gsub("-mean()", "mean", names(activitybycat))
names(activitybycat)<-gsub("-std()", "std", names(activitybycat))
names(activitybycat)<-gsub("-freq()", "frequency", names(activitybycat))
names(activitybycat)<-gsub(".mean().$", "mean", names(activitybycat))
names(activitybycat)<-gsub(".std().$", "std", names(activitybycat))
names(activitybycat)<-gsub(".freq().$", "frequency", names(activitybycat))
View(names(activitybycat))


#Part 5-From the data set in step 4, creates a second, independent tidy data set with the average
#       of each variable for each activity and each subject.
tidydataset<-aggregate(.~activity+subject, activitybycat, mean)
View(tidydataset)
#exporting the result to a text file.
 write.table(tidydataset, file="tidydata.txt")
 print("file tidydata.txt has been created/updated")