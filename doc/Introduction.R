## -----------------------------------------------------------------------------
library(ralger)

data <- scrap(
  "https://www.goldenglobes.com/winners-nominees/best-performance-actress-motion-picture-drama", 
  ".primary-nominee a"
)

data


## -----------------------------------------------------------------------------

link <- "https://www.goldenglobes.com/winners-nominees/best-performance-actress-motion-picture-drama?page=" # Mind the change in the link structure "page=" 

node <- ".primary-nominee a" # we use the same node as previously

data_all <- scrap(paste(link, 0:20, sep = ""), node)

length(data_all)


## ----message=FALSE, warning=FALSE---------------------------------------------

links <- paste(link, 0:20, sep = "") # The links required to extract the 350 observations

nodes <- c(".primary-nominee a", ".secondary-nominee")

column_names <- c("Actress", "Movie")


global_df <- tidy_scrap(links, nodes, column_names)


head(global_df, n = 10)


