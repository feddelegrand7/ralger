
test_that("audio_scrap() errors when mandatory arguments are missing", {

  expect_error(audio_scrap())

})


test_that("audio_scrap() errors when 'link' is not a character string", {

  expect_error(audio_scrap(link = 12345))

})


test_that("audio_scrap() errors when 'extensions' is invalid", {

  expect_error(audio_scrap(link = "https://www.example.com", extensions = 123))

  expect_error(audio_scrap(link = "https://www.example.com", extensions = character(0)))

})


test_that("audio_scrap() errors when extensions include a leading dot", {

  expect_error(audio_scrap(link = "https://www.example.com", extensions = ".mp3"))

})


test_that("audio_scrap() errors when path does not exist", {

  expect_error(
    audio_scrap(
      link = "https://www.example.com",
      extensions = "mp3",
      path = "/non/existent/path/xyz"
    )
  )

})
