
test_that("weblink_scrap() function", {

expect_equal(

  weblink_scrap("https://www.worldbank.org/en/research")

  ,

  "https://www.worldbank.org/en/research" %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href")

    )

  expect_vector(

    weblink_scrap("https://www.worldbank.org/en/research")

  )

  expect_type(

    weblink_scrap("https://www.worldbank.org/en/research")
    ,

    "character"

  )

  expect_gt(length(weblink_scrap("https://www.worldbank.org/en/research")),
            1)


  expect_error(weblink_scrap())


  expect_false(!is.character(weblink_scrap("https://www.worldbank.org/en/research")))





})






