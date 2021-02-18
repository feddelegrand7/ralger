

test_that(desc = "errors when mandatory arguments missing", {

expect_error(images_scrap())

expect_error(images_scrap("https://rstudio.com/"))


})


test_that(desc = "checking for errors when
          parameters are not of character string type", {


expect_error(images_scrap(link = 2342342423423))


expect_error(images_scrap(link = "https://rstudio.com/",
                          imgpath = getwd(),
                          extn = 123))

expect_error(images_scrap(link = "https://rstudio.com/",
                          imgpath = 2342423,
                          extn = "jpg"))

})


test_that(desc = "checking for error when
          'extn' is provided with a dot .", {

expect_error(images_scrap("https://rstudio.com/",
                          extn = ".jpg"))



})
