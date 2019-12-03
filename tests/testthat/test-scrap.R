
test_that("scrap() function", {

expect_equal(

  scrap(
      link = "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver",
      node = ".listing_default"
    ),

  unlist(lapply("http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver",
      function(url){
        url %>% read_html() %>%
          html_nodes(".listing_default") %>%
          html_text()
      }))

    )
})






