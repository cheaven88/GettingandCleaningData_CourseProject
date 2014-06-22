# Codebook for Getting and Cleaning Data: Course Project

## Data Description
The tidy dataset that has been submitted with this assignment has been generated from the Human Activity Recognition Using Smartphones Dataset, created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto from the Non-Linear Complex Systems Laboratory at the Università degli Studi di Genova in Genoa, Italy.

The purpose of this study was to collect movement data using a smartphone from 30 volunteer participants while they preformed the following six everyday activities
* Walking
* Walking Upstairs
* Sitting
* Standing
* Laying

The dataset that has been submitted is the average of each mean and standard deviation variables described in the Variable Description section by participant and activity. 
  
## Variable Description

### Variable List Key

* t prefix: Time
* f prefex: Frequency
* mean(): Mean measure
* std(): Standard deviation measure
* -X: X Direction
* -Y: Y Direction
* -Z: Z Direction
* BodyAcc: Body Acceleration
* GravityAcc: Gravity Acceleartion
* BodyAccJerk: Body Acceleration - Jerks
* GravityAcc: Gravity Acceleration - Jerks
* BodyGyro: Body Gyroscope Measurement
* BodyGyroJerk: Body Gyroscope Measurement - Jerks
* BodyAccMag: Body Acceleration Magnitude
* GravityAccMag: Gravity Acceleartion Magnitude
* BodyAccJerkMag: Body Acceleration Magnitude - Jerks
* BodyGyroMag: Body Gyroscope
* BodyGyroJerkMag: Body Gyroscope Magnitude - Jerks

### Variable List

* ParticipantID: ID representing the participant
* Activity: Daily activity being preformed
* tBodyAcc-mean()-X 
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyAccJerk-std()-X
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-mean()
* tBodyAccMag-std()
* tGravityAccMag-mean()
* tGravityAccMag-std()
* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyAccMag-mean()
* fBodyAccMag-std()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()
 
##Data Transformations

The following transformations were conducted to support this analysis:
1. A list named *col_include* was created with the number of the variables that were relevant for the variables that measured mean and standard deviation - which were the only variables relevant for this analysis. 

2. The vector *names_vec* was created the store the feature (i.e. variable) names from the *features* tabel from the original data. *names_vec* was applied to *X_train* (the training dataset) to give the variables a descriptive name

3. A dataframe *X_train.mod* was created as a subset of *X_train* using only the columns included in *col_include*

4. A vector *y_train_lab* was created to apply the descriptive activity names from *activity_labels* to the activity number provided in *y_train*

5. The dataframe *X_train.fin* was created with an aggregate of *subject_train*, *y_train_lab*, and *X_train.mod*. Thus, *X_train.fin* includes the participant id, the activity, and all of the mean and standard deviation values from the original dataset.

6. *X_test.fin* dataset was created using steps 2-5

7. *X_test.fin* and *X_training.fin* were aggregated into a dataset named *findat*

8. An aggregate function was performed on *findat* which aggregated the mean of all of the variables by participant id and activity into a dataset named *tidydat*.

9. *tidydat_sort* was created by sorting *tidydat* by participantID to have a truly tidy dataset by participant ID.

10. *tidydat_sort* was the dataset exported for submission.

