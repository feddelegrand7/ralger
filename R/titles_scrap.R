# scraping titles from a website

#' Website title scraping
#'
#' @description This function is used to scrape titles from a website. Useful for scraping daily electronic newspapers' titles.
#'
#' @param link the link of the web page to scrape
#' @param contain filter the titles according to the character string provided.
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
#' @importFrom stringr str_subset
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed
#' @importFrom magrittr %>%




titles_scrap <- function(link, contain = NULL, askRobot = FALSE){


  if(askRobot){

    if(paths_allowed(link) == TRUE){

      message(green("It's ok you're allowed to scrap this web page"))

    } else {

      message(bgRed("WARNING: you're not allowed to scrap this web page"))

    }

  }



  if(is.null(contain)){

    h1 <- link %>%
      read_html() %>%
      html_nodes("h1") %>%
      html_text()

    h2 <- link %>%
      read_html() %>%
      html_nodes("h2") %>%
      html_text()

    data <- c(h1, h2)

    return(data)


  } else {

    h1 <- link %>%
      read_html() %>%
      html_nodes("h1") %>%
      html_text()

    h2 <- link %>%
      read_html() %>%
      html_nodes("h2") %>%
      html_text()


    data <- c(h1, h2) %>%
      str_subset(contain)


    return(data)


  }


}







