### Course project on getting and cleaning data.

#### Files

run_analysis.R - script that run all the analys process, as long as the [Samsung data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is in your working directory. If it's not, it will download it and unpack. Resulting tidy data set is placed at results.txt file. You can load it with the following snippet:

```
data <- read.table('results.txt', header = TRUE)
View(data)
```
