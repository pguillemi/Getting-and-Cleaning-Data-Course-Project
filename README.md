# Getting-and-Cleaning-Data-Course-Project

## Comments on the script

The script itself has several comments so as depict what each step does, so here I will comment on the structure and logic of the steps taken

The first part is loading the required packages, being the "tidyverse" a convenient wrapper for several of them.

Afterwards I clean the environment, and then I download the dataset and unzip it in my local working directory

Then I create a file directory, from which I load the required files. I read the documentation provided with the database to know which files to call. That process is basically done twice with the training a test datasets (it could have been written as a function too, but I kept it straightforward), it this step I assigned descriptive names to all the variables

I then joined the databases, to get a unique dataset

## About means and std
In orden to get the means and std dataset, I made the decision to match the following strings "mean()" and "std()" as they were the most unambigous. There were a few others variables that included the word "mean", but that seemed more related to a name more than to a real mean.

## Tidy dataset
In order to get the tidy dataset with the averages of the means and std, I opted for a loop, which used the ColMeans function on a subset of the data.

The resulting dataset can be considered as tidy given the following:

It is a table of averages, so the averages are the only type of variable in there
Each row is the unique average of the values for a given subject in a given activity
Each column corresponds to the average of one variable, either mean or std.



