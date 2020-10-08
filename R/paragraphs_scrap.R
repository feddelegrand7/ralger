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
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_text html_attr
#' @importFrom xml2 read_html
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom robotstxt paths_allowed



paragraphs_scrap <- function(link,
                             contain = NULL,
                             case_sensitive = FALSE,
                             collapse = FALSE,
                             askRobot = FALSE){


  if(askRobot){

    if(paths_allowed(link) == TRUE){

      message(green("It's ok you're allowed to scrap this web page"))

    } else {

      message(bgRed("WARNING: you're not allowed to scrap this web page"))

    }

  }


  data <- link %>%
    read_html() %>%
    html_nodes("p") %>%
    html_text()


  if(is.null(contain) & collapse == F){


    return(data)


  } else if (is.null(contain) & collapse == T){


    return(paste(data, collapse = " "))



  } else if (!is.null(contain) & collapse == F){


    return(data[grepl(contain, data, ignore.case = !case_sensitive)])



  } else {

    message("if you decide to collapse the paragraphs, the contain argument will be ignored")


      return(paste(data, collapse = " "))



  }




  }







