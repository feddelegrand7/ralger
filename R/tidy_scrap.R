# scraping a tidy dataframe from a website

#' function to scrap a tidy dataframe from a website
#'
#' @param link the link of the webpage to scrap
#' @param node the vector of CSS elements to consider, the SelectorGadget tool is highly recommanded
#' @param scrap_names the names of the expected columns
#' @return
#' @export
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_text
#' @importFrom xml2 read_html
#' @importFrom tidyr as_tibble

tidy_scrap <- function(link, nodes, scrap_names){

  allframes <- lapply(nodes, function(x) scrap(link, x))

  result <- do.call(cbind,allframes)

  result <- as_tibble(result)

  names(result) <- scrap_names

  return(result)
}



