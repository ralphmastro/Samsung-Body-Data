# Samsung-Body-Data

## This directory processes the samsung body monitioring data and completes the assignment.  This repositiory contains:
- run_analysis.R: the R code that processes the samsung data.
- codebook.md: a markdown file containing the codebook for the final "tidy" dataset.
- tidydata.txt: the final dataset for the programming assignment.
 
 
## The analysis file works in the following way:
- First, the file will import the relevant data files.
- Second, I extract the relevant "mean" and "sd" variables from the data.
- Next, I merge in the action labels to the main datasets
- Next, I append the training and test datasets into one dataset.  This is the first dataset asked for.
- The next part of the file generates the 'tidy' dataset by calculating the subject X activity average value for all of the variables.
- Lastly, I output the tidy dataset and create a codebook.
