The input data set was taken from the following source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

See 'features_info.txt' file for definition and description of the input sensor variables.

The run_analysis.R script was applied to tidy up the data and update the sensor variables to be more descriptive. The output tidydataset  from run_analysis.R contains 88 variables, the first two variable catpure the activities performed and the subject id respectively. The remaining 86 variables capture the averages of the data collected by sensors on a Samsung Galaxy S3 phone attached to the hip of test subjects. See the 'oldnew.csv' file for transformation of the variables from the original to the new more descriptive variable names.
