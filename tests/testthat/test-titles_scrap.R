testthat::skip_on_cran()


h1 <- "https://www.un.org/en/" %>%
  read_html() %>%
  html_nodes("h1") %>%
  html_text()

h2 <- "https://www.un.org/en/" %>%
  read_html() %>%
  html_nodes("h2") %>%
  html_text()

h3 <- "https://www.un.org/en/" %>%
  read_html() %>%
  html_nodes("h3") %>%
  html_text()


test_that("titles_scrap() works", {
  expect_equivalent(


  titles_scrap("https://www.un.org/en/")


    ,


    data <- c(h1, h2, h3)


    )


  ###############################################################################

  expect_type(titles_scrap("https://www.un.org/en/"),
              "character")

  ###############################################################################

  expect_vector(titles_scrap("https://www.un.org/en/"))

})
