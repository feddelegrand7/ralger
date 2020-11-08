# scraping a website

#' Simple website scraping
#'
#' @description This function is used to scrape one element from a website.
#'
#' @param link the link of the web page to scrape
#' @param node the HTML or CSS element to consider, the SelectorGadget tool is highly recommended
#' @param clean logical. Should the function clean the extracted vector or not ? Default is FALSE.
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
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
#' @importFrom stringr str_replace_all str_trim 
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom curl has_internet

scrap <- function(link,
                  node,
                  clean = FALSE,
                  askRobot = FALSE) {

###################### Ask robot related ##################################################
  if (askRobot) {

    if (paths_allowed(link) == TRUE) {
      message(green("the robot.txt doesn't prohibit scraping this web page"))

    } else {
      message(bgRed(
        "WARNING: the robot.txt doesn't allow scraping this web page"
      ))

    }
  }

  #########################################################################################

    tryCatch(


      expr = {

        if(!clean){

        data <- lapply(link,
                 function(url) {
                   url %>% read_html() %>%
                     html_nodes(node) %>%
                     html_text()
                 })

        return(data)

        } else {
        
        data <- lapply(link,
                 function(url) {
                   url %>% read_html() %>%
                     html_nodes(node) %>%
                     html_text()
                 })


        data_clean <- unlist(data) %>%
        str_replace_all(c("\n" = " ", "\r" = " ", "\t" = " ")) %>%
        str_trim()
        return(data_clean)
          
        }

      }, 

    error = function(cond){

      if(!curl::has_internet()){

        message("Please check your internet connexion: ")

        message(cond)

        return(NA)

      } else if (grepl("current working directory", cond) || grepl("HTTP error 404", cond)) {

          message(paste0("The URL doesn't seem to be a valid one: ", link))

          message("Here the original error message: ")

          message(cond)

          return(NA)
      }})


}

