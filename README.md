This file provides the following information for creating the dla_msrmt.txt data set - Trial Branch file:

**a) Steps used to build the dataset.**

1. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Create a project folder called **gcd** (can be any name of your choice). Extract the zip  from step 1 into a folder called **data** inside the **gcd** folder. You should see the following files and folders in **gcd/data**:  
Files: **activity_labels.txt**   **features.txt**    **feature_info.txt**  
Folders: **test**  and **train**. The folders **test** and **train** should each have three text files in them.  

3. Copy the file run_analysis.R into the **gcd** folder. After this step the **gcd** folder will have the following structure:  
Files : **run_analysis.R**  
Folder : **data**

4. Complete the steps in the Usage section.


**b) Usage: run_analysis.R.**

1. Open an R command line prompt or R studio.
2. Set the working directory to the **gcd** folder using setwd.
3. source("run_analysis.R")
4. This will create dla_msrmt.txt. It contains the average of all the measured variables grouped by the thirty subjectids and six daily living activities.
5. Read the created file using x <- read.table("dla_msrmt.txt", header=TRUE, sep = "")

**c) Analysis script in pseudocode form**

Step 1.  *Create a single data frame prjDF from test and train folders.*

* Read and combine files from the test directory into a data frame testDF.
* Read and combine files from the train directory into a data frame trnDF.
* Combine testDF and trnDF into one data frame called prjDF. 

Each observation(row) represents an entry with a subjID, actDesc (activity decriptor), followed by the 561 feature variables available in feature.txt.

Step 2.  *Extract the columns of interest from prjDF into xDF*

* Create a character vector with the subjID and actDesc columns followed by the 561 feature names specified in feature.txt.The 561 features correspond to the 561 data columns in the X_train.txt and X_test.txt files.
* Extract the columns in the vector corresponding to the subjId, actDesc, mean and standard deviation of each measurement, using string matching on the names provided in feature.txt.Variables that had a *"-mean"* or a "-std"* string as part of their name were retained. All other variables were dropped.**Seventy nine of the 561 variables were retained.**
* Subset the columns of prjDF into a data frame called **xDF**.

Step 3.  *Create legal R names for xDF columns*

* Replace characters like "(", ")" etc into periods. 
* Clean the feature names to replace multiple periods with one and duplicate strings like Body with one.
* Set the column names for the xDF data frame.

Step 4.  *Update the actDesc column in xDF with the labels from activity_labels.txt*

* The numbers representing the activities are replaced with strings describing these activities. This is done by converting the actDesc column in the xDF data frame into a R factor and using the second column from activity_labels.txt as factor labels.

Step 5. *Group entries in xDF using the subjID and actDesc columns and summarize the feature variables using mean. Write the results into the dla_msrmt.txt data set.*

* Convert xDF into a data table xDT
* Group xDT using the subjID and actDesc fields.
* Compute the mean for the feature columns in each group.
* Write the results to "dla_msrmt.txt". This is a 180x81 dataset.


**d) CodeBook information for dla_msrmt.txt**

The file CodeBook.md contains the following sections:

* Study Design
* Raw Data Organization
* CodeBook with the variable descriptions.

