## CREMA-D (Crowd-sourced Emotional Mutimodal Actors Dataset)


#### Summary

CREMA-D is a data set of 7,442 original clips from 91 actors. These clips were from 48 male and 43 female actors between the ages of 20 and 74 coming from a variety of races and ethnicities (African America, Asian, Caucasian, Hispanic, and Unspecified). 

Actors spoke from a selection of 12 sentences. The sentences were presented using one of six different emotions (Anger, Disgust, Fear, Happy, Neutral, and Sad) and four different emotion levels (Low, Medium, High, and Unspecified). 

Participants rated the emotion and emotion levels based on the combined audiovisual presentation, the video alone, and the audio alone. Due to the large number of ratings needed, this effort was crowd-sourced and a total of 2443 participants each rated 90 unique clips, 30 audio, 30 visual, and 30 audio-visual.  95% of the clips have more than 7 ratings.

The *description* below specifies the data made availabe in this repository.

For a more complete description of how CREMA-D was created use [this link](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4313618/) or the link below to the paper.

#### Access

If you access the GitHub repository, please fill out [this form](https://docs.google.com/forms/d/e/1FAIpQLSdvOR994_Hsx7OkBU3oCzluXcmxw2P1nr-zBxcPgVBNLdD9Eg/viewform?usp=sf_link). That way we can keep a record of the community of CREMA-D users.

#### Contact/Questions

If you have questions about this data set, please submit a new issue to the repository or contact <dgcooper@cheyney.edu>.	

#### Storage requirements

Note: This repository uses Git Large File Storage, [git-lfs](https://git-lfs.github.com). You will need to install it on top of your git installation in order to get the video and audio files.  If you just download the zip file (~24MB zipped, ~163MB unzipped) then all of the video and audio files will just be links to the git-lfs file. For more information [go here](https://git-lfs.github.com). 

- **zip download:** Downloading the repository as a zip will get you all of the R scripts and csv files as well as stubs for all of the audio and video files. The zipped size is ~24MB, and the unzipped size is ~163MB.
- **git clone:** ~7.55GB is required to clone the whole repository. In addition to the R scripts and csv files, there is audio and video from 7442 recordings as flash video, mp3, and wav files as described below.

#### This Directory holds files used in the paper: 

[Cao H, Cooper DG, Keutmann MK, Gur RC, Nenkova A, Verma R. CREMA-D: Crowd-sourced Emotional Multimodal Actors Dataset. IEEE transactions on affective computing. 2014;5(4):377-390. doi:10.1109/TAFFC.2014.2336244.](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4313618/)

#### The collection of the videos is described in this paper:

[Keutmann, M. K., Moore, S. L., Savitt, A., & Gur, R. C. (2015). Generating an item pool for translational social cognition research: methodology and initial validation. Behavior research methods, 47(1), 228-234.](https://www.ncbi.nlm.nih.gov/pubmed/24719265)

#### License:
This Crowd-sourced Emotional Mutimodal Actors Dataset (CREMA-D) is made available under the Open Database License: http://opendatacommons.org/licenses/odbl/1.0/. Any rights in individual contents of the database are licensed under the Database Contents License: http://opendatacommons.org/licenses/dbcl/1.0/



#### Description

##### Text Data Files:

1. SentenceFilenames.csv - list of movie files used in study
2. finishedEmoResponses.csv - the first emotional response with timing.
3. finishedResponses.csv - the final emotional Responses with emotion levels with repeated and practice responses removed, used to tabulate the votes
4. finisedResponsesWithRepeatWithPractice.csv - the final emotional responses with emotion levels with repeated and practice responses in tact. Used to observe repeated responses and practice responses.
5. processedResults/tabulatedVotes.csv - the tabulated votes for each movie file.
6. VideoDemographics.csv - a mapping of ActorID (the first 4 digits of each video file) to Age, Sex, Race, and Ethicity.

##### R Scripts

1. processFinishedResponses.R - converts the finisedResponses.csv to the tabulated
2. readTabulatedVotes.R - reads processedResults/tabulatedVotes.csv


  
##### Finished Responses Columns <br>(finishedResponses.csv and<br> finishedResponsesWithRepeatWithPractice.csv)
- "localid" - a participant identifier
- "pos" - the original log file order for the participant
- "ans" - the emotion character with level separated by an underscore
- "ttr" - the response time in milliseconds
- "queryType" - a numeric value specifying the type of stimulus: 1. - voice only, 2. face only, 3. audio-visual
- "numTries" - number of extra emotion clicks. 
- "clipNum" - the file order of the clip from SentenceFilenames.csv
- "questNum" - the order of questions for the query type
- "subType" - the type of response in the logs, all values are 4 for the final emotion response
- "clipName" - the name of the video file
- "sessionNums" - the distinct number for the session
- "respEmo" - the emotion response
- "respLevel" - the emotion level response
- "dispEmo" - the displayed emotion
- "dispVal" - the displayed value
- "dispLevel" - a numeric representation of the displayed value, 20 for low, 50 for med, 80 for hi.

##### Finished EmoResponses Columns <br> (finishedEmoResponses.csv)

- "localid" - a participant identifier
- "sessionNums" - the distinct number for the session
-  "queryType" - a numeric value specifying the type of stimulus: 1. - voice only, 2. face only, 3. audio-visual
-  "questNum" - the order of questions for the query type
-  "pos" - the original log file order for the participant
-  "ttr" - the response time in milliseconds
-  "numTries" - number of extra emotion clicks. 
-  "clipNum" - the file order of the clip from SentenceFilenames.csv
-  "clipName" - the name of the video file

##### Summary Table Columns <br> processedResults/summaryTable.csv
- "fileName" - name of the movie file rated           
- "VoiceVote" - the emotion (or emotions separated by a colon) with the majority vote for Voice ratings. (A, D, F, H, N, or S)      
- "VoiceLevel" - the numeric rating (or ratings separated by a colon) corresponding to the emotion(s) listed in "VoiceVote"       
- "FaceVote" - the emotion (or emotions separated by a colon) with the majority vote for Face ratings. (A, D, F, H, N, or S)      
- "FaceLevel" - the numeric rating (or ratings separated by a colon) corresponding to the emotion(s) listed in "FaceVote"       
- "MultiModalVote" - the emotion (or emotions separated by a colon) with the majority vote for MultiModal ratings. (A, D, F, H, N, or S)      
- "MultiModalLevel" - the numeric rating (or ratings separated by a colon) corresponding to the emotion(s) listed in "MultiModalVote"       



##### Tabulated Votes Columns <br> processedResults/tabulatedVotes.csv

- "A" - count of Anger Responses
- "D" - count of Disgust Responses
- "F" - count of Fear Responses
- "H" - count of Happy Responses
- "N" - count of Neutral Responses
- "S" - count of Sad Responses
- "fileName" - name of the movie file rated           
- "numResponses" - total number of responses
- "agreement" - proportion of agreement
- "emoVote" - the majority vote agreement
-  "meanEmoResp" - the mean of all emotion levels
-  "meanAngerResp" - the mean of the anger levels
-  "meanDisgustResp" - the mean of the disgust levels
-  "meanFearResp" - the mean of the fear levels     
-  "meanHappyResp" - the mean of the happy levels
-  "meanNeutralResp" - the mean of the neutral levels
-  "meanSadResp" - the mean of the sad levels
-  "medianEmoResp" - the median of all emotion levels
-  "meanEmoRespNorm" - the normalized mean of all emotion levels
- "meanAngerRespNorm" - the normalized mean of anger emotion levels
-  "meanDisgustRespNorm" - the normalized mean of disgust emotion levels
-  "meanFearRespNorm" - the normalized mean of fear emotion levels
-  "meanHappyRespNorm" - the normalized mean of happy emotion levels
-  "meanNeutralRespNorm" - the normalized mean of neutral emotion levels
-  "meanSadRespNorm" - the normalized mean of sad emotion levels
-  "medianEmoRespNorm"  - the normalized median of all emotion levels

##### Video Demographics Columns <br> VideoDemographics.csv
- "ActorID" - the first 4 digits of the video/audio file that identifies the actor in the video.
- "Age" - the age in years of the actor at the time of the recording
- "Sex" - the binary sex that the actor identified
- "Race" - African American, Asian, Caucasian, or Unspecified
- "Ethnicity" - Hispanic or Not Hispanic

##### Filename labeling conventions

The Actor id is a 4 digit number at the start of the file. Each subsequent identifier is separated by an underscore (_).

Actors spoke from a selection of 12 sentences (in parentheses is the three letter acronym used in the second part of the filename): 

- It's eleven o'clock (IEO).- That is exactly what happened (TIE).- I'm on my way to the meeting (IOM).- I wonder what this is about (IWW).- The airplane is almost full (TAI).- Maybe tomorrow it will be cold (MTI).- I would like a new alarm clock (IWL)- I think I have a doctor's appointment (ITH).- Don't forget a jacket (DFA).- I think I've seen this before (ITS).
- The surface is slick (TSI).- We'll stop in a couple of minutes (WSI).

The sentences were presented using different emotion (in parentheses is the three letter code used in the third part of the filename):

- Anger (ANG)
- Disgust (DIS)
- Fear (FEA)
- Happy/Joy (HAP)
- Neutral (NEU)
- Sad (SAD)

and emotion level (in parentheses is the two letter code used in the fourth part of the filename):
 
- Low (LO)
- Medium (MD)
- High (HI)
- Unspecified (XX)

The suffix of the filename is based on the type of file, flv for flash video used for presentation of both the video only, and the audio-visual clips. mp3 is used for the audio files used for the audio-only presentation of the clips. wav is used for files used for computational audio processing.


##### Video Files
Flash Video Files used for presentation to the Raters are stored in the VideoFlash directory.

##### Audio Files

MP3 Audio files used for presentation to the Raters are stored in the AudioMP3 directory.


##### Processed Audio


WAV Audio files converted from the original video into a format appropriate for computational audio processing are stored in the AudioWAV directory.



##### Funding Sources
All data collection and method development was supported by the following funding sources:
- NIH R01 MH073174 (Computational quantification of emotion in faces and voice for neuropsychiatry) from National Institute of Mental Health (NIMH)
- NIH R34 MH105248 (Developing CBT-informed social enactment training curricula for CHR youths) from NIMH
- NIH R01 MH107235 (Multimodal brain maturation indices modulating psychopathology and neurocognition) from NIMH
