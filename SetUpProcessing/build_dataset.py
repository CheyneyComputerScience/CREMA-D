import os
path = "/data/AudioWAV/"
os.chdir(path) # or do I need os.chdir("c:\\data\AudioWAV")?

filenames = os.listdir() 
filenames.sort()
random.seed(204)
random.shuffle(filenames)

devsplitpoint = int(0.8*len(filenames))
testsplitpoint = int(0.9*len(filenames))

train_filenames = filenames[0:devsplitpoint]
dev_filenames = filenames[devsplitpoint : testsplitpoint]
test_filenames = filenames[testsplitpoint:]


#create folders for our split sets and move them in
os.mkdir("train")
os.mkdir("dev")
os.mkdir("test")

for f in train_filenames:
    os.rename(path+f, path+"train/"+f)

for f in dev_filenames:
    os.rename(path+f, path+"dev/"+f)

for f in test_filenames:
    os.rename(path+f, path+"test/"+f)
