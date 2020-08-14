
test_that("scrap() function", {

expect_equal(

  scrap(
      link = "https://www.imdb.com/chart/top/",
      node = ".titleColumn a"
    ),

  unlist(lapply("https://www.imdb.com/chart/top/",
      function(url){
        url %>% read_html() %>%
          html_nodes(".titleColumn a") %>%
          html_text()
      }))

    )
})


test_that("scrap() function returns a character vector", {

  expect_vector(

    scrap(
      link = "https://www.imdb.com/chart/top/",
      node = ".titleColumn a"
    )
  )
})






