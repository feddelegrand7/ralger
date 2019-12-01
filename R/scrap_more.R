
# scraping multiple pages

#' Scraping multiple pages of a website
#'
#' @param link the link of the webpage to scrap
#' @param node the CSS element to consider, the SelectorGadget tool is highly recommanded
#' @param from the first page of scraping, default equal 0
#' @param to the last page of scraping, default equal 20
#'
#' @return
#' @export
#'
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_text
#' @importFrom xml2 read_html

scrap_more <- function(link, node, from = 0, to = 20){

  data <- lapply(paste0(link, from:to),
    function(url){
      url %>% xml2::read_html() %>%
        rvest::html_nodes(node) %>%
        rvest::html_text()
    })

  return(unlist(data))
}

