
.scrap_specific_file <- function(
  ext,
  link,
  path
) {

  urls_containing_files <- weblink_scrap(
    link,
    contain = ext
  )

  files_to_consider <- urls_containing_files %>%
    purrr::keep(function(x) {
      tools::file_ext(x) == ext
    })

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
#' @param pdfpath the path where to save the PDF files. Defaults to the current directory
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#'
#' @return called for the side effect of downloading PDF files
#' @export
#'

pdfs_scrap <- function(
  link,
  pdfpath = getwd(),
  askRobot = FALSE
) {


  if (pdfpath != getwd() && !dir.exists(pdfpath)) {
    stop("the path: ", pdfpath, " doesn't seem to exist !")
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

  .scrap_specific_file(
    link = link,
    path = pdfpath,
    ext = "pdf"
  )

}
