library(UsingR)
library(xtable)
data(galton)

load("yesVotes.Rdata")

isLeftRight <- parteiparolen["SVP",] != parteiparolen["SP",]
isLeft <- isLeftRight & parteiparolen["SP",] == "ja"

leftRightColNames <-names(isLeftRight)[which(isLeftRight)]
lrColNames <- intersect(leftRightColNames, names(allYesVotesByKanton));
votesMinusTotalVote <- sweep(data.matrix(allYesVotesByKanton[,lrColNames]),MARGIN=2,as.numeric(allYesVotesByKanton[1,lrColNames]),FUN="-")
votesMinusTotalVoteLRadjusted <- sweep(votesMinusTotalVote,MARGIN=2, ifelse(isLeft[lrColNames],1,-1), FUN="*")
meanLeftness <- rowMeans(votesMinusTotalVoteLRadjusted)

printGeoChart <- function(votes) {
  G <- gvisGeoChart(votes, 
                    locationvar = "Kanton", 
                    colorvar = "Leftvotes", 
                    options = list(width = 600,
                                   height = 400,
                                   resolution="provinces",
                                   region="CH",
                                   colorAxis="{colors: ['red', 'blue']}")
  )
  print(G, "chart")
}

shinyServer(
  function(input, output) {
    output$votetitle <- renderText({
      if(input$select == "all") {
        "Mean over all votes since 1999"
      } else {
        correspondingVotes[input$select,"Gegenstand"]
      }
    })
    output$map <- renderPrint({
      voteNr <- "all"
      if(!is.null(input$select) && input$select != "all") {
        voteNr <- input$select
        if(voteNr %in% colnames(votesMinusTotalVoteLRadjusted)) {
          votes <- data.frame(Kanton=rownames(allYesVotesByKanton), Leftvotes=votesMinusTotalVoteLRadjusted[,voteNr])
          printGeoChart(votes)
        } else {
          cat("Ballot could not clearly assigned to either left or right wing.")
        }
      } else {
        votes <- data.frame(Kanton=rownames(allYesVotesByKanton), Leftvotes=meanLeftness)
        printGeoChart(votes)
      }
    })
    output$table <- renderTable({
      voteNr <- input$select
      if(voteNr != "all") {
        t(correspondingVotes[voteNr,])
      } else {
        data.frame()
      }
     })
    output$boxplot <- renderPlot({
      germanIndex <- c(2:10,12:21,24)
      frenchIndex <- c(11,23,25:27)
      if(input$select != "all") {
        boxplot(list(German=as.numeric(allYesVotesByKanton[germanIndex,input$select]), French=as.numeric(allYesVotesByKanton[frenchIndex,input$select])))
        abline(h=allYesVotesByKanton[1,input$select], col='red', lwd=5)
      } else {
        boxplot(list(German=rowMeans(data.matrix(allYesVotesByKanton[germanIndex,])), French=rowMeans(data.matrix(allYesVotesByKanton[frenchIndex]))))
        abline(h=mean(as.numeric(allYesVotesByKanton[1,])), col='red', lwd=5)        
      }
    })
    output$leftright <- renderText({
      voteNr <- NA
      if(!is.null(input$select)) {voteNr <- input$select}
      if(is.na(voteNr) |voteNr == "all"| !isLeftRight[voteNr]) {
        "Unknown"
      } else {
        if(isLeft[voteNr]) {
          "Left Wing"
        } else {
          "Right Wing"
        }
      }
    })
    output$voteNr <- renderPrint({print(input$select)})
    
  }
)