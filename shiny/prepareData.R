# Uncomment the download.file lines to re-download the files.
library(readODS)
library(XLConnect)

# trim funciton from http://stackoverflow.com/a/2261149/55070
# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

#download.file("http://www.bfs.admin.ch/xmlns/opendata/je-d-17.03.02.03.ods", "yesVotes.ods", mode="wb")
yesVotesByKanton <- read.ods("yesVotes.ods");
rownames <- yesVotesByKanton[[1]][c(9,11:36),1]
Encoding(rownames)<- "UTF-8"
rownames[c(16,17)] <- c("Appenzell Ausserrhoden","Appenzell Innerrhoden")
cleanedSheets <- lapply(yesVotesByKanton, function(x) x[c(6,9,11:36),-1])
allYesVotesByKanton <- do.call("cbind",cleanedSheets)
allYesVotesByKanton <- allYesVotesByKanton[,which(colSums(allYesVotesByKanton == "")==0)]
colnames(allYesVotesByKanton) <- sapply(allYesVotesByKanton[1,], function(x) sub(",",".",substr(x,5,9)))
allYesVotesByKanton <- allYesVotesByKanton[-1,]
rownames(allYesVotesByKanton) <- rownames


#download.file("http://www.bfs.admin.ch/xmlns/opendata/je-d-17.03.02.02.ods", "globalYesVotes.ods", mode="wb")
votes <- read.ods("globalYesVotes.ods");
cleanedSheets <- lapply(votes, function(x)    {
  red <- x[-c(1:7),]
  red[which(red[,"N"] != ""),]
  })
allVotes <- do.call("rbind",cleanedSheets)
Encoding(allVotes[,3])<- "UTF-8"
allVotes <- allVotes[order(as.numeric(allVotes[,1]), decreasing=T),]
allVotes[,3]

headers <- trim(sub("- ", "",paste(votes[[1]][4,], votes[[1]][5,])))
Encoding(headers) <- "UTF-8"
correspondingVotes <- allVotes[which(sub(" .*","", allVotes[,1]) %in% colnames(allYesVotesByKanton)),]
colnames(correspondingVotes) <- headers
rownames(correspondingVotes) <- correspondingVotes[,1]

rownames(allYesVotesByKanton)

boxplot(as.numeric(allYesVotesByKanton[,"563"]))
germanIndex <- c(2:10,12:21,24)
frenchIndex <- c(11,23,25:27)
germanKantone <- rownames(allYesVotesByKanton)[2:21]
frenchKantone <- rownames(allYesVotesByKanton)[c(23,25:27)]
boxplot(list(as.numeric(allYesVotesByKanton[,"563"][germanIndex]), as.numeric(allYesVotesByKanton[,"563"][frenchIndex])))

#download.file("http://www.bfs.admin.ch/bfs/portal/de/index/themen/17/22/lexi.Document.21843.xls", "parteiparolen.xls", mode="wb")
wb <- loadWorkbook("./parteiparolen.xls")

years <- 2014:1999
allParties <- c()
allVotes <- c()
for(j in seq_along(years)) {
  year <- years[j]
  line <- lineOfVoteNr[j]
  
  data <- readWorksheet(wb, sheet = as.character(year), header=F)
  
  parties <- data[7:25,1]
  partiesSubscriptRemoved <- sub(" .*","",parties)
  allParties <- c(allParties, partiesSubscriptRemoved[!is.na(partiesSubscriptRemoved)])
  
  votes <- sub(" .*","",sub("Nr. ","",data[line,-1]))
  allVotes <- c(votes[!is.na(votes)], allVotes)
}
allParties <- unique(allParties)

lineOfVoteNr <- c(rep(7,4), rep(6,12))
parteiparolen <- matrix(nrow=length(allParties), ncol=length(allVotes),dimnames=list(allParties,allVotes))
for(j in seq_along(years)) {
  year <- years[j]
  line <- lineOfVoteNr[j]
  data <- readWorksheet(wb, sheet = as.character(year), header=F)
  votes <- sub(" .*","",sub("Nr. ","",data[line,-1]))
  for(i in 7:25) {
    party <- sub(" .*","", data[i,1])
    if(party %in% allParties) {
      for(x in seq_along(data[i,-1])) {
      parteiparolen[party,votes[x]] <- data[i,x+1]
      }
    }
  }
}
parteiparolen <- tolower(parteiparolen)
parteiparolen[parteiparolen==1] <- "ja"
parteiparolen[parteiparolen==2] <- "nein"
parteiparolen[parteiparolen==3] <- "freigabe"
parteiparolen[!(parteiparolen %in% c("ja","nein","freigabe"))] <- NA

save(parteiparolen, correspondingVotes, allYesVotesByKanton, file="yesVotes.Rdata")

