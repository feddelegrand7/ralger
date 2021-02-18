

test_that("images_preview() return character", {
  testthat::skip_on_cran()
  expect_type(object = images_preview(link = "https://rstudio.com/"),
              type = "character")

})

###########################################################

test_that("images_preview() returns a vector", {
  testthat::skip_on_cran()
  expect_vector(object = images_preview(link = "https://rstudio.com/"))

})


test_that("images_preview() returns a vector of length superior or equal than 1", {
testthat::skip_on_cran()
expect_gte(length(images_preview(link = "https://rstudio.com/")), 1)

})


test_that("checking for errors", {

  expect_error(images_preview())

  expect_error(images_preview(23424234))

  expect_error(images_preview(rstudio.com))


})
