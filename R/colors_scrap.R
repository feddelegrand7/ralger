
#' Scrape Color Codes from a Web Page
#'
#' @description This function scrapes all color codes present within a given
#'   website. It searches inline \code{style} attributes, \code{<style>} tags,
#'   and linked external CSS stylesheets for color values in the following
#'   formats: hexadecimal (\code{#RGB}, \code{#RRGGBB}, \code{#RRGGBBAA}),
#'   \code{rgb()}, \code{rgba()}, \code{hsl()}, and \code{hsla()}.
#'
#' @param link the link of the web page to scrape. Can be a character vector
#'   of multiple URLs.
#' @param askRobot logical. Should the function ask the robots.txt if we're
#'   allowed or not to scrape the web page? Default is \code{FALSE}.
#'
#' @return a character vector of unique color codes found on the page, or
#'   \code{invisible(NULL)} if none are found, or \code{NA} on error.
#'
#' @examples
#' \donttest{
#'
#' colors_scrap(link = "https://ropensci.org/")
#'
#' }
#'
#' @export
#' @importFrom rvest html_nodes html_attr html_text %>%
#' @importFrom xml2 read_html
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom curl has_internet


colors_scrap <- function(link, askRobot = FALSE) {

  if (missing(link)) {
    stop("'link' is a mandatory parameter")
  }

  if (!is.character(link)) {
    stop("'link' must be provided as a character string")
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

  # Regex pattern matching hex, rgb/rgba, hsl/hsla color values
  color_pattern <- paste0(
    "#[0-9A-Fa-f]{8}\\b|",           # #RRGGBBAA (8 hex digits)
    "#[0-9A-Fa-f]{6}\\b|",           # #RRGGBB   (6 hex digits)
    "#[0-9A-Fa-f]{4}\\b|",           # #RGBA     (4 hex digits)
    "#[0-9A-Fa-f]{3}\\b|",           # #RGB      (3 hex digits)
    "rgba?\\([^)]+\\)|",             # rgb() / rgba()
    "hsla?\\([^)]+\\)"               # hsl() / hsla()
  )

  tryCatch(
    expr = {

      all_css_text <- character(0)

      for (url in link) {

        page <- url %>% read_html()

        # 1. Inline style attributes from all elements
        inline_styles <- page %>%
          html_nodes("[style]") %>%
          html_attr("style")

        all_css_text <- c(all_css_text, inline_styles[!is.na(inline_styles)])

        # 2. Content of <style> tags
        style_tag_content <- page %>%
          html_nodes("style") %>%
          html_text()

        all_css_text <- c(all_css_text, style_tag_content)

        # 3. External stylesheets referenced via <link rel="stylesheet">
        css_links <- page %>%
          html_nodes("link[rel='stylesheet']") %>%
          html_attr("href")

        css_links <- css_links[!is.na(css_links)]

        for (css_href in css_links) {
          # Resolve relative URLs
          if (!grepl("^https?://", css_href)) {
            base_url <- .get_base_from_full_url(url)
            # Handle root-relative vs relative paths
            if (startsWith(css_href, "/")) {
              css_href <- paste0(base_url, css_href)
            } else {
              css_href <- paste0(base_url, "/", css_href)
            }
          }

          css_content <- tryCatch(
            readLines(css_href, warn = FALSE),
            error = function(e) character(0)
          )

          if (length(css_content) > 0) {
            all_css_text <- c(all_css_text, paste(css_content, collapse = "\n"))
          }
        }
      }

      if (length(all_css_text) == 0) {
        message("No color has been found. Returning NULL.")
        return(invisible(NULL))
      }

      combined_text <- paste(all_css_text, collapse = "\n")

      colors_found <- regmatches(
        combined_text,
        gregexpr(color_pattern, combined_text, perl = TRUE)
      )[[1]]

      colors_found <- unique(colors_found)

      if (length(colors_found) == 0) {
        message("No color has been found. Returning NULL.")
        return(invisible(NULL))
      }

      return(colors_found)

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
