test_that("paragraphs_scrap() works", {
  expect_identical(

    paragraphs_scrap(link = "https://www.nytimes.com/")

    ,

     "https://www.nytimes.com/" %>%
      read_html() %>%
      html_nodes("p") %>%
      html_text()

               )

  ###############################################################################

  expect_type(paragraphs_scrap(link = "https://www.nytimes.com/"),
              "character")

  ###############################################################################

  expect_vector(paragraphs_scrap(link = "https://www.nytimes.com/"))

})
