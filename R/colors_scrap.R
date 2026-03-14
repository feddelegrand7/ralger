#' Scrape Color Codes from a Web Page
#'
#' @description This function is used to extract all color codes present within
#'   a given website. It searches inline \code{style} attributes and
#'   \code{<style>} tags for color values in \code{#Hex}, \code{rgb()},
#'   \code{rgba()}, \code{hsl()}, and \code{hsla()} formats.
#'
#' @param link the link of the web page to scrape
#' @param askRobot logical. Should the function ask the robots.txt if we're
#'   allowed or not to scrape the web page? Default is \code{FALSE}.
#'
#' @return a character vector of unique color codes found on the page, or
#'   \code{NULL} if none are found.
#'
#' @examples \dontrun{
#'
#' colors_scrap(link = "https://www.r-project.org/")
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

  tryCatch(

    expr = {

      all_colors <- lapply(link, function(url) {

        page <- url %>% read_html()

        # 1. Collect inline style attribute values
        inline_styles <- page %>%
          html_nodes("[style]") %>%
          html_attr("style")

        # 2. Collect <style> tag contents
        style_tags <- page %>%
          html_nodes("style") %>%
          html_text()

        css_text <- paste(c(inline_styles, style_tags), collapse = " ")

        # Regex patterns for color formats
        hex_pattern  <- "#(?:[0-9a-fA-F]{3,4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})\\b"
        rgb_pattern  <- "rgba?\\(\\s*[\\d.]+\\s*,\\s*[\\d.]+\\s*,\\s*[\\d.]+(?:\\s*,\\s*[\\d.]+)?\\s*\\)"
        hsl_pattern  <- "hsla?\\(\\s*[\\d.]+\\s*,\\s*[\\d.]+%\\s*,\\s*[\\d.]+%(?:\\s*,\\s*[\\d.]+)?\\s*\\)"

        hex_colors <- regmatches(css_text, gregexpr(hex_pattern, css_text, perl = TRUE))[[1]]
        rgb_colors <- regmatches(css_text, gregexpr(rgb_pattern, css_text, perl = TRUE))[[1]]
        hsl_colors <- regmatches(css_text, gregexpr(hsl_pattern, css_text, perl = TRUE))[[1]]

        unique(c(hex_colors, rgb_colors, hsl_colors))

      })

      colors <- unique(unlist(all_colors))
      colors <- colors[!is.na(colors) & nchar(colors) > 0]

      if (length(colors) == 0) {
        message("No color has been found. Returning NULL.")
        return(invisible(NULL))
      }

      return(colors)

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
