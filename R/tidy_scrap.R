# scraping a tidy dataframe from a website

#' Website Tidy scraping
#'
#' @description This function is used to scrap a tibble from a website.
#'
#' @param link the link of the webpage to scrap
#' @param nodes the vector of CSS elements to consider, the SelectorGadget tool is highly recommended
#' @param colnames the names of the expected columns
#' @param clean logical. Should the function clean the extracted tibble or not ? Default is FALSE.
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
#' @importFrom stringr str_replace
#' @importFrom stringr str_trim
#' @importFrom dplyr mutate_all


tidy_scrap <- function(link, nodes, colnames, clean = FALSE){

  if(length(nodes) != length(colnames)) stop("nodes and colnames lengths do not match")

  allframes <- lapply(nodes, function(x) scrap(link, x))

  result <- do.call(cbind,allframes)

  result <- as_tibble(result)

  names(result) <- colnames

  if (!clean) return(result)

  if (clean){

    result_clean <- result %>%
      mutate_all(~str_replace_all(., c("\n" = " ","\r" = " "))) %>%
      mutate_all(str_trim)
    return(result_clean)

  }
}

