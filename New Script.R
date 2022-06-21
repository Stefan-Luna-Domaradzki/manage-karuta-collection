#To Do ----
#read files
#automate fiile choosing


#split based on users tag
#create list of "tracked anime" (out of specified tag eg. all in fav)
#search for cards from tracked series that aren't tagged


#maybe function that will create directory for user

#create .txt file which will contain list of cards to tagged
#create second file with a list of cards that are specified there
#search for specified serie 






#libraries and stuff----

library(stringi)


getwd()
setwd("./data")
#functions ----


#_____________________________________________
read.user.collection <- function(){
  
  collections <- list.files()
  print(collections)
  
  cat("Enter name of the file to load: ")
  file.path <- readline()

  user.collection <- read.csv2(file.path, header = T, sep=",")
  #print(user.collection)
  
  return(user.collection)
}

#_____________________________________________
get.tracked.anime <- function(uc.large.list){
  
  print(names(uc.large.list))
  cat("Which tag specifies tracked anime?:") 
  tracked.name <- readline
  tracked.anime <- unique(uc.split.nw[[tracked.name]][5])
  
  return(tracked.anime)
}

#_____________________________________________

print.simple.menu <- function(){
  
  cat("1 - load new\n")
  cat("2 - get list of tracked anime\n")
  cat("quit - quit\n")
  
}


#_____________________________________________
#manages simple console menu

set.user.menu <- function(){
  operation <- TRUE


  while(operation){
  
    print.simple.menu()
    user.input <- readline()
    print(user.input)
  
    #1 - load new collection
    if(user.input == "1") {
      user.collection.raw <- read.user.collection()
    
      print(user.collection.raw)
     
      user.collection.raw <- read.user.collection()

      uc.no.working <- user.collection.raw[,c("code","number", "edition", "character", "series","wishlists", "tag")]
      
      uc.split.nw <- split.data.frame(uc.no.working, uc.no.working$tag)
      names(uc.split)[1] <- "none"
 
    }
  
    #2 - get list of tracked anime
    if(user.input == "2") {
      tracketd.anime <- get.tracked.anime()
      print(tracketd.anime)
    }
    
    #quit - quit menu
    if(user.input == "quit") {
      operation <- FALSE
      cat("> Quit menu!")
      }

    
    
    
    
  } #end of loop
  
}#end of function



#Testing ----

#po wczytaniiu test
user.collection.raw <- read.user.collection()


uc.no.working <- user.collection.raw[,c("code","number", "edition", "character", "series","wishlists", "tag")]

uc.split.nw <- split.data.frame(uc.no.working, uc.no.working$tag)
names(uc.split,nw)[1] <- "none"
domin <- as.data.frame(uc.split.nw$`domianik`)

t <- "fav"
a <- "azur"
unique(uc.split.nw[[t]][5])
#


set.user.menu()
read.user.collection()
