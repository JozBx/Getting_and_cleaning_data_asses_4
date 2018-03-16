#Getting and Cleaning Data Project:

# You should create one R script called run_analysis.R that does the following. 
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. 

# STEP 0: Download and extract the data

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
current_folder <- getwd()
destfile <- paste(current_folder, "dataset.zip", sep="/")

if (!file.exists(destfile)) {                           # Check if the file already exists
        
        download.file(URL, destfile)                    # Download data
        file <- unzip(destfile)                         # Unzip the file
        folder <- unlist(strsplit(file[1],"/"))[2]      # Gets the folder's name of the unzipped file
        
} else {
        print("UCI HAR Dataset already exists") # Returns the folder name
}
                
# STEP 1: Merge all data together
#FROM THE README.TXT
#        - 'README.txt'
# - 'features_info.txt': Shows information about the variables used on the feature vector.
# - 'features.txt': List of all features.
# - 'activity_labels.txt': Links the class labels with their activity name.
# - 'train/X_train.txt': Training set.
# - 'train/y_train.txt': Training labels.
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.

# Read the data

trainData <- read.table(paste(folder, "train/X_train.txt", sep="/"))          #Read data from X_train.txt
head(trainData, 6)
trainLabel <- read.table(paste(folder, "train/y_train.txt", sep="/"))         #Read data from y_train.txt
table(trainLabel)
trainSubject <- read.table(paste(folder, "train/subject_train.txt", sep="/")) #Read data from subject_train.txt
testData <- read.table(paste(folder, "test/X_test.txt", sep="/"))             #Read data from X_test.txt
testLabel <- read.table(paste(folder, "test/y_test.txt", sep="/"))            #Read data from y_test.txt
table(testLabel) 
testSubject <- read.table(paste(folder, "test/subject_test.txt", sep="/"))    #Read data from subject_test.txt

# Join the data

joinData <- rbind(trainData, testData)
head(joinData,2)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

#STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement

features <- read.table(paste(folder, "features.txt", sep = "/"))
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinData <- joinData[, meanStdIndices]
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

#STEP 3: Uses descriptive activity names to name the activities in the data set

activity <- read.table(paste(folder, "activity_labels.txt", sep = "/"))
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

#STEP 4: Appropriately labels the data set with descriptive variable names

names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
write.table(cleanedData, "merged_data.txt") # write out the 1st dataset in the current R folder

#STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of 
#        each variable for each activity and each subject

subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
        for(j in 1:activityLen) {
                result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == cleanedData$subject
                bool2 <- activity[j, 2] == cleanedData$activity
                result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
                row <- row + 1
        }
}
head(result, 6)
write.table(result, "data_with_means.txt") # write out the 2nd dataset in the current R folder
