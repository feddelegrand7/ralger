#' Scrape HTML comments from a web page
#'
#' @description Extracts HTML comments (<!-- comment -->) from a webpage. Useful for detecting hidden notes, debug info, or developer messages.
#'
#' @param link Character. The URL of the web page to scrape.
#' @param askRobot Logical. Should the function check robots.txt before scraping? Default is FALSE.
#' @return A character vector of HTML comments found on the page.
#'
#' @examples
#' \donttest{
#' link <- "https://example.com"
#' comments_scrap(link)
#' }
#'
#' @export
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes
#' @importFrom robotstxt paths_allowed
#' @importFrom curl has_internet
#' @importFrom crayon green bgRed
comments_scrap <- function(link, askRobot = FALSE) {

  ###################### Ask Robot part ######################################################

  if (askRobot) {
    if (paths_allowed(link)) {
      message(green("robots.txt allows scraping this web page"))
    } else {
      message(bgRed("WARNING: robots.txt prohibits scraping this web page"))
      return(NA)
    }
  }

  ############################################################################################

  tryCatch(
    expr = {
      if (!has_internet()) {
        stop("No internet connection.")
      }

      html_content <- read_html(link)

      raw_content <- as.character(html_content)

      comments <- regmatches(
        raw_content,
        gregexpr("<!--(.*?)-->", raw_content, perl = TRUE)
      )[[1]]

      comments <- trimws(comments)

      if (length(comments) == 0) {
        message("No HTML comments found.")
        return(NA)
      }

      return(comments)
    },
    error = function(cond) {
      message("Error while scraping comments: ", cond$message)
      return(NA)
    }
  )
}
