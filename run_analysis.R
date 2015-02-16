## Uses library("data.table")
library("data.table")
##
# Dimensions of key vectors and matrices in top level directory
# Files in top level directory needed for test and train
# $ wc -l activity_labels.txt    : 6 activity_labels.txt
# $ wc -l features.txt           : 561 features.txt
#
# Dimensions of key vectors and matrices in top level directory in data/test sub-directory
# Files : subject_test.txt : subjId variable values (integer)
#         y_test.txt : actDesc variable values (integer)
#         X_test.txt : measurement variables values from  (numeric)
# $ wc -l subject_test.txt       : 2947 subject_test.txt
# $ wc -l y_test.txt             : 2947 y_test.txt
# $ wc -l X_test.txt             : 2947 X_test.txt
#
###############################################################################
#   STEP 1
###############################################################################
stst <- read.table("data\\test\\subject_test.txt", sep = "")
atst <- read.table("data\\test\\y_test.txt", sep = "")
xtst <- read.table("data\\test\\X_test.txt", sep = "")

## check that the number of rows read in from each test file is the same
read_chk1 <- (dim(xtst)[1]==dim(atst)[1])&& (dim(xtst)[1]==dim(stst)[1])  
testDF <- data.frame(cbind(stst, atst, xtst))
na_chk2 <- all(colSums(is.na(testDF))==0)

##  Dimensions of key vectors and matrices in top level directory in data/train sub-directory
# $ wc -l subject_train.txt       : 7352 subject_train.txt
# $ wc -l y_train.txt             : 7352 y_train.txt
# $ wc -l X_train.txt             : 7352 X_train.txt
#
strn <- read.table("data\\train\\subject_train.txt", sep = "")
atrn <- read.table("data\\train\\y_train.txt", sep = "")
xtrn <- read.table("data\\train\\X_train.txt", sep = "")

## Check that the number of rows read in from each training file is the same
read_chk3 <- (dim(xtrn)[1]==dim(atrn)[1])&& (dim(xtrn)[1]==dim(strn)[1])
trnDF <- data.frame(cbind(strn, atrn, xtrn))
na_chk4 <- all(colSums(is.na(trnDF))==0)

## Combine test and training dataframes into one data frame
prjDF <- rbind(testDF,trnDF)

## Check that there is data from all 30 subjects.subjId is the first column
read_chk5 <- dim(unique(prjDF[1]))[1]==30

### END STEP 1 ################################################################

###############################################################################
#   STEP 2
###############################################################################
## Extract only the mean and standard deviation of each measurement 
#Read the measurement labels from features.txt

ftnam <- read.table("data\\features.txt", sep = "", stringsAsFactors = FALSE)
nam <- c("subjId", "actDesc",ftnam$V2)
read_chk6 <- length(nam)==563  ## subject, activity, followed by 561 features

## Keep the columns of interest as specified in the selColumns variable 
## Select the subjid, actDesc and measurement columns with mean and std measurements into a logical vector 
selColumns <- nam %in% c("subjId") | nam %in% c("actDesc") | nam %like% c("-std") | nam %like% c("-mean")
xDF <- prjDF[,selColumns]

## Check the expected size of the xDF dataframe after feature columns have been dropped
## 2947 is rows of test data, 7352 rows of training data
## columns are subjId (col1), actDesc(col2), 79 columns that matched "-mean" or "-std"
read_chk7 <- identical(c(2947+7352,1+1+79), as.numeric(dim(xDF))) 

### END STEP 2 ################################################################

###############################################################################
#   STEP 3
###############################################################################
## Convert all the labels into syntactically correct variable names for R
tmpnam <- make.names(nam)
for (i in 1:length(tmpnam)) {
  # Pretty the names, replace three dots(...) with one dot(.) 
  tmpnam[i] <-   sub("\\.\\.\\.*",".",tmpnam[i])
  
  ## Removed duplicate Body text e.g. fBodyBodyGyroMag-mean()
  tmpnam[i] <-   sub("BodyBody","Body",tmpnam[i])
}

## Keep the columns of interest
colnames(xDF) <- tmpnam[selColumns]

### END STEP 3 ################################################################


###############################################################################
#   STEP 4
###############################################################################
## Update the activity number with the label from activity_labels.txt
## Activities are the second column in prjDF
actlbl <- read.table("data\\activity_labels.txt", sep = "", stringsAsFactors = FALSE)
## The following code makes use of the fact that the activity table is ordered 1-6
## and this is the same as the default levels in the factor call.
xDF$actDesc <- factor(xDF$actDesc, labels = actlbl$V2)
read_chk8 <- length(levels(xDF$actDesc)) == 6

### END STEP 4 ################################################################

###############################################################################
#   STEP 5
###############################################################################
## Create a data table from xDF so that keys can be used for subsetting
xDT <- data.table(xDF)
setkey(xDT,subjId, actDesc)
## Compute the means for all the features subsetted by subject and activity
ans <- xDT[,lapply(.SD, mean), by=key(xDT)]
write.table(ans,file="dla_msrmt.txt", row.names=FALSE)

### END STEP 5 ################################################################



