#' Scrape PDF documents from a Web Page
#'
#' @param link the link of the web page
#' @param pdfpath the path of the PDF files. Defaults to the current directory
#' @param pdfname how the PDF documents should be named. Defaults to "pdf" which will yield pdf-1, pdf-2 ... etc.
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#'
#' @return PDF documents
#'
#' @examples \donttest{
#'
#'  pdf_scrap(link = "https://www.worldbank.org/en/research",
#'            pdfname = "amazing_pdf",
#'            pdfpath = getwd())
#' }
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_attr
#' @importFrom xml2 read_html
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom curl has_internet
#' @importFrom utils download.file


pdf_scrap <- function(link,
                      pdfname = "pdf",
                      pdfpath = getwd(),
                      askRobot = FALSE) {



  if (pdfpath != getwd() & !dir.exists(pdfpath)) {

    stop("the path ", pdfpath, " doesn't seem to exist !")

  }


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
  ##########################################################################################

  tryCatch(

  expr = {

    pdf_urls <- ralger::weblink_scrap(link,
                                      contain = ".pdf",
                                      case_sensitive = FALSE)

    for (i in seq_along(pdf_urls)) {

      download.file(pdf_urls[i],
                    destfile = paste0(pdfpath, "/", pdfname, "-", i, ".pdf"),
                    mode = "wb")

    }


  },

  error = function(cond) {

    if (!has_internet()) {

      message("Please check your internet connexion: ")

      message(cond)

      return(NA)

    } else if (grepl("current working directory", cond) || grepl("HTTP error 404", cond)) {

      message(paste0("The URL doesn't seem to be a valid one: ", link))

      message("Here the original error message: ")

      message(cond)

      return(NA)
    }
  }

  )

}
