pacman::p_load(usethis, roxygen2, devtools, available, rvest, magrittr)


# scraping one page

scrap_one <- function(link, node){

  data <- lapply(link,
    function(url){
      url %>% read_html() %>%
        html_nodes(node) %>%
        html_text()
    })

  return(unlist(data))
}

# scraping multiple pages

scrap_more <- function(link, node, from = 0, to = 20){

  data <- lapply(paste0(link, from:to),
    function(url){
      url %>% read_html() %>%
        html_nodes(node) %>%
        html_text()
    })

  return(unlist(data))
}




