# scraping web links from a website

#' Website web links scraping
#'
#' @description This function is used to scrape web links from a website.
#'
#' @param link the link of the web page to scrape
#' @param contain filter the web links according to the character string provided.
#' @param case_sensitive logical. Should the contain argument be case sensitive ? defaults to FALSE
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#' @return a character vector.
#' @examples \donttest{
#' # Extracting the web links within the World Bank research and publications page
#'
#' link     <- "https://www.worldbank.org/en/research"
#'
#' weblink_scrap(link)}
#'
#' @export
#' @importFrom rvest html_nodes html_text html_attr %>%
#' @importFrom xml2 read_html
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed
#' @importFrom curl has_internet



weblink_scrap <- function(link,
                          contain = NULL,
                          case_sensitive = FALSE,
                          askRobot = FALSE) {

  if (missing(link)) {

    stop("'link' is a mandatory argument")

  }

  if (!is.null(contain) && !is.character(contain)) {

    stop("the 'contain' argument must be provided as a character string")

  }

  ################################### Ask Robot Part #################################################

  if (askRobot) {
    if (paths_allowed(link) == TRUE) {
      message(green("the robot.txt doesn't prohibit scraping this web page"))

    } else {
      message(bgRed(
        "WARNING: the robot.txt doesn't allow scraping this web page"
      ))

    }
  }
  ########################################################################################################

  tryCatch(

  expr = {

    links <- link %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href")

    if (is.null(contain)) {
      return(links)

    } else {
      links[grepl(contain,
                  links,
                  ignore.case = !case_sensitive)]
    }

  },

  error = function(cond) {

    if (!has_internet()) {

      message("Please check your internet connexion: ")
      message(cond)
      return(NA)

    } else if (grepl("current working directory", cond) ||
               grepl("HTTP error 404", cond)) {

      message(paste0("The URL doesn't seem to be a valid one: ", link))
      message(paste0("Here the original error message: ", cond))
      return(NA)

    } else {

      message("Undefined Error: ", cond)
      return(NA)
    }
  }

  )
}
