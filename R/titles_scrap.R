# scraping titles from a website

#' Website title scraping
#'
#' @description This function is used to scrape titles (h1, h2 & h3 html tags) from a website. Useful for scraping daily electronic newspapers' titles.
#'
#' @param link the link of the web page to scrape
#' @param contain filter the titles according to a character string provided.
#' @param case_sensitive logical. Should the contain argument be case sensitive ? defaults to FALSE
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE
#' @return a character vector
#' @examples \donttest{
#' # Extracting the current titles of the New York Times
#'
#' link     <- "https://www.nytimes.com/"
#'
#' titles_scrap(link)}
#'
#' @export
#' @importFrom rvest html_nodes html_text html_attr
#' @importFrom xml2 read_html
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed
#' @importFrom magrittr %>%
#' @importFrom curl has_internet


titles_scrap <- function(link,
                         contain = NULL,
                         case_sensitive = FALSE,
                         askRobot = FALSE) {


###################### Ask Robot part ######################################################

  if (askRobot) {
    if (paths_allowed(link) == TRUE) {
      message(green("the robot.txt doesn't prohibit scraping this web page"))

    } else {
      message(bgRed(
        "WARNING: the robot.txt doesn't allow scraping this web page"
      ))

    }
  }
###########################################################################################

tryCatch(

expr = {

alltitles <- lapply(c("h1", "h2", "h3"), function(x) scrap(link, x))

data <- do.call(c, alltitles)

if (is.null(contain)) {
    
    return(data)

  } else {

    data[grepl(contain, data, ignore.case = !case_sensitive)]

  }

}, 

error = function(cond){

if(!has_internet()){

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
