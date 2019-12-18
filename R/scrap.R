# scraping a website

#' Simple website scraping
#' @description This function is used to scrap one element from a website.
#'
#' @param link the link of the webpage to scrap
#' @param node the CSS element to consider, the SelectorGadget tool is highly recommended
#' @return a character vector
#' @examples \donttest{
#' # Extracting imdb top 250 movie titles
#'
#' link <- "https://www.imdb.com/chart/top/"
#' node <- ".titleColumn a"
#'
#' tidy_scrap(link, node)}
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_text
#' @importFrom xml2 read_html
scrap <- function(link, node){

  data <- lapply(link,
    function(url){
      url %>% read_html() %>%
        html_nodes(node) %>%
        html_text()
    })

  return(unlist(data))
}




