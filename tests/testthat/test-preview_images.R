

test_that("images_preview() return character", {

  skip_on_cran()

  expect_type(object = images_preview(link = "https://posit.co/"),
              type = "character")

})

###########################################################

test_that("images_preview() returns a vector", {

  skip_on_cran()

  expect_vector(object = images_preview(link = "https://posit.co/"))

})


test_that("images_preview() returns a vector of length superior or equal than 1", {

  skip_on_cran()

  expect_gte(length(images_preview(link = "https://posit.co/")), 1)

})


test_that("checking for errors", {

  expect_error(images_preview())

  expect_error(images_preview(23424234))

})
