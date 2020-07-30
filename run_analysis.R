  #Loading required packages
library(dplyr)

  #downloading required dataset
filename <- "projectfiles_UCI HAR Dataset.zip"

  #Checking if zip file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

  #Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

   #reading 'features.txt' and 'activity_labels.txt' files
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("sno","function"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

   #reading test files
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activitycode")

   #reading train files
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activitycode")

## 1)Merging the train and the test sets to create one data set
subjects <- rbind(subject_train, subject_test)
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
merged <- cbind(subjects, Y, X)

## 2)Extracting only the measurements on the mean and standard deviation for each measurement
selectedCols <- grep("mean\\(\\)|std\\(\\)", as.character(features[,2]))
selectedColNames <- features[selectedCols, 2]
x_data <- X[selectedCols]
allData <- cbind(subjects, Y, x_data)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

## 3)Using descriptive activity names(names from activity_labels dataset)to name the activities in the data set "allData"
allData$Activity <- factor(allData$Activity, levels = activities[,1], labels = activities[,2])
   # Changing Subject column values of allData to factors
allData$Subject <- as.factor(allData$Subject)

## 4)Appropriately labelling the data set "allData" with descriptive variable names
names(allData)<-gsub("^t", "time", names(allData))
names(allData)<-gsub("^f", "frequency", names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))

## 5)From the data set "allData", creating a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- allData %>% group_by(Subject, Activity) %>% summarise_all(funs(mean)) 
  ## writing the final tidy data set into a file
write.table(tidyData, "tidy_data.txt", row.names = FALSE, quote = FALSE)

#The final tidy data set can also be obtained using melt and dcast functions as shown by the 3-line code below:
    #library(reshape2)
    #meltData <- melt(allData, id = c("Subject", "Activity"))
    #tidyData <- dcast(meltData, Subject+Activity~variable,mean)
