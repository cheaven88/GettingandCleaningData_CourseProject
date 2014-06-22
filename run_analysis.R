##Setting working drive
setwd("C:/Users/cheaven/Documents/R Projects/Coursera/Getting and Cleaning Data/Course Project")
##Loading necessary packages
library(sqldf)
##Loading Data
#Explanatory data
features <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity_labels <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

#Training data set 
X_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
#Training set - activity labels
y_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
#Training set - subject labels
subject_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

#Test data set
X_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
# Test data set - labels
y_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
# Test data set - subject labels
subject_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

##Step 1: Training dataset prep
#Creating a list of columns that are the mean and sd to select in the analysis
col_include <- as.list(sqldf("SELECT V1
                                FROM features
                                WHERE
                                (CASE WHEN V2 LIKE '%mean()%' THEN 'Y'
                                WHEN V2 LIKE '%std()%' THEN 'Y'
                                ELSE 'N' END) = 'Y'"
))

#Naming columns in X_trian with the features
namesvec <- as.vector(features[,2])
colnames(X_train) <- namesvec
#Version of X_train that includes only the mean and sd columns
X_train.mod <- X_train[,col_include[[1]]]
#Appending subject_train and y_train and adding descriptive column names
y_train_lab <- sqldf("SELECT act.V2
                      FROM y_train orig
                      INNER JOIN activity_labels act
                      ON orig.V1 = act.V1
                    ")
X_train.fin <- cbind(subject_train[,1], y_train_lab[,1],X_train.mod[,])
colnames(X_train.fin)[1:2] <- c("ParticipantID", "Activity")

##Step 2: Test dataset prep

#Naming columns in X_trian with the proper names in features
namesvec <- as.vector(features[,2])
colnames(X_test) <- namesvec
#Version of X_test that includes only the mean and sd columns
X_test.mod <- X_test[,col_include[[1]]]

#Appending subject_test and y_test and adding descriptive column names
y_test_lab <- sqldf("SELECT act.V2
                      FROM y_test orig
                      INNER JOIN activity_labels act
                      ON orig.V1 = act.V1
                    ")
X_test.fin <- cbind(subject_test[,1], y_test_lab[,1],X_test.mod[,])
colnames(X_test.fin)[1:2] <- c("ParticipantID", "Activity")

##Step 3: Merging the training and data sets to one dataset
findat <- rbind(X_test.fin[,],X_train.fin[,])

##Step 4: Create a dataset that has the average of each variable for each activity and subject
#Creating average by participantID and activity using the aggregate function
tidydat <- aggregate(. ~ findat$ParticipantID + findat$Activity, findat[3:68], FUN = mean)  
#Adding descriptive names for final dataset
colnames(tidydat)[1:2] <- c("ParticipantID", "Activity")
#ordering dataset to be by participant
tidydat.sort <- tidydat[order(tidydat$ParticipantID),]

##Step 5: Exporting tidydat.sort for submission
write.table(tidydat.sort, file = "tidydat.txt", sep = ",", row.names = FALSE)
#Saving a CSV for screenshot purposes
write.csv(tidydat.sort, file = "tidydat.csv", row.names = "FALSE")
