#' Scrape Images from a Web Page
#'
#' @param link the link of the web page
#' @param imgpath the path of the images. Defaults to the current directory
#' @param extn the extension of the image: png, jpeg ...
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#'
#' @return called for the side effect of downloading images
#'
#' @examples \dontrun{
#'
#' images_scrap(link = "https://posit.co/", extn = "jpg")
#'
#' }
#'
#' @export
#' @importFrom rvest html_nodes html_attr %>%
#' @importFrom xml2 read_html
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom curl has_internet
#' @importFrom utils download.file


images_scrap <- function(link,
                        imgpath = getwd(),
                        extn,
                        askRobot = FALSE) {

  if (missing(link)) {

    stop("'link' is a mandatory parameter")

  }

  if (missing(extn)) {

    stop("You need to provide the extension of the required images:
    jpg, png, jpeg, ...")

  }

  if (!is.character(link)   ||
      !is.character(imgpath)||
      !is.character(extn)) {

    stop("'link', 'imgpath' and 'extn' parameters must
         be provided as character strings")

  }

  if (imgpath != getwd() && !dir.exists(imgpath)) {

    stop("the path: ", imgpath, " doesn't seem to exist !")

  }

  if (grepl(x = extn, pattern = "\\.")) {

    stop("No need to include the '.' in 'extn',
    just provide the extension as it is")

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

    img_urls <- lapply(link, function(url) {

      url %>%
        read_html() %>%
        html_nodes("img") %>%
        html_attr("src")
    })

    img_urls_unlist <- img_urls %>% unlist()

    img_urls_f <- img_urls_unlist[grepl(pattern = paste0(".", extn),
                                  x = img_urls_unlist,
                                  ignore.case = FALSE)]

    if (length(img_urls_f) == 0) {
      message("No image has been found. Returning NULL")
      return(invisible(NULL))
    }

    img_urls_f <- purrr::map_chr(
      img_urls_f,
      .format_url,
      link = link
    )

    for (i in seq_along(img_urls_f)) {

      download.file(img_urls_f[i],
                    destfile = paste0(imgpath, "/", basename(img_urls_f[i])),
                    mode = "wb")

    }


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
