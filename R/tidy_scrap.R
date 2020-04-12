# scraping a tidy data frame from a website

#' Website Tidy scraping
#'
#' @description This function is used to scrap a tibble from a website.
#'
#' @param link the link of the web page to scrap
#' @param nodes the vector of HTML or CSS elements to consider, the SelectorGadget tool is highly recommended.
#' @param colnames the names of the expected columns.
#' @param clean logical. Should the function clean the extracted tibble or not ? Default is FALSE.
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrap the web page ? Default is FALSE.
#' @return a tidy data frame.
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
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed



tidy_scrap <- function(link, nodes, colnames, clean = FALSE, askRobot = FALSE){

  if(length(nodes) != length(colnames)) stop("nodes and colnames lengths do not match")

  if(askRobot){

    if(paths_allowed(link) == TRUE){

      message(green("It's ok you're allowed to scrap this web page"))

    } else {

      message(bgRed("WARNING: you're not allowed to scrap this web page"))

    }


  }

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

