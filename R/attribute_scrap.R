

# scraping attributes from HTML elements

#' Scraping attributes from HTML elements
#'
#' @description This function is used to scrape attributes from HTML elements
#'
#' @param link the link of the web page to scrape
#' @param node the HTML element to consider
#' @param attr the attribute to scrape
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#' @return a character vector.
#' @examples
#' \donttest{
#' # Extracting the web links within the World Bank research and publications page
#'
#' link <- "https://ropensci.org/"
#'
#' # scraping the class attributes' names from all the anchor
#'
#' attribute_scrap(link = link, node = "a", attr = "class")
#' }
#'
#' @export
#' @importFrom rvest html_nodes html_text html_attr %>%
#' @importFrom xml2 read_html
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed
#' @importFrom curl has_internet



attribute_scrap <- function(link,
                            node,
                            attr,
                            askRobot = FALSE) {
  if (any(missing(link), missing(node), missing(attr))) {
    stop("'link', 'node' and 'attr' are a mandatory argument")
  }


  if (any(!is.character(link), !is.character(node), !is.character(attr))) {
    stop("'link', 'node' and 'attr' must be provided as character vectors")
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
      links <- lapply(
        link,
        function(url) {
          url %>%
            read_html() %>%
            html_nodes(node) %>%
            html_attr(attr)
        }
      )

      return(unlist(links))
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
