# CodeBook

This is the code book that describes the variables, the data, and any transformations or work that were performed to clean up the data.

The final summary tidy data set "tidy_dataset_by_activity_subject.txt" contains the average of each variable for each activity and each subject from the Human Activity Recognition Using Smartphones Data Set

## Description
Data in data set contains 180 rows and 68 columns 

The description and variable names from the original data are available in the repo, this chunk of code will download the repo and bring up its readme file
  

```{r}
if(!file.exists("UCI_HAR_dataset.zip")) {
  download.file(
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
  destfile = "UCI_HAR_dataset.zip",
  method = "curl")}

unzip("UCI_HAR_dataset.zip")

file_list <- as_tibble(list.files("./UCI HAR Dataset", recursive = TRUE))

readLines(file.path("./UCI HAR Dataset",file_list$value[4]))

activity_labels <- read_table(file.path("UCI HAR Dataset", file_list$value[1]), 
                              col_names = FALSE)
```


Throughout the analysis, besides binding the files contaning values with its corresponding column names, I basically created three variable names:

*subject_id*: number of the corresponding subject in the "subject_test.txt"" and "subject_train.txt" files, it goes from 1 to 30

*activity_code*: number of the corresponding activity, as stated in the respository file named
"activity labels.txt"

*activity_text*: the text for the corresponding activity as stated in the repository file named
"activity labels.txt"

Even though they are in different data sets, it is worth noting that I added to every value column name in the tidy table with averages of the means and std the prefix "avg_" so as to avoid
any confusion.

Variable names are:

 [1] "subject_id"                     
 [2] "activity_text"                  
 [3] "avg_tBodyAcc-mean()-X"          
 [4] "avg_tBodyAcc-mean()-Y"          
 [5] "avg_tBodyAcc-mean()-Z"          
 [6] "avg_tGravityAcc-mean()-X"       
 [7] "avg_tGravityAcc-mean()-Y"       
 [8] "avg_tGravityAcc-mean()-Z"       
 [9] "avg_tBodyAccJerk-mean()-X"      
[10] "avg_tBodyAccJerk-mean()-Y"      
[11] "avg_tBodyAccJerk-mean()-Z"      
[12] "avg_tBodyGyro-mean()-X"         
[13] "avg_tBodyGyro-mean()-Y"         
[14] "avg_tBodyGyro-mean()-Z"         
[15] "avg_tBodyGyroJerk-mean()-X"     
[16] "avg_tBodyGyroJerk-mean()-Y"     
[17] "avg_tBodyGyroJerk-mean()-Z"     
[18] "avg_tBodyAccMag-mean()"         
[19] "avg_tGravityAccMag-mean()"      
[20] "avg_tBodyAccJerkMag-mean()"     
[21] "avg_tBodyGyroMag-mean()"        
[22] "avg_tBodyGyroJerkMag-mean()"    
[23] "avg_fBodyAcc-mean()-X"          
[24] "avg_fBodyAcc-mean()-Y"          
[25] "avg_fBodyAcc-mean()-Z"          
[26] "avg_fBodyAccJerk-mean()-X"      
[27] "avg_fBodyAccJerk-mean()-Y"      
[28] "avg_fBodyAccJerk-mean()-Z"      
[29] "avg_fBodyGyro-mean()-X"         
[30] "avg_fBodyGyro-mean()-Y"         
[31] "avg_fBodyGyro-mean()-Z"         
[32] "avg_fBodyAccMag-mean()"         
[33] "avg_fBodyBodyAccJerkMag-mean()" 
[34] "avg_fBodyBodyGyroMag-mean()"    
[35] "avg_fBodyBodyGyroJerkMag-mean()"
[36] "avg_tBodyAcc-std()-X"           
[37] "avg_tBodyAcc-std()-Y"           
[38] "avg_tBodyAcc-std()-Z"           
[39] "avg_tGravityAcc-std()-X"        
[40] "avg_tGravityAcc-std()-Y"        
[41] "avg_tGravityAcc-std()-Z"        
[42] "avg_tBodyAccJerk-std()-X"       
[43] "avg_tBodyAccJerk-std()-Y"       
[44] "avg_tBodyAccJerk-std()-Z"       
[45] "avg_tBodyGyro-std()-X"          
[46] "avg_tBodyGyro-std()-Y"          
[47] "avg_tBodyGyro-std()-Z"          
[48] "avg_tBodyGyroJerk-std()-X"      
[49] "avg_tBodyGyroJerk-std()-Y"      
[50] "avg_tBodyGyroJerk-std()-Z"      
[51] "avg_tBodyAccMag-std()"          
[52] "avg_tGravityAccMag-std()"       
[53] "avg_tBodyAccJerkMag-std()"      
[54] "avg_tBodyGyroMag-std()"         
[55] "avg_tBodyGyroJerkMag-std()"     
[56] "avg_fBodyAcc-std()-X"           
[57] "avg_fBodyAcc-std()-Y"           
[58] "avg_fBodyAcc-std()-Z"           
[59] "avg_fBodyAccJerk-std()-X"       
[60] "avg_fBodyAccJerk-std()-Y"       
[61] "avg_fBodyAccJerk-std()-Z"       
[62] "avg_fBodyGyro-std()-X"          
[63] "avg_fBodyGyro-std()-Y"          
[64] "avg_fBodyGyro-std()-Z"          
[65] "avg_fBodyAccMag-std()"          
[66] "avg_fBodyBodyAccJerkMag-std()"  
[67] "avg_fBodyBodyGyroMag-std()"     
[68] "avg_fBodyBodyGyroJerkMag-std()" 
