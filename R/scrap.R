# scraping a website

#' Simple website scraping
#'
#' @description This function is used to scrape one element from a website.
#'
#' @param link the link of the web page to scrape
#' @param node the HTML or CSS element to consider, the SelectorGadget tool is highly recommended
#' @param clean logical. Should the function clean the extracted vector or not ? Default is FALSE.
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#' @return a character vector
#' @examples
#' \donttest{
#' # Extracting imdb top 250 movie titles
#'
#' link <- "https://www.imdb.com/chart/top/"
#' node <- ".titleColumn a"
#'
#' scrap(link, node)
#' }
#'
#' @export
#' @importFrom rvest html_nodes html_text %>%
#' @importFrom xml2 read_html
#' @importFrom stringr str_replace_all str_trim
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom curl has_internet
#' @importFrom stringi stri_remove_empty
#'

scrap <- function(link,
                  node,
                  clean = FALSE,
                  askRobot = FALSE) {


  # returns an error if either link or node are not provided
  if (missing(link) || missing(node)) {
    stop("'link' and 'node' are mandatory parameters")
  }

  # returns an error if link and node are not character strings
  if (!is.character(link) || !is.character(node)) {
    stop("'link' and 'node' parameters must be provided as character strings")
  }


  ###################### Ask robot related ##################################################
  if (askRobot) {
    if (paths_allowed(link) == TRUE) {
      message(green("the robot.txt doesn't prohibit scraping this web page"))
    } else {
      message(bgRed(
        "WARNING: the robot.txt doesn't allow scraping this web page"
      ))
    }
  }
  #########################################################################################

  tryCatch(
    expr = {
      data <- lapply(
        link,
        function(url) {
          url %>%
            read_html() %>%
            html_nodes(node) %>%
            html_text()
        }
      )

      if (!clean) {
        return(stri_remove_empty(unlist(data)))
      } else {
        stri_remove_empty(unlist(data)) %>%
          str_replace_all(c("\n" = " ", "\r" = " ", "\t" = " ")) %>%
          str_trim()
      }
    },

    error = function(cond) {
      if (!has_internet()) {
        message(paste0("Please check your internet connexion: ", cond))

        return(NA)
      } else if (grepl("current working directory", cond) || grepl("HTTP error 404", cond)) {
        message(paste0("The URL doesn't seem to be a valid one: ", link))

        message(paste0("Here the original error message: ", cond))

        return(NA)
      } else {
        message(paste0("Undefined Error: ", cond))

        return(NA)
      }
    }
  )
}
