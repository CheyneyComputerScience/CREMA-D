## Author: David G. Cooper
## Email: David.Cooper@cheyney.edu
## Last Modification Date: Sept. 29, 2017
##
## Purpose: This is the file that holds the summarizeVotes function.
## it takes a date frame of test responses, and tabulates the responses
## into a summary row for each filename.


summarizeVotes <- function(testResponses,fileNames) {
  
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
    
# get the mean level for the majority vote
meanMajorityResp <- mapply(function(x,y) x[y],goodQueryTypeClipSixEmoMeanResp,maxEmoVotes)

# format to 2 decimal places
goodMajorityRespList <- sapply(meanMajorityResp,format,digits=4)

# turn it into one string similar to goodEmoVote
goodMajorityResp <- sapply(goodMajorityRespList,paste,collapse=":")
    
# make a data.frame of the summary data    
emoVoteResp <- data.frame(fileNames[1:7442,2],goodEmoVote[1:7442],goodMajorityResp[1:7442],goodEmoVote[7443:(2*7442)], goodMajorityResp[7443:(2*7442)],goodEmoVote[((2*7442+1)):(3*7442)], goodMajorityResp[((2*7442)+1):(3*7442)])

# label the column names appropriately
names(emoVoteResp) <- c('FileName','VoiceVote','VoiceLevel','FaceVote','FaceLevel','MultiModalVote','MultiModalLevel')

# label the row names appropriately
row.names(emoVoteResp) <- fileNames[1:7442,1]

return(emoVoteResp);

}
