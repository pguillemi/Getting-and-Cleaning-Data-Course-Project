#load packages

library(tidyverse)

rm(list = ls())

#download file to working directory and unzip
if(!file.exists("UCI_HAR_dataset.zip")) {
  download.file(
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
  destfile = "UCI_HAR_dataset.zip",
  method = "curl")}

unzip("UCI_HAR_dataset.zip")


# STEP 1 - Merges the training and the test sets to create one data set.
# STEP 3 - Uses descriptive activity names to name the activities in the data set
# STEP 4 - Appropriately labels the data set with descriptive variable names. 

#load files for labels and activity names
file_list <- as_tibble(list.files("./UCI HAR Dataset", recursive = TRUE))

column_names <- read_table(file.path("UCI HAR Dataset", file_list$value[2]), 
                       col_names = FALSE)

activity_labels <- read_table(file.path("UCI HAR Dataset", file_list$value[1]), 
                              col_names = FALSE)


#test dataset - load files
subject_test <- read_table(file.path("UCI HAR Dataset", file_list$value[14]), 
                      col_names = FALSE)

values_test <- read_table(file.path("UCI HAR Dataset", file_list$value[15]), 
                               col_names = FALSE)

activity_test <- read_table(file.path("UCI HAR Dataset", file_list$value[16]), 
                     col_names = FALSE)

#test dataset - renaming and joining columns
subject_test <- subject_test %>% 
  rename(
    subject_id = X1
  )

names(values_test) <- column_names$X2


activity_test <- left_join(activity_test, activity_labels)

activity_test <- activity_test %>% 
  rename(
    activity_code = X1,
    activity_text = X2
  )

#final test dataset
test_dataset <- cbind(subject_test, values_test, activity_test)


#training dataset - load files
subject_training <- read_table(file.path("UCI HAR Dataset", file_list$value[26]), 
                           col_names = FALSE)

values_training <- read_table(file.path("UCI HAR Dataset", file_list$value[27]), 
                          col_names = FALSE)

activity_training <- read_table(file.path("UCI HAR Dataset", file_list$value[28]), 
                            col_names = FALSE)

#training dataset - renaming and joining columns
subject_training <- subject_training %>% 
  rename(
    subject_id = X1
  )

names(values_training) <- column_names$X2


activity_training <- left_join(activity_training, activity_labels)

activity_training <- activity_training %>% 
  rename(
    activity_code = X1,
    activity_text = X2
  )

#final training dataset
training_dataset <- cbind(subject_training, values_training, activity_training)

#merged dataset
dataset <- rbind(test_dataset, training_dataset)

#clean environment
environment <- ls()

environment <- environment[-5]

rm(list = environment)


# STEP 2 (includes STEP 4) - Extracts only the measurements on the mean and standard 
# deviation for each measurement. 

dataset_mean_std <- dataset %>% 
  select(subject_id|activity_text|contains("mean()")|contains("std()"))

names(dataset_mean_std)


# STEP 5 - From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

#create id and activity subset
dataset_by_activity_subject <- dataset_mean_std %>% 
  group_by(subject_id, activity_text) %>% 
  summarise()
  
#create and name values columns to make clear it is the average
data_columns <- dataset_mean_std %>% 
  select(-1,-2)

data_columns <- data_columns[0,]

names(data_columns) <- str_c("avg", names(data_columns), sep = "_")


#loop across subjects and activities to get the colmeans

data_new <- data_columns[0,]

for(i in 1:nrow(dataset_by_activity_subject)) {
    
    data_subset <- dataset_mean_std %>%
      filter(subject_id == dataset_by_activity_subject$subject_id[i]) %>% 
      filter(activity_text == dataset_by_activity_subject$activity_text[i]) 
    
    data_subset_values <- data_subset %>% 
      select(-1, -2)
    
    data_columns[1,] <- colMeans(data_subset_values)

    data_new <- rbind(data_new, data_columns)
    
}

#bind ids and activities to values

dataset_by_activity_subject <- cbind(dataset_by_activity_subject, data_new)


#clean environment
environment <- ls()

environment <- environment[-c(5,6,7)]

rm(list = environment)

#save output file
if(!file.exists("output")) {dir.create("output")}

dataset_by_activity_subject %>% 
  write.table("./output/tidy_dataset_by_activity_subject.txt",
              row.name=FALSE)
