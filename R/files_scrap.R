
.get_base_from_full_url <- function(url) {

  scheme <- urltools::scheme(url)
  domain <- urltools::domain(url)

  base_url <- paste0(scheme, "://", domain)
  base_url
}

.format_url <- function(file_url, link) {

  if (grepl("^http", file_url)) {
    return(file_url)
  } else {
    base_url <- .get_base_from_full_url(link)
    file_url <- paste0(base_url, "/", file_url)
    return(file_url)
  }
}

.scrap_specific_file <- function(
  link,
  path,
  ext,
  askRobot
) {

  if (path != getwd() && !dir.exists(path)) {
    stop("the path: ", path, " doesn't seem to exist !")
  }

  if (askRobot) {

    if (paths_allowed(link) == TRUE) {
      message(green("the robot.txt doesn't prohibit scraping this web page"))

    } else {
      message(bgRed(
        "WARNING: the robot.txt doesn't allow scraping this web page"
      ))

    }
  }

  urls_containing_files <- weblink_scrap(
    link,
    contain = ext
  )

  files_to_consider <- urls_containing_files %>%
    purrr::keep(function(x) {
      tolower(tools::file_ext(x)) == ext
    })

  if (length(files_to_consider) == 0) {
    message("No file has been found. Returning NULL.")
    return(invisible(NULL))
  }


  files_to_consider <- purrr::map_chr(
    files_to_consider,
    .format_url,
    link = link
  )

  for (i in seq_along(files_to_consider)) {

    tryCatch(
      expr = {
        download.file(files_to_consider[i],
          destfile = paste0(path, "/", basename(files_to_consider[i])),
          mode = "wb"
        )

      },

      error = function(cond) {

        if (!has_internet()) {

          message(paste0("Please check your internet connexion: ", cond))

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

}


#' Scrape and download pdf files from a Web Page
#'
#' @param link the link of the web page
#' @param path the path where to save the PDF files. Defaults to the current directory
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#'
#' @return called for the side effect of downloading PDF files from a website
#' @export
#'

pdf_scrap <- function(
  link,
  path = getwd(),
  askRobot = FALSE
) {

  .scrap_specific_file(
    link = link,
    path = path,
    ext = "pdf",
    askRobot = askRobot
  )

}

#' Scrape and download Excel xlsx files from a Web Page
#'
#' @param link the link of the web page
#' @param path the path where to save the Excel xlsx files. Defaults to the current directory
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#'
#' @return called for the side effect of downloading Excel xlsx files from a website
#' @export
#' @examples \dontrun{
#'
#' xlsx_scrap(
#' link = "https://www.rieter.com/investor-relations/results-and-presentations/financial-statements"
#' )
#'
#' }

xlsx_scrap <- function(
    link,
    path = getwd(),
    askRobot = FALSE
) {

  .scrap_specific_file(
    link = link,
    path = path,
    ext = "xlsx",
    askRobot = askRobot
  )

}

#' Scrape and download Excel xls files from a Web Page
#'
#' @param link the link of the web page
#' @param path the path where to save the Excel xls files. Defaults to the current directory
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#'
#' @return called for the side effect of downloading Excel xls files from a website
#' @export
#'

xls_scrap <- function(
    link,
    path = getwd(),
    askRobot = FALSE
) {

  .scrap_specific_file(
    link = link,
    path = path,
    ext = "xls",
    askRobot = askRobot
  )

}


#' Scrape and download CSV files from a Web Page
#'
#' @param link the link of the web page
#' @param path the path where to save the CSV files. Defaults to the current directory
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#'
#' @return called for the side effect of downloading CSV files from a website
#' @export
#'

csv_scrap <- function(
    link,
    path = getwd(),
    askRobot = FALSE
) {

  .scrap_specific_file(
    link = link,
    path = path,
    ext = "csv",
    askRobot = askRobot
  )

}
