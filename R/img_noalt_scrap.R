#' Scrape Images URLS that don't have 'alt' attributes
#'
#' @param link the URL of the web page
#' @param askRobot
#'
#' @return
#' @export
#'
#' @examples
#' @importFrom rvest html_nodes html_attr %>%
#' @importFrom xml2 read_html
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom curl has_internet
#' @importFrom utils download.file

img_noalt_scrap <- function(link, askRobot = FALSE) {

  if (missing(link)) {

    stop("the 'link' paramater is mandatory")

  }

  if (!is.character(link)) {

    stop("the 'link' parameter must be provided
         as a character string")

  }

  ####### Ask robot related ################################################################
  if (askRobot) {
    if (paths_allowed(link) == TRUE) {
      message(green("the robot.txt doesn't prohibit scraping this web page"))
    }
    else {
      message(bgRed(
        "WARNING: the robot.txt doesn't allow scraping this web page"
      ))
    }
  }
  ##########################################################################################
  tryCatch(
    expr = {
      img_urls <- lapply(link, function(url) {
        url %>%
          read_html() %>%
          html_nodes("img:not([alt])")
      })
      return(img_urls[[1]])
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
