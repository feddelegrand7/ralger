test_that("paragraphs_scrap() works", {

  skip_on_cran()


  expect_identical(

    paragraphs_scrap(link = "https://rstudio.com/")

    ,

     "https://rstudio.com/" %>%
      read_html() %>%
      html_nodes("p") %>%
      html_text()

               )

  ###############################################################################

  expect_type(paragraphs_scrap(link = "https://rstudio.com/"),
              "character")

  ###############################################################################

  expect_vector(paragraphs_scrap(link = "https://rstudio.com/"))


  # expecting to throw an error if the 'link' parameter is missing

  expect_error(paragraphs_scrap())

  # expecting an error if the 'contain' parameter is not a string

  expect_error(paragraphs_scrap(link = "https://rstudio.com/",
                                contain = 232342342))

  expect_gte(length(paragraphs_scrap(link = "https://rstudio.com/")),
            1)



})
