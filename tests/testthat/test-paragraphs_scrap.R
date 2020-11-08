test_that("paragraphs_scrap() works", {
  expect_identical(

    paragraphs_scrap(link = "https://www.un.org/en/")

    ,

     "https://www.un.org/en/" %>%
      read_html() %>%
      html_nodes("p") %>%
      html_text()

               )

  ###############################################################################

  expect_type(paragraphs_scrap(link = "https://www.un.org/en/"),
              "character")

  ###############################################################################

  expect_vector(paragraphs_scrap(link = "https://www.un.org/en/"))

})
