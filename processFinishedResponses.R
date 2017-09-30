## Author: David G. Cooper
## Email: David.Cooper@cheyney.edu
## Last Modification Date: Sept. 29, 2017
##
## Purpose: This is the main for converting the individual ratings to
## a tabulated form. The script takes a number of steps to complete this
## task:
##
## 1. Read and tabulate finished responses without practice questions
##    and repeated questions.
## 2. filter responses that took over 10 seconds
## 3. tabulate and save the results
##
## Dependencies:
## A. Script
##    - tabulateVotesV2.r
##
## B. Data Files
##    1. SentenceFilenames.csv
##    2. finishedResponses.csv
##    3. finishedEmoResponses.csv
##


## 0. source the vote counting functions.
source('./tabulateVotesV2.r')
source('./summarizeVotes.r')

## 1. Read and tabulate the file.

##    a. make sure the column classes are correct
finishedRespClasses <- c('character','factor','integer','factor','factor','numeric','numeric','numeric','numeric','numeric','character','numeric','character','character','character','numeric','character')
##    b. read in the file
finishedResponsesNoRepeatNoPractice <- read.csv('finishedResponses.csv',row.names='X',colClasses=finishedRespClasses)
#
# create a unique identifier for each finishedResponse#
finishedResponsesSessionQuestion <- finishedResponsesNoRepeatNoPractice$sessionNums*1000 + finishedResponsesNoRepeatNoPractice$queryType*100+finishedResponsesNoRepeatNoPractice$questNum

## 2. filter responses that took over 10 seconds,
##    were practice questions, or were repeated
##    questions.
##
## get emotion responses to get the timing of first
## response.
finishedEmo <- read.csv('finishedEmoResponses.csv',row.names='X')



#
# get the responses that took over 10 seconds for the first click after#
# observing the clip#
distractedResponses <- finishedEmo[which(as.numeric(as.character(finishedEmo$ttr))>10000),]

#
# create a unique identifier for each distractedResponse#
distractedResponseSessionQuestion <- distractedResponses$sessionNums*1000 + distractedResponses$queryType*100+distractedResponses$questNum#


## filter out the responses
goodFinishedResponsesNoRepeatNoPractice <- subset(finishedResponsesNoRepeatNoPractice, !(finishedResponsesSessionQuestion %in% distractedResponseSessionQuestion))

## 3. tabulate the votes

##get fileNames
fileNames <- read.csv('./SentenceFilenames.csv',stringsAsFactors=FALSE);

fileNames[7443,1] <- 7443;
fileNames[7443,2] <- "ANG_HI_practice";
fileNames[7444,1] <- 7444;
fileNames[7444,2] <- "SAD_MD_practice";

## call tabulate function
tabulatedVotes <- tabulateVotesV2(goodFinishedResponsesNoRepeatNoPractice,fileNames)

## call summarize function
summarizedVotes <- summarizeVotes(goodFinishedResponsesNoRepeatNoPractice,fileNames)

