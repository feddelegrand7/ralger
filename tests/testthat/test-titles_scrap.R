
test_that("titles_scrap() works", {

  skip_on_cran()

  h1 <- "https://posit.co/" %>%
    read_html() %>%
    html_nodes("h1") %>%
    html_text()

  h2 <- "https://posit.co/" %>%
    read_html() %>%
    html_nodes("h2") %>%
    html_text()

  h3 <- "https://posit.co/" %>%
    read_html() %>%
    html_nodes("h3") %>%
    html_text()


  expect_equivalent(


  titles_scrap("https://posit.co/")


    ,


    data <- c(h1, h2, h3)


    )


  ###############################################################################

  expect_type(titles_scrap("https://posit.co/"),
              "character")

  ###############################################################################

  expect_vector(titles_scrap("https://posit.co/"))

})
