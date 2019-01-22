url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url, destfile = "UCIdata.zip", mode = "wb")

unzip("UCIdata.zip", files = NULL, exdir = "Week4")

# read files
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt")

#combine files
xall <- rbind(xtest, xtrain)
yall <- rbind(ytest, ytrain)
subject <- rbind(testsubject, trainsubject)

# get information from feature 
feature <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

#get index for mean and std
mean_std_index <- grep("mean\\(\\)|std\\(\\)", feature[,2])
mean_std_set <- xall[,mean_std_index]

#replace number to description for activity
yall[,1] <- activity[yall[,1],2]

#get names for each column in mean_std_set from featurehe
names <- feature[mean_std_index,2]
names(mean_std_set) <- names

names(subject) <- "subjectID"
names(yall) <- "activity"


# create the final data set
finaldata <- cbind(mean_std_set, subject, yall)

summary <- aggregate(.~subjectID+activity, data=finaldata, mean)


