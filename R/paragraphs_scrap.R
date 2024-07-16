# scraping paragraphs from a website

#' Website text paragraph scraping
#'
#' @description This function is used to scrape text paragraphs from a website.
#'
#' @param link the link of the web page to scrape
#' @param contain filter the paragraphs according to the character string provided.
#' @param case_sensitive logical. Should the contain argument be case sensitive ? defaults to FALSE
#' @param collapse if TRUE the paragraphs will be collapsed into one element and the contain argument ignored.
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrap the web page ? Default is FALSE.
#' @return a character vector.
#' @examples \donttest{
#' # Extracting the paragraphs displayed on the health page of the New York Times
#'
#' link     <- "https://www.nytimes.com/section/health"
#'
#' paragraphs_scrap(link)}
#'
#' @export
#' @importFrom rvest html_nodes html_text html_attr %>%
#' @importFrom xml2 read_html
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed
#' @importFrom curl has_internet



paragraphs_scrap <- function(link,
                             contain = NULL,
                             case_sensitive = FALSE,
                             collapse = FALSE,
                             askRobot = FALSE) {


  if (missing(link)) {
    stop("'link' is a mandatory parameter")
  }

  if (!is.character(contain) && !is.null(contain)) {

    stop("the 'contain' parameter must be passed a character string")


  }


  ##################### Ask Robot part ###############################################
  if (askRobot) {
    if (paths_allowed(link) == TRUE) {
      message(green("the robot.txt doesn't prohibit scraping this web page"))

    } else {
      message(bgRed(
        "WARNING: the robot.txt doesn't allow scraping this web page"
      ))

    }

  }

  ####################################################################################


  tryCatch(

  expr = {

    data <- link %>%
    read_html() %>%
    html_nodes("p") %>%
    html_text()

    if (is.null(contain) & collapse == FALSE) {
      return(data)

    } else if (is.null(contain) & collapse == TRUE) {
      return(paste(data, collapse = " "))

    } else if (!is.null(contain) & collapse == FALSE) {

      return(data[grepl(contain,
                        data,
                        ignore.case = !case_sensitive)])
    } else {
      message("if you decide to collapse the paragraphs,
      the contain argument will be ignored")
      return(paste(data, collapse = " "))
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

      message(paste0("Undefined Error: ", cond))

      return(NA)

    }
  }

  )

}
