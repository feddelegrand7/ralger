# scraping a website

#' function to scrap a website
#'
#' @param link the link of the webpage to scrap
#' @param node the CSS element to consider, the SelectorGadget tool is highly recommanded
#' @return
#' @export
#'
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




