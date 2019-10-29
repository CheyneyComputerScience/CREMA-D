## Author: David G. Cooper
## Email: David.Cooper@cheyney.edu
## Last Modification Date: July 13, 2017
##
## Purpose: This is the file that holds the tabulateVotesV2 function.
## it takes a date frame of test responses, and tabulates the responses
## by clip and query type: voice-only, video-only, or audio-visual
## fileNames will help with the emotion types


tabulateVotesV2 <- function(testResponses,fileNames) {
  
# get a unique identifier per clip per query type
goodQueryTypeClip <- as.factor((100000*testResponses$queryType) + testResponses$clipNum)

# get a unique identifier per respEmo per clip per query type
goodEmoQueryTypeClip <- as.factor((1000000*as.numeric(as.factor(testResponses$respEmo))) + (100000*testResponses$queryType) + testResponses$clipNum)


# get a mean of the emotion level by clip by query type
testResponsesMeanRespLevelByQueryTypeClip <- by(as.numeric(testResponses$respLevel),goodQueryTypeClip,mean)

# get a median of the emotion level by clip by query type
testResponsesMedianRespLevelByQueryTypeClip <- by(as.numeric(testResponses$respLevel),goodQueryTypeClip,median)



# get a mean of the emotion level by emotion by clip by query type
testResponsesMeanRespLevelByEmoQueryTypeClip <- by(as.numeric(testResponses$respLevel),goodEmoQueryTypeClip,mean)



allMeanEmoRespLevel <- data.frame(cbind(testResponsesMeanRespLevelByEmoQueryTypeClip))
names(allMeanEmoRespLevel) <- c("meanRespLevel")
allMeanEmoRespLevel$respEmo <- factor(substr(row.names(allMeanEmoRespLevel),1,1),labels=c('A','D','F','H','N','S'))
allMeanEmoRespLevel$respType <- factor(substr(row.names(allMeanEmoRespLevel),2,2),labels=c('V','F','M'))
allMeanEmoRespLevel$goodQueryTypeClip <- as.numeric(substr(row.names(allMeanEmoRespLevel),2,8))
goodQueryTypeClipSixEmoMeanResp <- by(allMeanEmoRespLevel,allMeanEmoRespLevel$goodQueryTypeClip,function(x){a <- rep(-1,6); a[x$respEmo] <- x$meanRespLevel;return(a)})
goodQueryTypeClipSixEmoMeanRespFrame <- data.frame(matrix(unlist(goodQueryTypeClipSixEmoMeanResp),ncol=6,byrow=TRUE))
names(goodQueryTypeClipSixEmoMeanRespFrame) <- c("AngerMeanResp","DisgustMeanResp","FearMeanResp","HappyMeanResp","NeutralMeanResp","SadMeanResp")








# get a median of the emotion level by emotion by clip by query type
testResponsesMedianRespLevelByEmoQueryTypeClip <- by(as.numeric(testResponses$respLevel),goodEmoQueryTypeClip,median)




# get a histogram of the emotion levels by rater
testLevelsHistByRater <- by(as.numeric(testResponses$respLevel),testResponses$localid,hist,breaks=(1:100),plot=FALSE)

# get a summary of the emotion levels by rater
testLevelsSummaryByRater <- by(as.numeric(testResponses$respLevel),testResponses$localid,summary)

# using the summary we can get a normalization factor from the response width, and minimum value
# then for each responseLevel, we can subtract by the minimum value and multiply by 100/responseWidth
# first need a vector of minimum values, and the normalization factor by localid
# then we need a method that goes over the testresponses and adds a normalized respLevel
# then we can get testResponsesMeanNormalizedRespLevelByQueryTypeClip and
# testResponsesMedianNormalizedRespLevelByQueryTypeClip.

# get row names for the levelMatrices
levelRowNames <- subset(data.frame(names(unlist(lapply(testLevelsSummaryByRater,is.null)))),!(unlist(lapply(testLevelsSummaryByRater,is.null))))

# get max
levelMaxMatrix <- matrix(unlist(lapply(testLevelsSummaryByRater,function(x) {return(x[6])})),ncol=1,byrow=TRUE)
levelMaxArray <- NULL
levelMaxArray[as.numeric(row.names(levelRowNames))] <- levelMaxMatrix

# get min
levelMinMatrix <- matrix(unlist(lapply(testLevelsSummaryByRater,function(x) {return(x[1])})),ncol=1,byrow=TRUE)
levelMinArray <- NULL
levelMinArray[as.numeric(row.names(levelRowNames))] <- levelMinMatrix
# get width
levelWidthArray <- levelMaxArray - levelMinArray

# get normalization factor
levelNormalizationFactorArray <- 100/levelWidthArray

# get the levelIndices
testResponses$localIdIndex <- as.numeric(testResponses$localid)

# set the individual maxLevels
testResponses$maxLevel <- levelMaxArray[testResponses$localIdIndex]

# set the individual minLevels
testResponses$minLevel <- levelMinArray[testResponses$localIdIndex]

# set the individual normalizationFactors
testResponses$normalizationFactor <- levelNormalizationFactorArray[testResponses$localIdIndex]

# set the individual normalized response level
testResponses$respLevelNormalized <- (as.numeric(testResponses$respLevel) - testResponses$minLevel) * testResponses$normalizationFactor


# get a mean of the emotion level by clip by query type
testResponsesMeanRespLevelNormByQueryTypeClip <- by(as.numeric(testResponses$respLevelNormalized),goodQueryTypeClip,mean)

# get a median of the emotion level by clip by query type
testResponsesMedianRespLevelNormByQueryTypeClip <- by(as.numeric(testResponses$respLevelNormalized),goodQueryTypeClip,median)


# get a mean of the emotion level by respEmo by clip by query type
testResponsesMeanRespLevelNormByEmoQueryTypeClip <- by(as.numeric(testResponses$respLevelNormalized),goodEmoQueryTypeClip,mean)


allMeanEmoRespLevelNorm <- data.frame(cbind(testResponsesMeanRespLevelNormByEmoQueryTypeClip))
names(allMeanEmoRespLevelNorm) <- c("meanRespLevelNorm")
allMeanEmoRespLevelNorm$respEmo <- factor(substr(row.names(allMeanEmoRespLevelNorm),1,1),labels=c('A','D','F','H','N','S'))
allMeanEmoRespLevelNorm$respType <- factor(substr(row.names(allMeanEmoRespLevelNorm),2,2),labels=c('V','F','M'))
allMeanEmoRespLevelNorm$goodQueryTypeClip <- as.numeric(substr(row.names(allMeanEmoRespLevelNorm),2,8))
goodQueryTypeClipSixEmoMeanNormResp <- by(allMeanEmoRespLevelNorm,allMeanEmoRespLevelNorm$goodQueryTypeClip,function(x){a <- rep(-1,6); a[x$respEmo] <- x$meanRespLevelNorm;return(a)})
goodQueryTypeClipSixEmoMeanRespNormFrame <- data.frame(matrix(unlist(goodQueryTypeClipSixEmoMeanNormResp),ncol=6,byrow=TRUE))
names(goodQueryTypeClipSixEmoMeanRespNormFrame) <- c("AngerMeanRespNorm","DisgustMeanRespNorm","FearMeanRespNorm","HappyMeanRespNorm","NeutralMeanRespNorm","SadMeanRespNorm")






# get a median of the emotion level by respEmo by clip by query type
testResponsesMedianRespLevelNormByEmoQueryTypeClip <- by(as.numeric(testResponses$respLevelNormalized),goodEmoQueryTypeClip,median)



# get a histogram of the emotion responses by clip by query type
testResponsesHistRespEmoByQueryTypeClip <- by(as.numeric(as.factor(testResponses$respEmo)),goodQueryTypeClip,hist,breaks=1:7-0.5,plot=FALSE)


# create a data frame from this
testResponsesHistRespEmoByQueryTypeClipDataFrame <- data.frame(matrix(unlist(lapply(testResponsesHistRespEmoByQueryTypeClip,function(x) {return(x$counts)})),ncol=6,byrow=TRUE))#
# label the rows based on the localids
row.names(testResponsesHistRespEmoByQueryTypeClipDataFrame) <- row.names(testResponsesHistRespEmoByQueryTypeClip)
# label the emotions
names(testResponsesHistRespEmoByQueryTypeClipDataFrame) <- c("A","D","F","H","N","S")



voiceTestResponses <- subset(testResponses,queryType==1)
faceTestResponses <- subset(testResponses,queryType==2)
multimodalTestResponses <- subset(testResponses,queryType==3)


voiceClips <- as.numeric(levels(as.factor(as.numeric(voiceTestResponses$clipNum))));
faceClips <- as.numeric(levels(as.factor(as.numeric(faceTestResponses$clipNum))));
multimodalClips <- as.numeric(levels(as.factor(as.numeric(multimodalTestResponses$clipNum))));

# set the filenames
#testResponsesHistRespEmoByQueryTypeClipDataFrame$fileName <- c(fileNames$Filename,fileNames$Filename,fileNames$Filename)
testResponsesHistRespEmoByQueryTypeClipDataFrame$fileName <- c(fileNames[voiceClips,]$Filename,fileNames[faceClips,]$Filename,fileNames[multimodalClips,]$Filename)


# count the number of responses per clip per query type
testResponsesHistRespEmoByQueryTypeClipDataFrame$numResponses <- rowSums(testResponsesHistRespEmoByQueryTypeClipDataFrame[,1:6])
# get the percentage of agreement for the majority vote
testResponsesHistRespEmoByQueryTypeClipDataFrame$agreement <- pmax(testResponsesHistRespEmoByQueryTypeClipDataFrame[,1],testResponsesHistRespEmoByQueryTypeClipDataFrame[,2],testResponsesHistRespEmoByQueryTypeClipDataFrame[,3],testResponsesHistRespEmoByQueryTypeClipDataFrame[,4],testResponsesHistRespEmoByQueryTypeClipDataFrame[,5],testResponsesHistRespEmoByQueryTypeClipDataFrame[,6])/testResponsesHistRespEmoByQueryTypeClipDataFrame$numResponses
# get the majority vote
#goodEmoVote <- as.factor(max.col(testResponsesHistRespEmoByQueryTypeClipDataFrame[,1:6]))#
# label them appropriately
#levels(goodEmoVote) <- names(testResponsesHistRespEmoByQueryTypeClipDataFrame[,1:6])

# get the votes with ties
maxEmoVotes <- apply(testResponsesHistRespEmoByQueryTypeClipDataFrame[,1:6],1,function(x) which(x == max(x)))
# get the names of the emotion
maxEmoVotesList <- lapply(maxEmoVotes,names)
# convert the lists into strings then factors
goodEmoVote <- as.factor(sapply(maxEmoVotesList,paste,collapse=":"))
    

# create the emoVote variable in the data frame and set it to the right value
testResponsesHistRespEmoByQueryTypeClipDataFrame$emoVote <- goodEmoVote;

# add the meanEmotionLevel
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanEmoResp = c(testResponsesMeanRespLevelByQueryTypeClip);


# add the meanAngerLevel
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanAngerResp <- goodQueryTypeClipSixEmoMeanRespFrame$AngerMeanResp;

# add the meanDisgustLevel
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanDisgustResp <- goodQueryTypeClipSixEmoMeanRespFrame$DisgustMeanResp;

# add the meanFearLevel
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanFearResp <- goodQueryTypeClipSixEmoMeanRespFrame$FearMeanResp;

# add the meanHappyLevel
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanHappyResp <- goodQueryTypeClipSixEmoMeanRespFrame$HappyMeanResp;

# add the meanNeutralLevel
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanNeutralResp <- goodQueryTypeClipSixEmoMeanRespFrame$NeutralMeanResp;

# add the meanSadLevel
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanSadResp <- goodQueryTypeClipSixEmoMeanRespFrame$SadMeanResp;



# add the medianEmotionLevel
testResponsesHistRespEmoByQueryTypeClipDataFrame$medianEmoResp = c(testResponsesMedianRespLevelByQueryTypeClip);

# add the meanEmotionLevelNormalized
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanEmoRespNorm = c(testResponsesMeanRespLevelNormByQueryTypeClip);


# add the meanAngerLevelNormalized
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanAngerRespNorm <- goodQueryTypeClipSixEmoMeanRespNormFrame$AngerMeanRespNorm;

# add the meanDisgustLevelNormalized
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanDisgustRespNorm <- goodQueryTypeClipSixEmoMeanRespNormFrame$DisgustMeanRespNorm;

# add the meanFearLevelNormalized
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanFearRespNorm <- goodQueryTypeClipSixEmoMeanRespNormFrame$FearMeanRespNorm;

# add the meanHappyLevelNormalized
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanHappyRespNorm <- goodQueryTypeClipSixEmoMeanRespNormFrame$HappyMeanRespNorm;

# add the meanNeutralLevelNormalized
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanNeutralRespNorm <- goodQueryTypeClipSixEmoMeanRespNormFrame$NeutralMeanRespNorm;

# add the meanSadLevelNormalized
testResponsesHistRespEmoByQueryTypeClipDataFrame$meanSadRespNorm <- goodQueryTypeClipSixEmoMeanRespNormFrame$SadMeanRespNorm;



# add the medianEmotionLevelNormalized
testResponsesHistRespEmoByQueryTypeClipDataFrame$medianEmoRespNorm = c(testResponsesMedianRespLevelNormByQueryTypeClip);


return(testResponsesHistRespEmoByQueryTypeClipDataFrame);

}
