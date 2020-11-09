#' Scrape Images from a Web Page
#'
#' @param link the link of the web page
#' @param imgpath the path of the images. Defaults to the current directory
#' @param extn the extension of the image: png, jpeg ... 
#' @param askRobot logical. Should the function ask the robots.txt if we're allowed or not to scrape the web page ? Default is FALSE.
#' 
#' @return Images 
#' 
#' @examples \donttest{
#' 
#' images_scrap(link = "https://rstudio.com/", extn = "png")
#' 
#' }
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom rvest html_nodes html_attr
#' @importFrom xml2 read_html
#' @importFrom stringr str_replace_all str_trim
#' @importFrom robotstxt paths_allowed
#' @importFrom crayon green
#' @importFrom crayon bgRed
#' @importFrom curl has_internet
#' @importFrom utils download.file


images_scrap <- function(link, imgpath = getwd(), extn, askRobot = FALSE) {

  if(missing(extn)){

    stop("You need to provide the extension of the required images: png, jpeg, ...")

  }

  if(imgpath != getwd() & !dir.exists(imgpath)){

    stop("the path ", imgpath, " doesn't seem to exist !")
  
  }

  if(grepl(x = extn, pattern = "\\.")){

    stop("No need to include the '.' in `extn`, just provide the extension as it is")

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
        read_html()  %>% 
        html_nodes("img") %>%
        html_attr("src")
    })  %>% unlist()

  img_urls_f <- img_urls[grepl(pattern = paste0(".", extn), x = img_urls, ignore.case = FALSE)] 
      
  for(i in seq_along(img_urls_f)){
  
  download.file(img_urls_f[i], destfile = paste0(imgpath,"/img-", i, "." , extn), mode = "wb")

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
