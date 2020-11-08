## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("ralger")
#  

## ----example------------------------------------------------------------------
library(ralger)

my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver"

my_node <- ".listing_default" # The CSS class, we recommend SelectorGadget

scrap(link = my_link, node = my_node)



## ----example2-----------------------------------------------------------------
my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=" 

my_node <- ".listing_default"

scrap(link = paste0(my_link, 0:2), node = my_node)


## -----------------------------------------------------------------------------


data <- table_scrap(link ="https://www.boxofficemojo.com/chart/top_lifetime_gross/?area=XWW")

head(data)



## ----example3, message=FALSE, warning=FALSE-----------------------------------

my_link <- "https://www.imdb.com/search/title/?groups=top_250&sort=user_rating"

my_nodes <- c(
  ".lister-item-header a", # The title 
  ".text-muted.unbold", # The year of release 
  ".ratings-imdb-rating strong" # The rating)
  )

names <- c("title", "year", "rating") # respect the nodes order


tidy_scrap(link = my_link, nodes = my_nodes, colnames = names)



## ----example4-----------------------------------------------------------------


titles_scrap(link = "https://www.nytimes.com/")




## -----------------------------------------------------------------------------

titles_scrap(link = "https://www.nytimes.com/", contain = "York", case_sensitive = FALSE)




## -----------------------------------------------------------------------------

paragraphs_scrap(link = "https://ropensci.org/")


## -----------------------------------------------------------------------------

paragraphs_scrap(link = "https://ropensci.org/", collapse = TRUE)


## -----------------------------------------------------------------------------

weblink_scrap(link = "https://www.worldbank.org/en/access-to-information/reports/", 
              contain = "PDF", 
              case_sensitive = FALSE)



