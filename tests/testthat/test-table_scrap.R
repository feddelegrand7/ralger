
test_that("table_scrap() function", {

expect_equal(


  table_scrap("https://www.topscorersfootball.com/premier-league")


  ,

  "https://www.topscorersfootball.com/premier-league" %>%
    read_html() %>%
    html_table() %>%
    purrr::pluck(1)

    )
})






