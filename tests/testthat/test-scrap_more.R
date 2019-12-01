
test_that("scrap_more function", {

  expect_equal(

    scrap_more(
      "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=",
      ".listing_default",
      from = 0,
      to = 5

    ),
    unlist(lapply(paste0("http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=", 0:5),
      function(url){
        url %>% read_html() %>%
          html_nodes(".listing_default") %>%
          html_text() %>%
          unlist()
      }))

  )
})
