# CodeBook

This is the code book that describes the variables, the data, and any transformations or work that were performed to clean up the data.

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