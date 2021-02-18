
test_that("titles_scrap() works", {


  h1 <- "https://rstudio.com/" %>%
    read_html() %>%
    html_nodes("h1") %>%
    html_text()

  h2 <- "https://rstudio.com/" %>%
    read_html() %>%
    html_nodes("h2") %>%
    html_text()

  h3 <- "https://rstudio.com/" %>%
    read_html() %>%
    html_nodes("h3") %>%
    html_text()


  expect_equivalent(


  titles_scrap("https://rstudio.com/")


    ,


    data <- c(h1, h2, h3)


    )


  ###############################################################################

  expect_type(titles_scrap("https://rstudio.com/"),
              "character")

  ###############################################################################

  expect_vector(titles_scrap("https://rstudio.com/"))

})
