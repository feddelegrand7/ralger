test_that("tidy_scrap() function", {

  expect_equal(
    tidy_scrap(
      link = "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver",
      nodes = ".listing_default",
      scrap_names = c("value")),

    unlist(lapply("http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver",
      function(url){
        url %>% read_html() %>%
          html_nodes(".listing_default") %>%
          html_text()
      })) %>% as_tibble(.)

  )
})

