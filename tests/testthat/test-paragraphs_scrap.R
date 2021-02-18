testthat::skip_on_cran()


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


  # expecting to throw an error if the 'link' parameter is missing

  expect_error(paragraphs_scrap())

  # expecting an error if the 'contain' parameter is not a string

  expect_error(paragraphs_scrap(link = "https://www.un.org/en/",
                                contain = 232342342))

  expect_gte(length(paragraphs_scrap(link = "https://www.un.org/en/")),
            1)



})
