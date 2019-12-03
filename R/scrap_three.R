# extracting a 3 columns dataframe

#' function to build a three columns dataframe through scraping
#'
#' @param link the link of the webpage to scrap
#' @param nodes the CSS elements to consider, the SelectorGadget tool is highly recommanded
#' @return
#' @export
#'


scrap_df <- function(link, nodes){


  var1 <- scrap_this(link, nodes[1])
  var2 <- scrap_this(link, nodes[2])
  var3 <- scrap_this(link, nodes[3])


  df <- data.frame(var1, var2, var3, stringsAsFactors = F)

  return(df)


}
