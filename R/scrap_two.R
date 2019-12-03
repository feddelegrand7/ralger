# extracting a 2 columns dataframe

#' function to build a two columns dataframe through scraping
#'
#' @param link the link of the webpage to scrap
#' @param nodes the CSS elements to consider, the SelectorGadget tool is highly recommanded
#' @return
#' @export
#'


scrap_df <- function(link, nodes){


  var1 <- scrap_this(link, nodes[1])
  var2 <- scrap_this(link, nodes[2])

  df <- data.frame(var1, var2, stringsAsFactors = F)

  return(df)


}




