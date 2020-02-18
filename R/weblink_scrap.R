# scraping web links from a website

#' Website web links scraping
#'
#' @description This function is used to scrap web links from a website.
#'
#' @param link the link of the webpage to scrap
#' @param contain filter the web links according the character string provided. Particulary useful when extracting PDF or xlsx links (works also with regex)
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrap the web page ? Default is FALSE.
#' @return a character vector.
#' @examples \donttest{
#' # Extracting the web links within the World Bank research and publications page
#'
#' link     <- "https://www.worldbank.org/en/research"
#'
#' weblink_scrap(link)}
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_text html_attr
#' @importFrom xml2 read_html
#' @importFrom stringr str_subset
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed



weblink_scrap <- function(link, contain = NULL, askRobot = FALSE){


  if(askRobot){

    if(paths_allowed(link) == TRUE){

      message(green("It's ok you're allowed to scrap this web page"))

    } else {

      message(bgRed("WARNING: you're not allowed to scrap this web page"))

    }

    }



    if(is.null(contain)){

      link %>%
        read_html() %>%
        html_nodes("a") %>%
        html_attr("href")

    } else {

      link %>%
        read_html() %>%
        html_nodes("a") %>%
        html_attr("href") %>%
        str_subset(contain)


    }


  }







