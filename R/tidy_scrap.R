# scraping a tidy data frame from a website

#' Website Tidy scraping
#'
#' @description This function is used to scrape a tibble from a website.
#'
#' @param link the link of the web page to scrape
#' @param nodes the vector of HTML or CSS elements to consider, the SelectorGadget tool is highly recommended.
#' @param colnames the names of the expected columns.
#' @param clean logical. Should the function clean the extracted tibble or not ? Default is FALSE.
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#' @return a tidy data frame.
#' @examples \donttest{
#' # Extracting imdb movie titles and rating
#'
#' link     <- "https://www.imdb.com/chart/top/"
#' my_nodes <- c(".titleColumn a", "strong")
#' names    <- c("title", "rating")
#'
#' tidy_scrap(link, my_nodes, names)}
#'
#' @export
#' @importFrom rvest html_nodes html_text %>%
#' @importFrom xml2 read_html
#' @importFrom tidyr as_tibble
#' @importFrom stringr str_replace
#' @importFrom stringr str_trim
#' @importFrom dplyr mutate_all
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed
#' @importFrom curl has_internet


tidy_scrap <- function(link,
                       nodes,
                       colnames,
                       clean = FALSE,
                       askRobot = FALSE) {


  if(missing(link) ||
     missing(nodes)|| missing(colnames)) {

    stop("'link', 'nodes' and 'colnames' parameters are mandatory")

  }

  if(!is.character(link) ||
     !is.character(nodes)||
     !is.character(colnames)) {

    stop("'link', 'nodes' and 'colnames' parameters must be
         provided as strings")

  }


  if (length(nodes) != length(colnames)) {

    stop("nodes and colnames lengths do not match")

  }
######################### Ask Robot part #####################################################

    if (askRobot) {
      if (paths_allowed(link) == TRUE) {
        message(green("the robot.txt doesn't prohibit scraping this web page"))

      } else {
        message(bgRed(
          "WARNING: the robot.txt doesn't allow scraping this web page"
        ))

      }
    }

###############################################################################################


tryCatch(

expr = {

allframes <- lapply(nodes, function(x) scrap(link, x))

result <- do.call(cbind, allframes)

colnames(result) <- colnames

result <- as_tibble(result)


if (!clean){

  return(result)

} else {

result %>%
        mutate_all(~ str_replace_all(., c("\n" = " ", "\r" = " ", "\t" = " "))) %>%
        mutate_all(str_trim)

}

},

error = function(cond){

      if(!has_internet()){

        message(paste0("Please check your internet connexion: ", cond))

        return(NA)

      } else if (grepl("current working directory", cond) || grepl("HTTP error 404", cond)) {

          message(paste0("The URL doesn't seem to be a valid one: ", link))

          message(paste0("Here the original error message: ", cond))

          return(NA)

      } else {

        message(paste0("Undefined Error: ", cond))

        return(NA)
      }

      }
) # tryCatch end

  }
