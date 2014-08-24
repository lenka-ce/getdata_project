getdata_project
===============

The project contains of these files:

* README.md
* run_analysis.R
* Galaxy.txt
* averages.txt
* CodeBook.md


The code in the file run_analysis.R downloads, cleans, reshapes and stores the data as required in the assignment. It performs the following steps:

    -   Downloading and unzipping the data
    - Reading the test and train files. Assigning feature names to column names for both test and training set. Linking data to activity and subject variables, both for test and training set
    - Creating a new dataframe with the observations from both the test and train datasets, as required in step 1 (they are stored in a temporary dataframe for now and will be assigned 
    - Creating a new dataframe Galaxy with only the required variables and with descriptive variable names, as required in step 2 and 3 and 4
    - Storing Galaxy as Galaxy.txt. This is the first tidy dataset required.
    - Loading library for melting and casting the dataset
    - Creating a file with the means of the measurements for each combination of subject and activity. 
    - Storing averages as averages.txt. This is the second tidy dataset required in step 5 which is also the one that will be uploaded.

Galaxy.txt contains first tidy data set as described through steps 1-4.

The averages.txt file contains the second, independent tidy data set with the average of each variable for each activity and each subject

The file CodeBook.md contains a description of the variables in the dataset averages.txt
