
test_that("table_scrap() function", {

  ##############################################

expect_equal(


  table_scrap("https://www.topscorersfootball.com/premier-league")


  ,

  "https://www.topscorersfootball.com/premier-league" %>%
    read_html() %>%
    html_table() %>%
    purrr::pluck(1)

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

  expect_type(object = table_scrap("https://www.topscorersfootball.com/premier-league"),
              type = "list")

  ###############################################
  #---------------------------------------------------------------------------



})






