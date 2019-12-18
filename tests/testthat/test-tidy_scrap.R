test_that("tidy_scrap() function", {

  expect_equal(
    tidy_scrap(
      link = "https://www.imdb.com/chart/top/",
      nodes = ".titleColumn a",
      colnames = c("value")),

    unlist(lapply("https://www.imdb.com/chart/top/",
      function(url){
        url %>% read_html() %>%
          html_nodes(".titleColumn a") %>%
          html_text()
      })) %>% as_tibble(.)

  )
})

