`run_analysis.R` script follows the five-step instructions and performs the data preparation.

1. **Download the dataset**
    * Dataset downloaded and the unzipped folder is called `UCI HAR Dataset`.

2. **Assign data to variables**
    * `features` (<- `features.txt`)
       - The features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
       - 561 rows, 2 columns. Column names are `n` and `functions`.  
    * `activities` <- `activity_labels.txt`
       - List of six activities each volunteer performed when the measurements were taken and its labels.
       -  6 rows, 2 columns. Column names are  `class` and `activity`.
    * `subject_test` <- `test/subject_test.txt`   
       - Contains test data of volunteers whose test subjects were observed.
       - 2947 rows, 1 column. Column name is `subject`. 
    * `x_test` <- `test/X_test.txt`
       - Contains recorded test data for each feature.
	   - 2947 rows, 561 columns.  
    *  `y_test` <- `test/y_test.txt`  
        - Contains test data of activities’ class labels.
        - 2947 rows, 1 columns. Column name is `class`. 
    *  `subject_train` <- `train/subject_train.txt`
        - Contains train data of volunteer whose training subjects were observed.
        - 7352 rows, 1 column. Column name is `subject`.
    *  `x_train` <- `train/X_train.txt`
         - Contains recorded training data for each feature.
         - 7352 rows, 561 columns.
    *  `y_train` <- `train/y_train.txt` 
         - Contains train data of activities’ class labels.
         - 7352 rows, 1 columns. Column name is `class`.

3. **Merges the training and the test sets to create one data set**
    
	* `x_train_test` is created by merging `x_train` and `x_test` using **rbind()** function
	* `y_train_test` is created by merging `y_train` and `y_test` using **rbind()** function
	* `Subject` is created by merging `subject_train` and `subject_test` using **rbind()** function
	* `Data_train_test` is created by merging `Subject`, `y_train_test` and `x_train_test` using **cbind()** function 

4. **Extracts only the measurements on the mean and standard deviation for each measurement**

    * `Data_select`  is created by subsetting `Data_train_test`, selecting `subject`, `code`, and measurement of mean and standard deviation.

5. **Uses descriptive activity names to name the activities in the data set**

    * Activities are named by matching numbers in `class` column of the `Data_select` with that of the `activities` variable.

6. **Appropriately labels the data set with descriptive variable names**

    * `class` column in `Data_select` renamed into `activities`
	* All `Acc` in column’s name replaced by `Accelerometer`
	* All `Gyro` in column’s name replaced by `Gyroscope`
	* All `BodyBody` in column’s name replaced by `Body`
	* All `Mag` in column’s name replaced by `Magnitude`
	* All start with character `f` in column’s name replaced by `Frequency`
	* All start with character `t` in column’s name replaced by `Time`

7. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**

-   `Tidy_Data` is created by sumarizing `Data_select` taking the means of each variable for each activity and each subject, after grouping by subject and activity.
-   Export `Tidy_Data` into `Tidy_Data.txt` file.
