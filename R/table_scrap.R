# scraping an HTML tablefrom a website

#' HTML table scraping
#'
#' @description This function is used to scrap an html table from a website.
#'
#' @param link the link of the webpage containing the table to scrap
#' @param choose an integer indicating which table to scrap
#' @param header do you want the first line to be the leader (default to TRUE)
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrap the web page ? Default is FALSE.
#' @return a dataframe object.
#' @examples \donttest{
#' # Extracting premier ligue 2019/2020 top scorers
#'
#' link     <- "https://www.topscorersfootball.com/premier-league"
#' table_scrap(link)}
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom xml2 read_html
#' @importFrom rvest html_table
#' @importFrom purrr pluck
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed



table_scrap <- function(link, choose = 1, header = T, askRobot = FALSE){


  if(askRobot){

    if(paths_allowed(link) == TRUE){

      message(green("It's ok you're allowed to scrap this web page"))

    } else {

      message(bgRed("WARNING: you're not allowed to scrap this web page"))

    }


  }

  table <- link %>%
    read_html() %>%
    html_table(header) %>%
    purrr::pluck(choose)

  return(table)


  }



