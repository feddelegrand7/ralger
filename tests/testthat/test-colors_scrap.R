
test_that("colors_scrap() errors when mandatory argument is missing", {

  expect_error(colors_scrap())

})


test_that("colors_scrap() errors when 'link' is not a character string", {

  expect_error(colors_scrap(link = 12345))

  expect_error(colors_scrap(link = TRUE))

})


test_that("colors_scrap() returns a character vector for a valid page", {

  skip_on_cran()

  result <- colors_scrap(link = "https://ropensci.org/")

  expect_type(result, "character")
  expect_gt(length(result), 0)

})


test_that("colors_scrap() returns only unique color codes", {

  skip_on_cran()

  result <- colors_scrap(link = "https://ropensci.org/")

  if (!is.null(result) && !identical(result, NA)) {
    expect_equal(result, unique(result))
  }

})
