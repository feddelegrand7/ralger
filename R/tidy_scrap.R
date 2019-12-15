# scraping a tidy dataframe from a website

#' function to scrap a tidy dataframe from a website
#'
#' @param link the link of the webpage to scrap
#' @param nodes the vector of CSS elements to consider, the SelectorGadget tool is highly recommended
#' @param scrap_names the names of the expected columns
#' @return a tidy dataframe
#' @examples
#' # Extracting as a tidy dataframe the books' title and author of the 20 Best Sellers of 2019 from the barnesandnoble website
#' \donttest{
#' tidy_scrap("https://www.barnesandnoble.com/b/the-top-100-bestsellers-of-the-year/_/N-1p4d",
#'    c(".product-info-title a", ".contributors a"),
#'    c("title", "author"))
#' }
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

