# scraping a website

#' function to scrap a website
#'
#' @param link the link of the webpage to scrap
#' @param node the CSS element to consider, the SelectorGadget tool is highly recommended
#' @return a character vector
#' @example
#' \donttest{
#' # Extracting the books' title the 20 Best Sellers of 2019
#' tidy_scrap("https://www.barnesandnoble.com/b/the-top-100-bestsellers-of-the-year/_/N-1p4d",
#'    ".product-info-title a")
#' }
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




