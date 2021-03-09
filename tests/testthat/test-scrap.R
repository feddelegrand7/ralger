
test_that("scrap() function", {


  skip_on_cran()


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


  expect_vector(

    scrap(
      link = "https://www.imdb.com/chart/top/",
      node = ".titleColumn a"
    )
  )

  expect_type(

    scrap(
      link = "https://www.imdb.com/chart/top/",
      node = ".titleColumn a"
    ),

    "character"

  )

  expect_error(scrap(link = "https://www.imdb.com/chart/top/"))

  expect_error(scrap(node = ".titleColumn a"))

  expect_error(scrap())

  expect_error(scrap(
    link = www.imdb.com,
    node = .titleColumn
  ))




})








