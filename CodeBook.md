---
output: html_document
---
#Study Design

**Abstract** Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

**Authors** _Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto_. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - Universit√  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition '@' smartlab.ws 
www.smartlab.ws 

## Data collection information as provided by the authors:

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

## Raw Data Source
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Data Set Characteristics:    Multivariate, Time-Series
* Number of Instances:		10299
* Number of Attributes:		561	
* Missing Values?			N/A

##Raw Data organization
   
**The downloaded data was unzipped into a project sub-folder called data**. The data folder had the following files:  
1. **activity_labels.txt** : Contains the activity labels for the 6 daily living activities. Used to create the descriptive activity names.    
2. **features.txt** : Contains the text representation of the 561 features. Used to create descriptive feature names.    
3. **feature_info.txt** : Describes how the feature columns were derived from the basic sensor measurements - Triaxial acceleration from the accelerometer,  estimated body acceleration  , Triaxial Angular velocity from the gyroscope. Not used during processing.    
  
There were two sub-folders one for test and the other for training. Both **test** and **train** sub-folders had a similar organization. The test folder is described below:

1. **subject_test.txt** : Contains a single column of numeric subject identifiers.  
2. **X_test.txt** : Contains numeric observations of the 561 features for a particular subject and activity. The subject and activity information are obtained from subject_test.txt and y_test.txt. The line number in each file provided the linkage. All three files have the identical line count.     
3. **y_test.txt** :  Contains a single column of daily living activity identifiers.

All the three files in the test and train folders are read in and combined into the following layout (data frame for further processing):  

  subjId      | actDesc  | Feature1 Feature2...Feature 561  
  ------------| ---------|--------------------------------  
  Line 1 subject_test.txt | Line 1 y_test.txt | Line 1 X_test.txt (561 space separated values)  
  Line 2 subject_test.txt | Line 2 y_test.txt |	Line 2 X_test.txt (561 space separated values)  
  Line .. subject_test.txt| Line .. y_test.txt |Line .. X_test.txt (561 space separated values)  
  Line n subject_test.txt | Line n y_test.txt |	Line n X_test.txt (561 space separated values)  
  Line 1 subject_train.txt | Line 1 y_train.txt | Line 1 X_train.txt (561 space separated values)  
  Line 2 subject_train.txt | Line 2 y_train.txt |  Line 2 X_train.txt (561 space separated values)  
  Line .. subject_train.txt| Line .. y_train.txt |Line .. X_train.txt (561 space separated values)  
  Line m subject_train.txt | Line n y_train.txt |	Line m X_train.txt (561 space separated values)

Each of these variables is described in the CodeBook section of the document.	

#CodeBook for dla_msrmt.txt

Variable names are in ***bolditalic***.

***subjID***

Source: subject_test.txt or subject_train.txt

Description: Subject whose data is being collected.

Data type :  numeric

Units : N/A

Range : 1-30

Labels : None

***actDesc***

Source: y_test.txt or y_train.txt

Description: A value that identifies one of the 6 ADLs.

Data type :  factor/categorical

Units : N/A

Range/Levels :

Labels : 
1 WALKING

2 WALKING_UPSTAIRS

3 WALKING_DOWNSTAIRS

4 SITTING

5 STANDING

6 LAYING

 


**Feature variables**

The project requirement is to "preserve the time and frequency domain variables that are measurements on the mean and standard deviation for each measurement".Features that had a -mean or -std in their name were retained.  All feature names in feature.txt were mapped to legal R variable names. To preserve traceability the feature name and the legal names are provided in the table below.

All the feature variables have the following generic description block.

***See the table below for the feature variable names***

Source: X_test.txt or X_train.txt

Description: The **mean** of the feature values for a given subject, and ADL combination.

Data type :  numeric

Units : Acceleration units are in **g**  
        Angular velocity units are in **radians/sec**

Range : Normalized to -1 to 1

Labels : Specified in feature.txt in sorted order.

      
      **Table: Feature variable names (R Dataset Name column)**

    Raw Feature Name           | R Dataset Name       | Data Type | Units  
    ---------------------------|----------------------|-----------|-------  
    tBodyAcc-mean()-X          | tBodyAcc.mean.X      | numeric   | g  
    tBodyAcc-mean()-Y          | tBodyAcc.mean.Y      | numeric   | g  
    tBodyAcc-mean()-Z          | tBodyAcc.mean.Z      | numeric   | g  
    tBodyAcc-std()-X           | tBodyAcc.std.X       | numeric   | g  
    tBodyAcc-std()-Y           | tBodyAcc.std.Y       | numeric   | g  
    tBodyAcc-std()-Z           | tBodyAcc.std.Z       | numeric   | g  
    tGravityAcc-mean()-X       | tGravityAcc.mean.X   | numeric   | g  
    tGravityAcc-mean()-Y       | tGravityAcc.mean.Y   | numeric   | g  
    tGravityAcc-mean()-Z       | tGravityAcc.mean.Z   | numeric   | g  
    tGravityAcc-std()-X        | tGravityAcc.std.X    | numeric   | g  
    tGravityAcc-std()-Y        | tGravityAcc.std.Y    | numeric   | g  
    tGravityAcc-std()-Z        | tGravityAcc.std.Z    | numeric   | g  
    tBodyAccJerk-mean()-X      | tBodyAccJerk.mean.X  | numeric   | g  
    tBodyAccJerk-mean()-Y      | tBodyAccJerk.mean.Y  | numeric   |	g  
    tBodyAccJerk-mean()-Z      | tBodyAccJerk.mean.Z  | numeric   |	g  
    tBodyAccJerk-std()-X       | tBodyAccJerk.std.X   | numeric   |	g  
    tBodyAccJerk-std()-Y       | tBodyAccJerk.std.Y   | numeric   |	g  
    tBodyAccJerk-std()-Z       | tBodyAccJerk.std.Z   |	numeric   |	g  
    tBodyGyro-mean()-X         | tBodyGyro.mean.X     | numeric   | radians/sec  
    tBodyGyro-mean()-Y         | tBodyGyro.mean.Y     | numeric   |	radians/sec
    tBodyGyro-mean()-Z         | tBodyGyro.mean.Z     | numeric   | radians/sec  
    tBodyGyro-std()-X          | tBodyGyro.std.X      | numeric   |	radians/sec  
    tBodyGyro-std()-Y          | tBodyGyro.std.Y      | numeric   |	radians/sec  
    tBodyGyro-std()-Z          | tBodyGyro.std.Z      | numeric   | radians/sec  
    tBodyGyroJerk-mean()-X     | tBodyGyroJerk.std.X  | numeric   |	radians/sec  
    tBodyGyroJerk-mean()-Y     | tBodyGyroJerk.std.Y  | numeric   | radians/sec  
    tBodyGyroJerk-mean()-Z     | tBodyGyroJerk.std.Z  | numeric   | radians/sec  
    tBodyGyroJerk-std()-X      | tBodyAccMag.mean.    | numeric   | g  
    tBodyGyroJerk-std()-Y      | tBodyAccMag.std.     | numeric   |	g  
    tBodyGyroJerk-std()-Z      | tGravityAccMag.mean  | numeric   |	g  
    tBodyAccMag-mean()         | tBodyAccMag.mean.    | numeric   | g  
    tBodyAccMag-std()          | tBodyAccMag.std.     | numeric   |	g  
    tGravityAccMag-mean()      | tGravityAccMag.mean  | numeric   | g  
    tGravityAccMag-std()       | tGravityAccMag.std.  | numeric   |	g  
    tBodyAccJerkMag-mean()     | tBodyAccJerkMag.mean | numeric   |	g  
    tBodyAccJerkMag-std()      | tBodyAccJerkMag.std. | numeric   |	g  
    tBodyGyroMag-mean()        | tBodyGyroMag.mean.   | numeric   |	radians/sec  
    tBodyGyroMag-std()         | tBodyGyroMag.std.    | numeric   |	radians/sec  
    tBodyGyroJerkMag-mean()    | tBodyGyroJerkMag.mean| numeric   |	radians/sec  
    tBodyGyroJerkMag-std()     | tBodyGyroJerkMag.std.| numeric	  | radians/sec  
    fBodyAcc-mean()-X          | fBodyAcc.mean.X      |	numeric   |	g  
    fBodyAcc-mean()-Y          | fBodyAcc.mean.Y      |	numeric   |	g  
    fBodyAcc-mean()-Z          | fBodyAcc.mean.Z      | numeric   |	g  
    fBodyAcc-std()-X           | fBodyAcc.std.X       |	numeric   |	g  
    fBodyAcc-std()-Y           | fBodyAcc.std.Y       | numeric   | g  
    fBodyAcc-std()-Z           | fBodyAcc.std.Z       |	numeric   | g  
    fBodyAcc-meanFreq()-X      | fBodyAcc.meanFreq.X  |	numeric   |	g  
    fBodyAcc-meanFreq()-Y      | fBodyAcc.meanFreq.Y  |	numeric   |	g  
    fBodyAcc-meanFreq()-Z      | fBodyAcc.meanFreq.Z  |	numeric   |	g  
    fBodyAccJerk-mean()-X      | fBodyAccJerk.mean.X  |	numeric   |	g  
    fBodyAccJerk-mean()-Y      | fBodyAccJerk.mean.Y  |	numeric   |	g  
    fBodyAccJerk-mean()-Z      | fBodyAccJerk.mean.Z  | numeric   |	g  
    fBodyAccJerk-std()-X       | fBodyAccJerk.std.X   | numeric   |	g  
    fBodyAccJerk-std()-Y       | fBodyAccJerk.std.Y   | numeric   |	g  
    fBodyAccJerk-std()-Z       | fBodyAccJerk.std.Z   | numeric   |	g  
    fBodyAccJerk-meanFreq()-X  | fBodyAccJerk.meanFreq.X|numeric  |	g  
    fBodyAccJerk-meanFreq()-Y  | fBodyAccJerk.meanFreq.Y|numeric  | g  
    fBodyAccJerk-meanFreq()-Z  | fBodyAccJerk.meanFreq.Z|numeric  |	g  
    fBodyGyro-mean()-X         | fBodyGyro.mean.X     |numeric    |	radians/sec  
    fBodyGyro-mean()-Y         | fBodyGyro.mean.Y     | numeric   | radians/sec  
    fBodyGyro-mean()-Z         | fBodyGyro.mean.Z     | numeric   |	radians/sec  
    fBodyGyro-std()-X          | fBodyGyro.std.X      |	numeric   | radians/sec  
    fBodyGyro-std()-Y          | fBodyGyro.std.Y      |	numeric   |	radians/sec  
    fBodyGyro-std()-Z          | fBodyGyro.std.Z      | numeric   | radians/sec  
    fBodyGyro-meanFreq()-X     | fBodyGyro.meanFreq.X | numeric   | radians/sec  
    fBodyGyro-meanFreq()-Y     | fBodyGyro.meanFreq.Y | numeric   | radians/sec  
    fBodyGyro-meanFreq()-Z     | fBodyGyro.meanFreq.Z | numeric   | radians/sec  
    fBodyAccMag-mean()         | fBodyAccMag.mean.    | numeric   | g  
    fBodyAccMag-std()          | fBodyAccMag.std.     | numeric   |	g  
    fBodyAccMag-meanFreq()     | fBodyAccMag.meanFreq.| numeric   |	g  
    fBodyBodyAccJerkMag-mean() | fBodyAccJerkMag.mean.|numeric    | g  
    fBodyBodyAccJerkMag-std()  | fBodyAccJerkMag.std. |numeric    |	g  
    fBodyBodyAccJerkMag-meanFreq()|fBodyAccJerkMag.meanFreq.|numeric|g  
    fBodyBodyGyroMag-mean()    | fBodyGyroMag.mean.   | numeric   |	radians/sec  
    fBodyBodyGyroMag-std()     | fBodyGyroMag.std.    |	numeric   |	radians/sec  
    fBodyBodyGyroMag-meanFreq()|fBodyGyroMag.meanFreq.|numeric    | radians/sec  
    fBodyBodyGyroJerkMag-mean()|fBodyGyroJerkMag.mean.|numeric    |	radians/sec  
    fBodyBodyGyroJerkMag-std() |fBodyGyroJerkMag.std. |numeric    |	radians/sec  
    fBodyBodyGyroJerkMag-meanFreq()|fBodyGyroJerkMag.meanFreq.|numeric|	radians/sec




