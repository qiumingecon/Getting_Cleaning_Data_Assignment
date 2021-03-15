## ==========================================
## Getting and Cleaning Data Course Project
## Submission by Ming Qiu
## ==========================================

library(dplyr)
library(data.table)

FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileUrl, destfile = "./data_acc.zip")
unzip("./data_acc.zip")

# Reading relevant TXT files into R
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("class","activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "class")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "class")

# 1. Merge the training and the test sets to create one data set.
x_train_test <- rbind(x_train, x_test)
y_train_test <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Data_train_test <- cbind(Subject, y_train_test, x_train_test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
Data_select <- Data_train_test %>% select(subject, class, contains("mean"), contains("std"))

# 3. Use descriptive activity names to name the activities in the data set
Data_select$class <- activities[Data_select$class, 2]

# 4. Appropriately label the data set with descriptive variable names.
names(Data_select)[2] <- "activity"
names(Data_select) <- gsub("^t", "Time", names(Data_select))
names(Data_select) <- gsub("^f", "Frequency", names(Data_select))
names(Data_select) <- gsub("Acc", "Accelerometer", names(Data_select))
names(Data_select) <- gsub("Gyro", "Gyroscope", names(Data_select))
names(Data_select) <- gsub("BodyBody", "Body", names(Data_select))
names(Data_select) <- gsub("Mag", "Magnitude", names(Data_select))
names(Data_select) <- gsub("angle", "Angle", names(Data_select))
names(Data_select) <- gsub("gravity", "Gravity", names(Data_select))
names(Data_select)[3:ncol(Data_select)]  # Check variable names to see if anything else needs to be re-labelled

# 5. From the data set in step 4, create a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
Tidy_data <- Data_select %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean)) %>%
        print
write.table(Tidy_data, "Tidy_Data.txt")

# Check up
str(Tidy_data)
head(Tidy_data,10)
