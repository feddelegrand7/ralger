#' Scrape Audio Files from a Web Page
#'
#' @description This function is used to scrape audio file URLs from a web page
#'   and optionally download them. It searches both \code{<audio>} tags and
#'   \code{<a>} (anchor) tags for links matching the specified audio extensions.
#'
#' @param link the link of the web page to scrape
#' @param extensions a character vector of audio file extensions to filter by
#'   (without the leading dot). Defaults to \code{c("mp3", "wav")}.
#' @param path the path where audio files will be downloaded. Defaults to the
#'   current working directory. Set to \code{NULL} to return URLs without
#'   downloading.
#' @param askRobot logical. Should the function ask the robots.txt if we're
#'   allowed or not to scrape the web page? Default is \code{FALSE}.
#'
#' @return called for the side effect of downloading audio files. Returns the
#'   vector of matched audio URLs invisibly, or \code{NULL} if none are found.
#'
#' @examples \dontrun{
#'
#' # Scrape and download mp3 and wav files from a page
#' audio_scrap(
#'   link = "https://www.example.com/podcasts",
#'   extensions = c("mp3", "wav"),
#'   path = getwd()
#' )
#'
#' # Return audio URLs without downloading
#' audio_scrap(
#'   link = "https://www.example.com/podcasts",
#'   extensions = "mp3",
#'   path = NULL
#' )
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

audio_scrap <- function(link,
                        extensions = c("mp3", "wav"),
                        path = getwd(),
                        askRobot = FALSE) {

  if (missing(link)) {
    stop("'link' is a mandatory parameter")
  }

  if (!is.character(link)) {
    stop("'link' must be provided as a character string")
  }

  if (!is.character(extensions) || length(extensions) == 0) {
    stop("'extensions' must be a non-empty character vector, e.g. c(\"mp3\", \"wav\")")
  }

  if (any(grepl("^\\.", extensions))) {
    stop("No need to include the '.' in 'extensions', just provide the extension as it is (e.g. \"mp3\" not \".mp3\")")
  }

  if (!is.null(path) && path != getwd() && !dir.exists(path)) {
    stop("the path: ", path, " doesn't seem to exist !")
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

      # Collect candidate URLs from <audio src=>, <source src=> inside <audio>,
      # and <a href=> anchor links
      raw_urls <- lapply(link, function(url) {
        page <- url %>% read_html()

        audio_src <- page %>%
          html_nodes("audio") %>%
          html_attr("src")

        source_src <- page %>%
          html_nodes("audio source") %>%
          html_attr("src")

        anchor_href <- page %>%
          html_nodes("a") %>%
          html_attr("href")

        c(audio_src, source_src, anchor_href)
      })

      all_urls <- unlist(raw_urls)
      all_urls <- all_urls[!is.na(all_urls)]

      # Filter to only URLs whose file extension matches one of the requested extensions
      ext_pattern <- paste0("\\.(", paste(extensions, collapse = "|"), ")$")
      matched_urls <- all_urls[grepl(ext_pattern, all_urls, ignore.case = TRUE)]

      if (length(matched_urls) == 0) {
        message("No audio file has been found. Returning NULL.")
        return(invisible(NULL))
      }

      # Resolve relative URLs to absolute
      matched_urls <- purrr::map_chr(
        matched_urls,
        .format_url,
        link = link[[1]]
      )

      # Remove duplicates
      matched_urls <- unique(matched_urls)

      if (is.null(path)) {
        return(invisible(matched_urls))
      }

      for (i in seq_along(matched_urls)) {
        download.file(
          matched_urls[i],
          destfile = paste0(path, "/", basename(matched_urls[i])),
          mode = "wb"
        )
      }

      return(invisible(matched_urls))

    },

    error = function(cond) {

      if (!has_internet()) {
        message(paste0("Please check your internet connexion: ", cond))
        return(invisible(NULL))
      } else if (grepl("current working directory", cond) ||
                 grepl("HTTP error 404", cond)) {
        message(paste0("The URL doesn't seem to be a valid one: ", link))
        message(paste0("Here the original error message: ", cond))
        return(invisible(NULL))
      } else {
        message(paste0("Undefined Error: ", cond))
        return(invisible(NULL))
      }

    }
  )
}
