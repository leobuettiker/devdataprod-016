library(googleVis)
library(xtable)
load("yesVotes.Rdata")
votes <- as.list(c("all",correspondingVotes[,1]))
names(votes) <- c("Mean over all votes since 1999",paste(correspondingVotes[,2],correspondingVotes[,3]))

shinyUI(pageWithSidebar(
  headerPanel("How left does Switzerland vote?"),
  sidebarPanel(
    selectInput("select", label = h3("Select box"), 
                choices = votes, selected = 1, width="100%"),
    h2("Short explanation"),
    p(a("Switzerland",href="http://en.wikipedia.org/wiki/Switzerland")," is country in the middle of europe. It's seperated in 26 cantons. In Switzerland the 4 official languages are German, French, Italien and Romansh."),
    p("This shiny application researches the different voting behaviours between the two main language region, the French and the German speaking part."),
    p("The numbers and colors on the map indicate many percent points a canton deviate from the national mean. A ballot is used if the main left wing party (SP) disagrees with the main right wing party (SVP). If the left wing party votes yes, the data of the vote is considered unmutated. If the right wing party votes yes the data is inverted (multiplied with -1)."),
    p("The application is implemented with shiny, the maps are created with googleVis and the data are preprocessed with readODS and XLConnect."),
    p("All data are from ",a("Offene Behördendaten der Schweiz", href="http://opendata.admin.ch/"))
  ),
  mainPanel(
    h1(textOutput('votetitle')),
    h2("Deviation to the left from the national mean"),
    htmlOutput('map'),
    h2("Yes votes by language region"),
    plotOutput('boxplot'),
    p("A yes votes does not indicate if the ballot was a left or right wing topic. The red line is how much yes votes in percentage are given overall."),
    h2("Additional Information"),
    tableOutput('table')
  )
))