## CODE BOOK (Getting and Cleaning data course project)
- The **run_analysis.R** script contains R code to perform the 5 steps described in the course project’s definition. The code does the following: 

1. Downloading the dataset- Dataset is downloaded and extracted under the folder *'UCI HAR Dataset'*

2. Reading in all required datasets and assigning them to appropriate variables  
- features <- features.txt : (561 rows, 2 columns)
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.  
- activities <- activity_labels.txt : (6 rows, 2 columns)
List of activities performed when the corresponding measurements were taken and its codes (labels)  
- subject_test <- test/subject_test.txt : (2947 rows, 1 column)
contains test data of 9/30 volunteer test subjects being observed  
- x_test <- test/X_test.txt : (2947 rows, 561 columns)
contains recorded features test data  
- y_test <- test/y_test.txt : (2947 rows, 1 columns)
contains test data as activities’ code labels  
- subject_train <- test/subject_train.txt : (7352 rows, 1 column)
contains train data of 21/30 volunteer subjects being observed  
- x_train <- test/X_train.txt : (7352 rows, 561 columns)
contains recorded features train data  
- y_train <- test/y_train.txt : (7352 rows, 1 columns)
contains train data as activities’code labels  

3. Merging the *train* and the *test* sets to create one data set:  
X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function  
Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function  
subjects (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function  
merged (10299 rows, 563 columns) is created by merging subjects, Y and X using cbind() function  

4. Extracting only the measurements on the mean and standard deviation for each measurement    
x_data (10299 rows, 66 columns) is created by extracting only the data corresponding to the mean and standard deviation of each measurement from *'X'* dataset   
allData (10299 rows, 68 columns) is created by merging *subjects*, *Y* and *x_data* using cbind() function  

5. Using descriptive activity names(names from activity_labels dataset)to name the activities in the data set *"allData"*  
All the numbers in 'Activity' column of *'allData'* dataset is replaced with corresponding activity label by making the 'Activity' column into a factor variable with 6 levels and corresponding activity labels as taken from second column of the *activities* variable.     
Additionally, the 'Subject' column is also made into a factor variable of 30 levels.   

6. Appropriately labelling the data set "allData" with descriptive variable names  
All "Acc" in column names replaced by "Accelerometer"  
All "Gyro" in column names replaced by "Gyroscope"  
All "BodyBody" in column names replaced by "Body"  
All "Mag" in column names replaced by "Magnitude"  
All column names starting with "f" replaced by "Frequency"  
All column names starting with "t" replaced by "Time"    

7. From the data set "allData", creating a second, independent tidy data set with the average of each variable for each activity and each subject  
tidyData (180 rows, 68 columns) is created by first grouping 'allData' by 'Subject' and 'Activity' and then summarizing this obtained dataset on the basis of mean of each variable for each activity and each subject  

8. Exporting 'tidyData' dataset into **tidy_data.txt** file.
