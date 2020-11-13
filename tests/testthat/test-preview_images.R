test_that("images_preview() return character", {
  expect_type(object = images_preview(link = "https://rstudio.com/"), type = "character")
})

###########################################################

test_that("images_preview() returns a vector", {

  expect_vector(object = images_preview(link = "https://rstudio.com/"))

})


test_that("images_preview() returns a vector of length superior or equal than 1", {

expect_gte(length(images_preview(link = "https://rstudio.com/")), 1)

})
