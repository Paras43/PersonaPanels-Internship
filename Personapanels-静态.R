# part 1- Housekeepers
library(dplyr) # Inspect the data.
getwd()
setwd("/Users/apple/Desktop/Northeastern University/5964 XN project/")
MM <- read.csv("Millennial Moms.csv")
str(MM)
summary(MM) # View the max and min value of each word
tbl_df(MM)
colnames(MM) 
MRW <- colnames(MM)[apply(MM,1,which.max)]
tbl_df(MRW)
Result <- data.frame(MM$Date,MRW)  # Scan the most relevant words on each day
colnames(Result)[1:2] <- c("Date", "Most Relevant Words")
Result 

# part 2- Students 
EM <- read.csv("Environmental Millennial.csv")
str(EM)
summary(EM)
tbl_df(EM)
colnames(EM) 
MRW2 <- colnames(EM)[apply(EM,1,which.max)]
tbl_df(MRW2)
Result2 <- data.frame(EM$Date,MRW2)
colnames(Result2)[1:2] <- c("Date", "Most Relevant Words")
Result2

# part 3- Programmer & Scientists 
TGM <- read.csv("Tech Geek Millennial.csv")
str(TGM)
summary(TGM)
tbl_df(TGM)
colnames(TGM) 
MRW3 <- colnames(TGM)[apply(TGM,1,which.max)]
tbl_df(MRW3)
Result3 <- data.frame(TGM$Date,MRW3)
colnames(Result3)[1:2] <- c("Date", "Most Relevant Words")
Result3

# part 4- Officers & Business men 
DCMM <- read.csv("Don't Call Me a Millennial .csv")
str(DCMM)
summary(DCMM)
tbl_df(DCMM)
colnames(DCMM)
MRW4 <- colnames(DCMM)[apply(DCMM,1,which.max)]
tbl_df(MRW4)
Result4 <- data.frame(DCMM$Date,MRW4)
colnames(Result4)[1:2] <- c("Date", "Most Relevant Words")
Result4

# part 5- Engineers 
MNO <- read.csv("Millennial in Name Only.csv")
str(MNO)
summary(MNO)
tbl_df(MNO)
colnames(MNO)
MRW5 <- colnames(MNO)[apply(MNO,1,which.max)]
tbl_df(MRW5)
Result5 <- data.frame(MNO$Date,MRW5)
colnames(Result5)[1:2] <- c("Date", "Most Relevant Words")
Result5

# part 6- Shopkeepers
DRTM <- read.csv("Do the Right Thing Millennial.csv")
str(DRTM)
summary(DRTM)
tbl_df(DRTM)
colnames(DRTM)
MRW6 <- colnames(DRTM)[apply(DRTM,1,which.max)]
tbl_df(MRW6)
Result6 <- data.frame(DRTM$Date,MRW6)
colnames(Result6)[1:2] <- c("Date", "Most Relevant Words")
Result6

# Export the results
write.csv(Result,"Housekeepers.csv")
write.csv(Result2,"Students.csv")
write.csv(Result3,"Programmer & Scientists.csv")
write.csv(Result4,"Officers & Business men.csv")
write.csv(Result5,"Engineers.csv")
write.csv(Result6,"Shopkeepers.csv")
