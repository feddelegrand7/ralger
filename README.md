
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ralger <a><img src='man/figures/logo.png' align="right" height="200" /></a>

<!-- badges: start -->

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/ralger)](https://cran.r-project.org/package=ralger)
[![CRAN_time_from_release](https://www.r-pkg.org/badges/ago/ralger)](https://cran.r-project.org/package=ralger)
[![CRAN_latest_release_date](https://www.r-pkg.org/badges/last-release/ralger)](https://cran.r-project.org/package=ralger)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/ralger)](https://cran.r-project.org/package=ralger)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/grand-total/ralger)](https://cran.r-project.org/package=ralger)
<!-- [![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://choosealicense.com/licenses/mit/) -->
[![R
badge](https://img.shields.io/badge/Build%20with-♥%20and%20R-blue)](https://github.com/feddelegrand7/ralger)
[![R
badge](https://img.shields.io/badge/-Sponsor-brightgreen)](https://www.buymeacoffee.com/Fodil)
[![R build
status](https://github.com/feddelegrand7/ralger/workflows/R-CMD-check/badge.svg)](https://github.com/feddelegrand7/ralger/actions)
[![Codecov test
coverage](https://codecov.io/gh/feddelegrand7/ralger/branch/master/graph/badge.svg)](https://codecov.io/gh/feddelegrand7/ralger?branch=master)
<!-- badges: end -->

The goal of **ralger** is to facilitate web scraping in R. For a quick
video tutorial, I gave a talk at useR2020, which you can find
[here](https://www.youtube.com/watch?v=OHi6E8jegQg)

## Installation

You can install the `ralger` package from
[CRAN](https://cran.r-project.org/) with:

``` r
install.packages("ralger")
```

or you can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("feddelegrand7/ralger")
```

## `scrap()`

This is an example which shows how to extract [top ranked universities’
names](http://www.shanghairanking.com/rankings/arwu/2021) according to
the ShanghaiRanking Consultancy:

``` r
library(ralger)

my_link <- "http://www.shanghairanking.com/rankings/arwu/2021"

my_node <- "a span" # The element ID , I recommend SelectorGadget if you're not familiar with CSS selectors

clean <- TRUE # Should the function clean the extracted vector or not ? Default is FALSE

best_uni <- scrap(link = my_link, node = my_node, clean = clean)

head(best_uni, 10)
#>  [1] "Harvard University"                         
#>  [2] "Stanford University"                        
#>  [3] "University of Cambridge"                    
#>  [4] "Massachusetts Institute of Technology (MIT)"
#>  [5] "University of California, Berkeley"         
#>  [6] "Princeton University"                       
#>  [7] "University of Oxford"                       
#>  [8] "Columbia University"                        
#>  [9] "California Institute of Technology"         
#> [10] "University of Chicago"
```

Thanks to the [robotstxt](https://github.com/ropensci/robotstxt), you
can set `askRobot = TRUE` to ask the `robots.txt` file if it’s permitted
to scrape a specific web page.

If you want to scrap multiple list pages, just use `scrap()` in
conjunction with `paste0()`.

``` r
base_link <- "http://quotes.toscrape.com/page/"
links <- paste0(base_link, 1:3)
node <- ".text"

head(scrap(links, node), 10)
#>  [1] "“The world as we have created it is a process of our thinking. It cannot be changed without changing our thinking.”"                
#>  [2] "“It is our choices, Harry, that show what we truly are, far more than our abilities.”"                                              
#>  [3] "“There are only two ways to live your life. One is as though nothing is a miracle. The other is as though everything is a miracle.”"
#>  [4] "“The person, be it gentleman or lady, who has not pleasure in a good novel, must be intolerably stupid.”"                           
#>  [5] "“Imperfection is beauty, madness is genius and it's better to be absolutely ridiculous than absolutely boring.”"                    
#>  [6] "“Try not to become a man of success. Rather become a man of value.”"                                                                
#>  [7] "“It is better to be hated for what you are than to be loved for what you are not.”"                                                 
#>  [8] "“I have not failed. I've just found 10,000 ways that won't work.”"                                                                  
#>  [9] "“A woman is like a tea bag; you never know how strong it is until it's in hot water.”"                                              
#> [10] "“A day without sunshine is like, you know, night.”"
```

## `attribute_scrap()`

If you need to scrape some elements’ attributes, you can use the
`attribute_scrap()` function as in the following example:

``` r
# Getting all classes' names from the anchor elements
# from the ropensci website

attributes <- attribute_scrap(link = "https://ropensci.org/",
                node = "a", # the a tag
                attr = "class" # getting the class attribute
                )

head(attributes, 10) # NA values are a tags without a class attribute
#>  [1] "navbar-brand logo"      "dropdown-item lang-nav" "dropdown-item lang-nav"
#>  [4] "dropdown-item lang-nav" "dropdown-item lang-nav" "nav-link"              
#>  [7] NA                       NA                       NA                      
#> [10] "nav-link"
```

Another example, let’s say we want to get all javascript dependencies
within the same web page:

``` r

js_depend <- attribute_scrap(link = "https://ropensci.org/",
                             node = "script",
                             attr = "src")

js_depend
#>  [1] "https://cdn.jsdelivr.net/gh/orestbida/cookieconsent@v3.0.0/dist/cookieconsent.umd.js"                                                                               
#>  [2] "/scripts/matomo.js?nocache=1"                                                                                                                                       
#>  [3] "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"                                                                                                  
#>  [4] "https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"                                                                                               
#>  [5] "https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"                                                                                             
#>  [6] "https://cdnjs.cloudflare.com/ajax/libs/fuse.js/6.4.6/fuse.js"                                                                                                       
#>  [7] "https://cdnjs.cloudflare.com/ajax/libs/autocomplete.js/0.38.0/autocomplete.js"                                                                                      
#>  [8] "/scripts/search.js"                                                                                                                                                 
#>  [9] "/scripts/copypaste.js?nocache=3"                                                                                                                                    
#> [10] "https://ropensci.org/common.min.a685190e216b8a11a01166455cd0dd959a01aafdcb2fa8ed14871dafeaa4cf22cec232184079e5b6ba7360b77b0ee721d070ad07a24b83d454a3caf7d1efe371.js"
```

## `table_scrap()`

If you want to extract an **HTML Table**, you can use the
`table_scrap()` function. Take a look at this
[webpage](https://www.boxofficemojo.com/chart/top_lifetime_gross/?area=XWW)
which lists the highest gross revenues in the cinema industry. You can
extract the HTML table as follows:

``` r


data <- table_scrap(link ="https://www.boxofficemojo.com/chart/top_lifetime_gross/?area=XWW")

head(data)
#> # A tibble: 6 × 4
#>    Rank Title                                      `Lifetime Gross`  Year
#>   <int> <chr>                                      <chr>            <int>
#> 1     1 Avatar                                     $2,923,710,708    2009
#> 2     2 Avengers: Endgame                          $2,799,439,100    2019
#> 3     3 Avatar: The Way of Water                   $2,320,250,281    2022
#> 4     4 Titanic                                    $2,264,812,968    1997
#> 5     5 Star Wars: Episode VII - The Force Awakens $2,071,310,218    2015
#> 6     6 Avengers: Infinity War                     $2,052,415,039    2018
```

**When you deal with a web page that contains many HTML table you can
use the `choose` argument to target a specific table**

## `tidy_scrap()`

Sometimes you’ll find some useful information on the internet that you
want to extract in a tabular manner however these information are not
provided in an HTML format. In this context, you can use the
`tidy_scrap()` function which returns a tidy data frame according to the
arguments that you introduce. The function takes four arguments:

- **link** : the link of the website you’re interested for;
- **nodes**: a vector of CSS elements that you want to extract. These
  elements will form the columns of your data frame;
- **colnames**: this argument represents the vector of names you want to
  assign to your columns. Note that you should respect the same order as
  within the **nodes** vector;
- **clean**: if true the function will clean the tibble’s columns;
- **askRobot**: ask the robots.txt file if it’s permitted to scrape the
  web page.

### Example

We will need to use the `tidy_scrap()` function as follows:

``` r

my_link <- "http://books.toscrape.com/catalogue/page-1.html"

my_nodes <- c(
  "h3 > a",            # Title
  ".price_color",      # Price
  ".availability"      # Availability
)

names <- c("title", "price", "availability") # respect the order

tidy_scrap(link = my_link, nodes = my_nodes, colnames = names)
#> # A tibble: 20 × 3
#>    title                                 price  availability                    
#>    <chr>                                 <chr>  <chr>                           
#>  1 A Light in the ...                    £51.77 "\n    \n    \n        In stock…
#>  2 Tipping the Velvet                    £53.74 "\n    \n    \n        In stock…
#>  3 Soumission                            £50.10 "\n    \n    \n        In stock…
#>  4 Sharp Objects                         £47.82 "\n    \n    \n        In stock…
#>  5 Sapiens: A Brief History ...          £54.23 "\n    \n    \n        In stock…
#>  6 The Requiem Red                       £22.65 "\n    \n    \n        In stock…
#>  7 The Dirty Little Secrets ...          £33.34 "\n    \n    \n        In stock…
#>  8 The Coming Woman: A ...               £17.93 "\n    \n    \n        In stock…
#>  9 The Boys in the ...                   £22.60 "\n    \n    \n        In stock…
#> 10 The Black Maria                       £52.15 "\n    \n    \n        In stock…
#> 11 Starving Hearts (Triangular Trade ... £13.99 "\n    \n    \n        In stock…
#> 12 Shakespeare's Sonnets                 £20.66 "\n    \n    \n        In stock…
#> 13 Set Me Free                           £17.46 "\n    \n    \n        In stock…
#> 14 Scott Pilgrim's Precious Little ...   £52.29 "\n    \n    \n        In stock…
#> 15 Rip it Up and ...                     £35.02 "\n    \n    \n        In stock…
#> 16 Our Band Could Be ...                 £57.25 "\n    \n    \n        In stock…
#> 17 Olio                                  £23.88 "\n    \n    \n        In stock…
#> 18 Mesaerion: The Best Science ...       £37.59 "\n    \n    \n        In stock…
#> 19 Libertarianism for Beginners          £51.33 "\n    \n    \n        In stock…
#> 20 It's Only the Himalayas               £45.17 "\n    \n    \n        In stock…
```

Note that all columns will be of *character* class. you’ll have to
convert them according to your needs.

## `titles_scrap()`

Using `titles_scrap()`, one can efficiently scrape titles which
correspond to the *h1, h2 & h3* HTML tags.

### Example

If we go to the [New York Times](https://www.nytimes.com/), we can
easily extract the titles displayed within a specific web page :

``` r

titles <- titles_scrap(link = "https://www.nytimes.com/")

head(titles)
#> [1] "New York Times - Top Stories"        "More News"                          
#> [3] "The AthleticSports coverage"         "Well"                               
#> [5] "Culture and Lifestyle"               "AudioPodcasts and narrated articles"
```

Further, it’s possible to filter the results using the `contain`
argument:

``` r

titles <- titles_scrap(link = "https://www.nytimes.com/", contain = "TrUMp", case_sensitive = FALSE)

head(titles)
#> character(0)
```

## `paragraphs_scrap()`

In the same way, we can use the `paragraphs_scrap()` function to extract
paragraphs. This function relies on the `p` HTML tag.

Let’s get some paragraphs from the lovely
[ropensci.org](https://ropensci.org/) website:

``` r

pgs <- paragraphs_scrap(link = "https://ropensci.org/")

head(pgs)
#> [1] ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
#> [2] "rOpenSci fosters a culture of open and reproducible research using shared data and reusable software. We build social and technical infrastructure for the R language to enable researchers and engineers to collaborate, share, and publish their science, data, and methods."                                                                                                                                                                                            
#> [3] "rOpenSci's Software Peer Review is a mechanism to validate high-quality packages, improve best practices and skills in the research software community, and build collaborations and\ncommunity via a transparent, constructive and open review process utilising GitHub's open\nsource infrastructure. Through it we have assembled a suite of hundreds of tools to support open science, and a community of package authors, reviewers, and maintainers to sustain them."
#> [4] "We combine academic peer reviews with production software code reviews to create a\ntransparent, collaborative & more efficient review process\n  "                                                                                                                                                                                                                                                                                                                        
#> [5] "Based on best practices of software development and standards of R, its\napplications and user base."                                                                                                                                                                                                                                                                                                                                                                      
#> [6] "We have expanded our peer review system to include packages that implement statistical algorithms."
```

If needed, it’s possible to collapse the paragraphs into one bag of
words:

``` r

paragraphs_scrap(link = "https://ropensci.org/", collapse = TRUE)
#> [1] " rOpenSci fosters a culture of open and reproducible research using shared data and reusable software. We build social and technical infrastructure for the R language to enable researchers and engineers to collaborate, share, and publish their science, data, and methods. rOpenSci's Software Peer Review is a mechanism to validate high-quality packages, improve best practices and skills in the research software community, and build collaborations and\ncommunity via a transparent, constructive and open review process utilising GitHub's open\nsource infrastructure. Through it we have assembled a suite of hundreds of tools to support open science, and a community of package authors, reviewers, and maintainers to sustain them. We combine academic peer reviews with production software code reviews to create a\ntransparent, collaborative & more efficient review process\n   Based on best practices of software development and standards of R, its\napplications and user base. We have expanded our peer review system to include packages that implement statistical algorithms. R-Universe is our next-generation platform for discovering R tools, learning from documentation, developing and testing packages, and publishing your own collections. R-Universe's technology lets individuals, organizations, and consortia manage their own repositories at any scale. Discover and use packages. R-universe documentation. Bug reports and feature requests. The rOpenSci Champions Program is for people who are interested in contributing to rOpenSci, and becoming leaders in the broader open source and open science communities.\nIt is a powerful, inclusive platform for developing your open-source project with support from experts. rOpenSci Champions interact, share, and strengthen a global network of peers determined to develop open and reproducible science in their local communities. Meet the cohorts. Projects, activities, and program details. (Spanish) Training sessions from the Champions' Program and beyond. We welcome you to join us and help improve tools and practices available to\nresearchers while receiving greater visibility to your contributions. You can\ncontribute with your packages, resources or post questions so our members will help\nyou along your process. Discover, learn and get involved in helping to shape the future of Data Science Join in our Community Calls with fellow developers and scientists - open\nto all Upcoming events including meetings at which our team members are speaking. We aim to expand access to R through a program of making first-class documentation available in languages beyond English. We are starting with our own resources, translating rOpenSci’s material on best practices for software development, code review, and contribution to open source projects into Spanish and more. As part of this effort we also developing guidelines and tools for translating open source resources to a wider audience. Why and how we localize and translate our resources. Package to translate Markdown based content through an external web API. Package to set up and render a multilingual Quarto website or book. Use our carefully vetted, staff- and community-contributed R software tools that support the research data life cycle and analysis across a variety of scientific fields. Combine our tools with the rich ecosystem of R packages. Workflow Tools for Your Code and Data Get Data from the Web Convert and Munge Data Document and Release Your Data Visualize Data Work with Databases From R Access, Manipulate, Convert Geospatial Data Interact with Web Resources Use Image & Audio Data Access Scientific Literature Databases, Analyze Scientific Papers (and Text in General) Secure Your Data and Workflow Statistical algorithms and statistics-specific workflows Handle and Transform Taxonomic Information Get inspired by real examples of how our packages can be used. Or browse scientific publications that cited our packages. The latest developments from rOpenSci and the wider R community Release notes, updates and package related developements A digest of R package and software review news, use cases, blog posts, and events, curated monthly. Subscribe to get it in your inbox, or check the archive. Happy rOpenSci users can be found at Except where otherwise noted, content on this site is licensed under the CC-BY license •\nPrivacy Policy • Cookies"
```

## `weblink_scrap()`

`weblink_scrap()` is used to srape the web links available within a web
page. Useful in some cases, for example, getting a list of the available
PDFs:

``` r

links <- weblink_scrap(link = "https://www.worldbank.org/en/access-to-information/reports/",
              contain = "PDF",
              case_sensitive = FALSE)

head(links)
#> [1] "https://thedocs.worldbank.org/en/doc/d66752542a83742a813226d1ba21e491-0090012025/original/Access-to-Information-2023-annual-report.pdf"           
#> [2] "https://thedocs.worldbank.org/en/doc/b71359e454b5218f4f19ca563c2b7307-0090012023/original/World-Bank-Access-to-Information-FY22-annual-report.pdf"
#> [3] "https://thedocs.worldbank.org/en/doc/7a92bafb1fb3bafb9e927c96814037e8-0090012022/original/Access-to-Information-FY21-annual-report.pdf"           
#> [4] "https://thedocs.worldbank.org/en/doc/142b0dab31674dfda9092a5ff75f8839-0090012021/original/Access-to-Infromation-FY20-annual-report.pdf"           
#> [5] "https://pubdocs.worldbank.org/en/304561593192266592/pdf/A2i-2019-annual-report-FINAL.pdf"                                                         
#> [6] "https://pubdocs.worldbank.org/en/539071573586305710/pdf/A2I-annual-report-2018-Final.pdf"
```

## `images_scrap()` and `images_preview()`

`images_preview()` allows you to scrape the URLs of the images available
within a web page so that you can choose which images **extension** (see
below) you want to focus on.

Let’s say we want to list all the images from the official
[Posit](https://posit.co/) website:

``` r

imgs <- images_preview(link = "https://posit.co/")

head(imgs)
#> [1] "https://www.facebook.com/tr?id=151855192184380&ev=PageView&noscript=1"     
#> [2] "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
#> [3] "/wp-content/themes/Posit/assets/images/posit-logo-2024.svg"                
#> [4] "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
#> [5] "/wp-content/themes/Posit/assets/images/posit-logo-white-2024.svg"          
#> [6] "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
```

`images_scrap()` on the other hand download the images. It takes the
following arguments:

- **link**: The URL of the web page;

- **imgpath**: The destination folder of your images. It defaults to
  `getwd()`

- **extn**: the extension of the image: jpg, png, jpeg … among others;

- **askRobot**: ask the robots.txt file if it’s permitted to scrape the
  web page.

``` r
# Suppose we're in a project which has a folder called my_images:
images_scrap(
  link = "http://books.toscrape.com/",
  imgpath = here::here("my_images"),
  extn = "jpg"  # images here use .jpg
)
```

## `pdf_scrap`

The function can be used to download `PDF` documents from a particular
website, note that the `PDFs` need to be hosted within the website
statically. Also, the access should not be restricted:

``` r
pdf_scrap(
  link = "https://www.make-it-in-germany.com/en/visa-residence/types/eu-blue-card",
  path = here::here("my_pdfs")
)
```

## `csv_scrap`

``` r
csv_scrap(
  link = "https://sample-files.com/data/csv/", 
  path = here::here("my_csvs")
)
```

## `xlsx_scrap`

``` r
xlsx_scrap(
  link = "https://file-examples.com/index.php/sample-documents-download/sample-xls-download/", 
  path = here::here("my_xlsx")
)
```

## `xls_scrap`

``` r
xls_scrap(
  link = "https://file-examples.com/index.php/sample-documents-download/sample-xls-download/", 
  path = here::here("my_xls")
)
```

# Accessibility related functions

## `images_noalt_scrap()`

`images_noalt_scrap()` can be used to get the images within a specific
web page that don’t have an `alt` attribute which can be annoying for
people using a screen reader:

``` r

images_noalt_scrap(link = "https://www.r-consortium.org/")
#> [1] <img loading="lazy" src="./posts/r-consortium-awards-first-round-of-2025-isc-grants/isc-grantees-2025-1.png" class="thumbnail-image card-img" style="height: 150px;">                          
#> [2] <img loading="lazy" src="./posts/exploring-kuzco-making-computer-vision-for-r-easily-accessible/frankthull.png" class="thumbnail-image card-img" style="height: 150px;">                       
#> [3] <img loading="lazy" src="./posts/quantifying-participation-risk-with-r-and-r-shiny-a-new-frontier-in-financial-risk-modeling/demo.png" class="thumbnail-image card-img" style="height: 150px;">
```

If no images without `alt` attributes are found, the function returns
`NULL` and displays an indication message:

``` r
# WebAim is the reference website for web accessibility

images_noalt_scrap(link = "https://webaim.org/techniques/forms/controls")
#> No images without 'alt' attribute found at: https://webaim.org/techniques/forms/controls
#> NULL
```

## Code of Conduct

Please note that the ralger project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
