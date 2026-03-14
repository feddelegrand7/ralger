
test_that("colors_scrap() errors when mandatory argument is missing", {

  expect_error(colors_scrap(), "'link' is a mandatory parameter")

})


test_that("colors_scrap() errors when 'link' is not a character string", {

  expect_error(colors_scrap(link = 12345), "'link' must be provided as a character string")

})


test_that("colors_scrap() returns a character vector or NULL on a valid page", {

  skip_on_cran()

  result <- colors_scrap(link = "https://www.r-project.org/")

  expect_true(is.character(result) || is.null(result))

})
