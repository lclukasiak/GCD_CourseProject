## run_analysis.R
## Getting and Cleaning Data - Course Project
## 
## Code to do the following:
## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for
##    each measurement
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data
##    set with the average of each variable for each activity and each
##    subject
##
runAnalysis <- function() {
    library(plyr)
    library(dplyr)
    
    ## SECTION 1: Get and combine Training and Test sets
    ## Read In Test
    fileTestSubject <- "./UCI HAR Dataset/test/subject_test.txt"
    dataTestSubject <- read.table(fileTestSubject,header=FALSE)
    fileTestX <- "./UCI HAR Dataset/test/x_test.txt"
    dataTestX <- read.table(fileTestX,header=FALSE)
    fileTestY <- "./UCI HAR Dataset/test/y_test.txt"
    dataTestY <- read.table(fileTestY,header=FALSE)
    ## Read In Train
    fileTrainSubject <- "./UCI HAR Dataset/train/subject_train.txt"
    dataTrainSubject <- read.table(fileTrainSubject,header=FALSE)
    fileTrainY <- "./UCI HAR Dataset/train/y_train.txt"
    dataTrainY <- read.table(fileTrainY,header=FALSE)
    fileTrainX <- "./UCI HAR Dataset/train/x_train.txt"
    dataTrainX <- read.table(fileTrainX,header=FALSE)
    ## Combine Test and Train
    dataY <- rbind(dataTestY,dataTrainY)
    dataX <- rbind(dataTestX,dataTrainX)
    dataSubject <- rbind(dataTestSubject,dataTrainSubject)
    ## Read in Features and activity
    fileFeatures <- "./UCI HAR Dataset/features.txt"
    dataFeatures <- read.delim(fileFeatures,sep=" ",header=FALSE)
    fileActivity <- "./UCI HAR Dataset/activity_labels.txt"
    dataActivity <- read.table(fileActivity,header=FALSE)

    ## SECTION 2: Build primary data set
    ## Select the mean() and std() observations from dataX
    meanX <- grep(glob2rx("*mean()*"), dataFeatures$V2)
    #dataMeanX <- dataX[,meanX]
    stdX <- grep(glob2rx("*std()*"), dataFeatures$V2)
    ## Combine the data
    data <- cbind(dataSubject,dataY,dataX[,meanX],dataX[,stdX])
    
    ## SECTION 3 & 4: Label data set with clear and descriptive names
    ##                Label Activity values 1 to 6 as descriptive names
    ## Build header vector and apply to data set
    dataHeader <- c("Subject","Activity")
    dataHeader <- c(dataHeader,as.character(dataFeatures[meanX,2]))
    dataHeader <- c(dataHeader,as.character(dataFeatures[stdX,2]))
    names(data) <- dataHeader
    ## Overwrite activity column with new friendly activity name
    dataActivity <- mutate(dataActivity,V2=gsub("_"," ",dataActivity$V2))
    dataActivity <- mutate(dataActivity,V2=tolower(dataActivity$V2))
    ## Replace activity IDs with friendly activity names
    data[,2] <- mapvalues(data$Activity, dataActivity$V1, dataActivity$V2)
    
    ## SECTION 5: Summarize and take mean
    ## Create summarized data set taking mean of each variable
    dataMean <- ddply(data, .(Activity, Subject), numcolwise(mean))
    
    ## SECTION 6: Output
    ## Write tidy data file
    write.table(dataMean, file = "dataset.txt")
    
}

## 
## Required to submit:
## 1) a tidy data set as described above (see For Upload below)
## 2) a link to a Github repository with your script for performing the
##    analysis
## 3) a code book that describes the variables, the data, and any
##    transformations or work that was performed to clean up the data
##    called CodeBook.md
## 4) a README.md in the repo with your scripts.  This repos explains how
##    all of the scripts work and how they are connected
##
## For Upload:
## 1) Upload the tiday data set created in step 5 of the instructions
## 2) Upload data set as a txt file created with write.table() using
##    row.name=FALSE (do not cut and paste a dataset directly into the text
##    box, as this may cause errors saving your submission)
##
## end comments
## 