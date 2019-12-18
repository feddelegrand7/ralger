# scraping a tidy dataframe from a website

#' Tidy scrapping from a website
#'
#' @description This function is used to scrap a tibble from a website.
#'
#' @param link the link of the webpage to scrap
#' @param nodes the vector of CSS elements to consider, the SelectorGadget tool is highly recommended
#' @param scrap_names the names of the expected columns
#' @return a tidy dataframe
#' @examples \donttest{
#' # Extracting imdb movie titles and rating
#'
#' link     <- "https://www.imdb.com/chart/top/"
#' my_nodes <- c(".titleColumn a", "strong")
#' names    <- c("title", "rating")
#'
#' tidy_scrap(link, my_nodes, names)}
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_text
#' @importFrom xml2 read_html
#' @importFrom tidyr as_tibble

tidy_scrap <- function(link, nodes, scrap_names){

  if(length(nodes) != length(scrap_names)) stop("nodes and scrap_names lengths do not match")

  allframes <- lapply(nodes, function(x) scrap(link, x))

  result <- do.call(cbind,allframes)

  result <- as_tibble(result)

  names(result) <- scrap_names

  return(result)
}

