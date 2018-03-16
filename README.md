# Getting_and_cleaning_data_asses_4
Getting and cleaning data assesment 4 folder

This file describes how run_analysis.R script works.

- First: make sure that your current directory does not have already the databases' folder unzipped, otherwise the first step will just print that the folder already exists
- Second: make sure that run_analysis.R script is in the current working directory.
- Third: use source("run_analysis.R") command in RStudio.
- Fourth: you will find two output files are generated in the current working directory:  
        merged_data.txt: it contains a data frame called "cleanedData".  
        data_with_means.txt: it contains a data frame called "result".  
- And Fifth: use the command - data <- read.table("data_with_means.txt") - in RStudio to read the file.  Or you can just open the text file in your current R folder.

Cheers,  
Jo
