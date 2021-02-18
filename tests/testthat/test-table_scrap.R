
test_that("table_scrap() function", {

testthat::skip_on_cran()

expect_equal(


  table_scrap("https://www.topscorersfootball.com/premier-league")


  ,
  {

    table <-  "https://www.topscorersfootball.com/premier-league" %>%
      read_html() %>%
      html_table()

    table[[1]]

  }


    )

  ################################################
  #---------------------------------------------------------------------------
  ################################################

  expect_s3_class(
    object = table_scrap("https://www.topscorersfootball.com/premier-league"),
    class = "data.frame"

    )

  ###############################################
  #---------------------------------------------------------------------------
  ###############################################


  expect_error(table_scrap())

  # expecting an error if the choose parameter is provided as
  # a character string
  expect_error(

    table_scrap(link = "https://www.topscorersfootball.com/premier-league",
               choose = "1")

    )

  # expecting an error if the link parameter is not provided
  expect_error(table_scrap(choose = 1))


  # if the user choose HTML table not available,
  # the result should be NA

  expect_identical(

    table_scrap(link = "https://www.topscorersfootball.com/premier-league",
                choose = 100),

    NA
  )





})






