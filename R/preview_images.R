#' Scrape Images URLs
#'
#' @param link the link of the web page
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#'
#' @return Images URLs
#'
#' @examples \donttest{
#'
#' images_preview(link = "https://rstudio.com/")
#'
#' }
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_attr
#' @importFrom xml2 read_html
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom curl has_internet
#' @importFrom utils download.file


images_preview <- function(link, askRobot = FALSE) {


    ###############
      ####### Ask robot related ##################################################
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
        html_nodes("img") %>%
        html_attr("src")
        })

        return(img_urls %>% unlist())


  },

  error = function(cond) {

    if (!has_internet()) {

      message("Please check your internet connexion: ")

      message(cond)

      return(NA)

    } else if (grepl("current working directory", cond) || grepl("HTTP error 404", cond)) {

      message(paste0("The URL doesn't seem to be a valid one: ", link))

      message("Here the original error message: ")

      message(cond)

      return(NA)
    }
  }

  )
    }
