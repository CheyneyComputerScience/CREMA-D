## Author: David G. Cooper
## Email: David.Cooper@cheyney.edu
## Last Modification Date: Sep 29, 2017
## Purpose: this reads the tabulatedVotes data frame back in from the tabulatedVotes.csv file as if
##          processed by processFinishedResponses.R

## a vector of the column classes for the tabulatedVotes data frame.
tabulatedVotesClasses <- c('character','integer','integer','integer','integer','integer','integer','character','numeric','numeric','factor','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric','numeric')

## read the tabulated votes data frame.
tabulatedVotesTest <- read.csv('processedResults/tabulatedVotes.csv',row.names='X',colClasses=tabulatedVotesClasses)

## read the summary votes data frame
summaryData <- read.csv('processedResults/summaryTable.csv',row.names='X')
