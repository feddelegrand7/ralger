test_that("attribute_scrap works similar to rvest", {


  link <- "https://ropensci.org/"

  links <- link %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("class")

  expect_equal(links, attribute_scrap(link = link,
                                      node = "a",
                                      attr = "class"))

})


test_that("expect error when wrong parameters provided or missing", {


  expect_error(

    attribute_scrap(link = 2323,
                    node = "a",
                    attr = "class")
  )

  expect_error(

    attribute_scrap(link = TRUE,
                    node = "a",
                    attr = "class")
  )

  expect_error(

    attribute_scrap(link = "https://ropensci.org/",
                    attr = "class")
  )


  expect_error(

    attribute_scrap(link = "https://ropensci.org/",
                    attr = "class",
                    node = FALSE)
  )



})



test_that("expecting the function to return a character vector superior than 1", {

  link <- "https://ropensci.org/"

  expect_type(attribute_scrap(link = link,
                              node = "a",
                              attr = "class"),
              "character")

  expect_gt(length(attribute_scrap(link = link,
                                   node = "a",
                                   attr = "class")),
            0)

})
