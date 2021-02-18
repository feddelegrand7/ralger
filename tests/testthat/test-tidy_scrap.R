
test_that("tidy_scrap() function", {

testthat::skip_on_cran()

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


  # expecting a data.frame output

  expect_s3_class(

    tidy_scrap("https://www.imdb.com/chart/top/",
               c(".titleColumn a", "strong"),
               c("title", "rating")),

    "data.frame"


  )

  # expecting errors if one of those arguments is missing

  expect_error(tidy_scrap(link = "https://www.imdb.com/chart/top/"))

  expect_error(tidy_scrap(nodes = c(".titleColumn a", "strong")))

  expect_error(tidy_scrap(colnames = c("title", "rating")))


  # expecting an error when providing an undefined variable
  expect_error(

    tidy_scrap(undefined_variable,
               c(".titleColumn a", "strong"),
               c("title", "rating"))
  )


  # expecting an error if the parameters are not character strings
  expect_error(

    tidy_scrap("https://www.imdb.com/chart/top/",
               c(123123, 123123),
               c("title", "rating"))

  )

  # expecting an error when length 'nodes' and 'colnames' not the same

  expect_error(


      tidy_scrap("https://www.imdb.com/chart/top/",
                 c(".titleColumn a"),
                 c("title", "rating"))

  )




})

