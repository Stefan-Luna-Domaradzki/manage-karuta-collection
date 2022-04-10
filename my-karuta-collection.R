getwd()
setwd("C:/Users/Stefan/Desktop/Legends of Programming/Karuta - Data Science")
list.files()

?dplyr

library(dplyr)
library(rvest)
library(tidyverse)
library(data.table)


#-- web scraping doesn't work ---- 
{
#MAL_Url   <- paste0("https://myanimelist.net/animelist/Luna_Ardere?status=2")
#MAL_Xpath <- '//*[@id="list-container"]/div[4]/div/table'

#out_nodes <- html_nodes(read_html(MAL_Url), xpath=MAL_Xpath)

#(MAL_Collection <- html_table(out_nodes))
#MAL_Collection <- MAL_Collection[[1]]
}

#-- creating tables from MAL data ---- 

mal_collection <- read.csv2(file = "animelist_09-04-22.csv", header = T, sep = ",")

colnames(mal_collection)
mal_status <- mal_collection[,c("series_title", "my_status")]
mal_status <- split(mal_status["series_title"], mal_status["my_status"])
str(mal_status$Completed)



#-- creating tables from Karuta data ---- 

karuta_collection_spreadsheet <- read.csv2(file = "Karuta_09-04-22.csv",  header = T, sep=",")

colnames(karuta_collection_spreadsheet)

#karuta useful columns
k_useful <- karuta_collection_spreadsheet[,c("code","number", "edition", "character", "series","wishlists", "tag")]

for (card in row.names(k_useful)){
  if (k_useful[card,"tag"] == "" ){
    k_useful[card,"tag"] <- "NONE"
  }
}
print("done")

k_split_tag <- split(k_useful, k_useful$tag)


#-- dealing with untagged cards ----
k_no_tag <- k_split_tag["NONE"]
k_no_tag <- as.data.frame(k_no_tag, colnames = c("code", "number", "edition", "character", "series","wishlists", "tag"))
k_no_tag <- k_no_tag[,1:6]

colnames(k_no_tag) <-c("code", "number", "edition", "character", "series","wishlists")

?aggregate

k_no_tag_sorted <- k_no_tag
k_no_tag_sorted <- k_no_tag_sorted[order(k_no_tag_sorted$series),]


#don't know why but R adds new column named series and sets its value to 1
#well now it doesn't still don't know what happend
k_no_tag_sorted <- k_no_tag_sorted[,1:6]


colnames(k_no_tag_sorted)
k_view_no_tag  <- k_no_tag_sorted[,c("code", "character", "series","wishlists", "number", "edition")]


#put desired serie in quotes
?like()

search4serie <- "Fate"
search4serie <- readline(prompt="Enter serie: ")

(found_serie <- k_no_tag_sorted[like(k_no_tag_sorted$series, search4serie), ])

to_tag <- k_no_tag_sorted[like(k_no_tag_sorted$series, search4serie, ignore.case = TRUE, fixed = TRUE), "code"]; print(to_tag)

write(c(to_tag,","), "cards-to-tag.txt", ncolumns = 20)
