#To Do ----
#read files
#automate fiile choosing
#fix back option in choosing file path
#add back option in other functions

#add functio to track basic functional tags eg. "fav" "burn" "trade", get their names

#in simple menu add displaying current collection name

#split based on users tag
#create list of "tracked anime" (out of specified tag eg. all in fav)
#search for cards from tracked series that aren't tagged


#maybe function that will create directory for user

#create .txt file which will contain list of cards to tagged
#create second file with a list of cards that are specified there
#search for specified serie 


#notes ----
#in get.tracked.anime() a data frame is returned changing it to list might be helpful?



#libraries and stuff----

library(stringi)


getwd()
setwd("C:/Users/ja/Documents/GitHub/manage-karuta-collection")
setwd("./data")

#functions ----


#_____________________________________________
read.user.collection <- function(){
  
  collections <- list.files()
  print(collections)
  
  cat("Enter \"back\" to return to menu \n Enter name of the file to load: ")
  file.path <- readline()

  
  if(file.path=="back") {return(data.frame())}
  
  user.collection <- read.csv2(file.path, header = T, sep=",")
  #print(user.collection)
  
  return(user.collection)
}

#_____________________________________________
get.tracked.anime <- function(collection){
  
  print(names(collection))
  cat("Which tag specifies tracked anime?:") 
  tracked.name <- readline()
  tracked.anime <- unique(collection[[tracked.name]][5])
  
  row.names(tracked.anime) <- c(1:length(tracked.anime[,1]))
  
  return(tracked.anime)
}

#_____________________________________________
search.tracked.in.tag <- function(tracked,collection){
 
  #print(collection)
  
  print("dziala")
}

#_____________________________________________

print.simple.menu <- function(last.operation = "none"){
  
  cat("\n\n")
  cat("\n_______________________________________")
  cat("\nSimple menu")
  cat("\n_______________________________________")
  cat("\nLast operation: ", last.operation)
  
  cat("\nPossible operations:\n\n")
  cat("1 - load new\n")
  cat("2 - get list of tracked anime\n")
  cat("3 - search for tracked anime in specified tag\n")
  
  
  cat("11 - check menu status")
  cat("quit - quit")
  
  cat("\n_______________________________________")
  cat("\nType your answer:")
}
print.simple.menu()

#_____________________________________________
#manages simple console menu

set.user.menu <- function(){
  operation <- TRUE
  last.operation <- "none"

  while(operation){
    
    print.simple.menu(last.operation)
    user.input <- readline()
    #print(user.input)
  
    
    #1 - load new collection "no working cards"
    if(user.input == "1") {
      
      user.collection.raw <- read.user.collection()
      if(length(user.collection.raw)==0) {
        #change this no !=0 and pass whole function into this new if statement
        print("data frame length is 0")
        break
        }
      
      uc.no.working <- user.collection.raw[,c("code","number", "edition", "character", "series","wishlists", "tag")]
      
      uc.split.nw <- split.data.frame(uc.no.working, uc.no.working$tag)
      names(uc.split.nw)[1] <- "none"
      
      uc.menu <- uc.split.nw
      last.operation <- "\"load new collection\""
    }
  
    #when adding workers optimalisation function will have following line
    #uc.menu <- uc.split.ww
    
    
    #2 - get list of tracked anime
    if(user.input == "2") {
      tracked.anime <- get.tracked.anime(uc.menu)
      tracked.anime <- sort(tracked.anime$`series`)

      cat("List of tracked anime:")
      for (i in c(1:length(tracked.anime))) {cat("\n",i, " ", tracked.anime[i])}
     
      
      last.operation <- "\"get list of tracked anime\""
    }
    
    
    #3 - search for tracked anime in user's tag
    #print those with highest wishlist
    if(user.input == "3") {
      cat("specify tag to scan: ")
      tag.to.scan <- readline()
      
      
      search.tracked.in.tag(tracked.anime, uc.menu[[tag.to.scan]])
      
      last.operation <- "\"tracked anime in tag\""
    }
    
    
    #4 - search for specified card in tag?
    if(user.input == "4") {
  
      print("not available")
      
    }
    
    if(user.input == "11") {
      cat("menu status: working")
      }
    
    #quit - quit menu
    if(user.input == "quit") {
      operation <- FALSE
      cat("> Quit menu!")
      }

    
    
    
    
  } #end of loop
  
}#end of function



#Testing ----

test <- read.user.collection() 
uc.no.working <- test[,c("code","number", "edition", "character", "series","wishlists", "tag")]

uc.split.nw <- split.data.frame(uc.no.working, uc.no.working$tag)
names(uc.split.nw)[1] <- "none"

uc.menu <- uc.split.nw


tracked <- get.tracked.anime(uc.menu)
str(tracked)
tracked <- sort(tracked$`series`)
tracked

search.tracked.in.tag(tracked, uc.menu)

#po wczytaniiu test



set.user.menu()

