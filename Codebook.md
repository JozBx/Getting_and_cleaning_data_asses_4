## CODEBOOK

This file describes the variables, data, and transformations that you can find in the Get&Cli_Asses4.R file.

1. The site from where the data come from:
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
2. The data for the project:   
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    
The Get&Cli_Asses4 script performs the following steps:

#### STEP 0: Download and extract the data

0. If the folder does not already exist, download the zip file from the adress above, and unzip it in the current R folder, otherwise it prints a message saying that the folder already exists.

#### STEP 1: Merge all data together

1. Load X_train.txt, y_train.txt and subject_train.txt from the "train" folder into the objects trainData, trainLabel and trainSubject respectively  
2. Load X_test.txt, y_test.txt and subject_test.txt from the "test" folder into the objects testData, testLabel and testsubject respectively
3. Join testData and trainData into the object joinData; do the same for testLabel and trainLabel into joinLabel; and testSubject and trainSubject into joinSubject.
4. Load the features.txt file from the unzipped folder into the object features. I only store the measurements on the mean and standard deviation, as required  

#### STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement

5. Clean the column names of the subset. First remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.

#### STEP 3: Uses descriptive activity names to name the activities in the data set

6. Read the activity_labels.txt file from the unzipped folder and store the data in a variable called activity.
7. Clean the activity names in the second column of activity. First make all names to lower cases. If the name has an underscore between letters, remove the underscore and capitalize the letter immediately after the underscore.
8. Transform the values of joinLabel according to the activity data frame.

#### STEP 4: Appropriately labels the data set with descriptive variable names

9. Combine the joinSubject, joinLabel and joinData by column to get a new cleaned data frame, cleanedData. Properly name the first two columns, "subject" and "activity". 
10. Print the cleanedData out to "merged_data.txt" file in current working directory.

#### STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

11. Generate a second independent tidy data set with the average of each measurement for each activity and each subject. There are 30 unique subjects and 6 unique activities. Then, for each combination, the program calculates the mean of each measurement with the corresponding combination. The program then prints the result out to "data_with_means.txt" file in current working directory.
