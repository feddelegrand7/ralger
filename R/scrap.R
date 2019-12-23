# scraping a website

#' Simple website scraping
#'
#' @description This function is used to scrap one element from a website.
#'
#' @param link the link of the webpage to scrap
#' @param node the CSS element to consider, the SelectorGadget tool is highly recommended
#' @param clean logical. Should the function clean the extracted vector or not ? Default is FALSE.
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrap the web page ? Default is FALSE.
#' @return a character vector
#' @examples \donttest{
#' # Extracting imdb top 250 movie titles
#'
#' link <- "https://www.imdb.com/chart/top/"
#' node <- ".titleColumn a"
#'
#' scrap(link, node)}
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_text
#' @importFrom xml2 read_html
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_trim
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed

scrap <- function(link, node, clean = FALSE, askRobot = FALSE){


  if(askRobot){

    if(paths_allowed(link) == TRUE){

      message(green("It's ok you're allowed to scrap this web page"))

    } else {

      message(bgRed("WARNING: you're not allowed to scrap this web page"))

    }


  }






  data <- lapply(link,
    function(url){
      url %>% read_html() %>%
        html_nodes(node) %>%
        html_text()
    })

  if (!clean) return({unlist(data)})

  if (clean){

    data_clean <- unlist(data) %>%
      str_replace_all(c("\n" = " ","\r" = " ")) %>%
      str_trim()
    return(data_clean)

  }




}



