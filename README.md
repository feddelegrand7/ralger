
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ralger <a><img src='man/figures/logo.png' align="right" height="200" /></a>

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/ralger)](https://cran.r-project.org/package=ralger)
[![CRAN\_time\_from\_release](https://www.r-pkg.org/badges/ago/ralger)](https://cran.r-project.org/package=ralger)
[![CRAN\_latest\_release\_date](https://www.r-pkg.org/badges/last-release/ralger)](https://cran.r-project.org/package=ralger)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/ralger)](https://cran.r-project.org/package=ralger)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/grand-total/ralger)](https://cran.r-project.org/package=ralger)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://choosealicense.com/licenses/mit/)
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
names](http://www.shanghairanking.com/ARWU2020.html) according to the
ShanghaiRanking Consultancy:

``` r
library(ralger)

my_link <- "http://www.shanghairanking.com/ARWU2020.html"

my_node <- "#UniversityRanking a" # The class ID , we recommend SelectorGadget

best_uni <- scrap(link = my_link, node = my_node)

head(best_uni, 10)
#>  [1] "Harvard University"                         
#>  [2] "Stanford University"                        
#>  [3] "University of Cambridge"                    
#>  [4] "Massachusetts Institute of Technology (MIT)"
#>  [5] "University of California, Berkeley"         
#>  [6] "Princeton University"                       
#>  [7] "Columbia University"                        
#>  [8] "California Institute of Technology"         
#>  [9] "University of Oxford"                       
#> [10] "University of Chicago"
```

Thanks to the [robotstxt](https://github.com/ropensci/robotstxt), you
can set `askRobot = TRUE` to ask the `robots.txt` file if it’s permitted
to scrape a specific web page.

If you want to scrap multiple list pages, just use `scrap()` in
conjunction with `paste0()`. Suppose that you want to scrape all
`RStudio::conf 2021` speakers:

``` r
base_link <- "https://global.rstudio.com/student/catalog/list?category_ids=1796-speakers&page="

links <- paste0(base_link, 1:3) # the speakers are listed from page 1 to 3

node <- ".mediablock__link"


head(scrap(links, node), 10) # printing the first 10 speakers
#>  [1] "Aaron Jacobs"              "Ahmadou Dicko"            
#>  [3] "Alan Feder"                "Alex Cookson"             
#>  [5] "Allison Horst"             "Andrew Ba Tran"           
#>  [7] "Athanasia M. Mowinckel"    "Barret Schloerke"         
#>  [9] "Carson Sievert"            "Chelsea Parlett-Pelleriti"
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
#>   Rank                                      Title Lifetime Gross Year
#> 1    1                          Avengers: Endgame $2,797,800,564 2019
#> 2    2                                     Avatar $2,790,439,092 2009
#> 3    3                                    Titanic $2,471,751,922 1997
#> 4    4 Star Wars: Episode VII - The Force Awakens $2,068,454,133 2015
#> 5    5                     Avengers: Infinity War $2,048,359,754 2018
#> 6    6                             Jurassic World $1,670,471,444 2015
```

**When you deal with a web page that contains many HTML table you can
use the `choose` argument to target a specific table**

## `tidy_scrap()`

Sometimes you’ll find some useful information on the internet that you
want to extract in a tabular manner however these information are not
provided in an HTML format. In this context, you can use the
`tidy_scrap()` function which returns a tidy data frame according to the
arguments that you introduce. The function takes four arguments:

-   **link** : the link of the website you’re interested for;
-   **nodes**: a vector of CSS elements that you want to extract. These
    elements will form the columns of your data frame;
-   **colnames**: this argument represents the vector of names you want
    to assign to your columns. Note that you should respect the same
    order as within the **nodes** vector;
-   **clean**: if true the function will clean the tibble’s columns;
-   **askRobot**: ask the robots.txt file if it’s permitted to scrape
    the web page.

### Example

We’ll work on the famous [IMDb website](https://www.imdb.com/). Let’s
say we need a data frame composed of:

-   The title of the 50 best ranked movies of all time
-   Their release year
-   Their rating

We will need to use the `tidy_scrap()` function as follows:

``` r
my_link <- "https://www.imdb.com/search/title/?groups=top_250&sort=user_rating"

my_nodes <- c(
  ".lister-item-header a", # The title
  ".text-muted.unbold", # The year of release
  ".ratings-imdb-rating strong" # The rating)
  )

names <- c("title", "year", "rating") # respect the nodes order


tidy_scrap(link = my_link, nodes = my_nodes, colnames = names)
#> # A tibble: 50 x 3
#>    title                                         year   rating
#>    <chr>                                         <chr>  <chr> 
#>  1 The Shawshank Redemption                      (1994) 9.3   
#>  2 The Godfather                                 (1972) 9.2   
#>  3 The Dark Knight                               (2008) 9.0   
#>  4 The Godfather: Part II                        (1974) 9.0   
#>  5 12 Angry Men                                  (1957) 9.0   
#>  6 The Lord of the Rings: The Return of the King (2003) 8.9   
#>  7 Pulp Fiction                                  (1994) 8.9   
#>  8 Schindler's List                              (1993) 8.9   
#>  9 Inception                                     (2010) 8.8   
#> 10 Fight Club                                    (1999) 8.8   
#> # ... with 40 more rows
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

titles_scrap(link = "https://www.nytimes.com/")
#>  [1] "Listen to ‘The Sunday Read’"                                                                                             
#>  [2] "In the ‘At Home’ Newsletter"                                                                                             
#>  [3] "Listen to ‘Sway’ With Kara Swisher"                                                                                      
#>  [4] "It’s 30 Degrees. Shall We Have Brunch Outdoors?"                                                                         
#>  [5] "Why Vaccines Alone Will Not End the Pandemic"                                                                            
#>  [6] "How Space Became the Next ‘Great Power’ Contest Between the U.S. and China"                                              
#>  [7] "Here are five takeaways from the developing space war between China and the U.S."                                        
#>  [8] "Capitol Riot Puts Spotlight on ‘Apocalyptically Minded’ Global Far Right"                                                
#>  [9] "Divisions Harden in Senate as It Prepares to Receive Impeachment Article"                                                
#> [10] "How Democrats Planned for Doomsday Scenarios"                                                                            
#> [11] "In Biden’s Catholic Faith, an Ascendant Liberal Christianity"                                                            
#> [12] "The Senate Isn’t What It Used to Be. Is President Biden Ready?"                                                          
#> [13] "Trump Wants Back on Facebook. This Star-Studded Jury Might Let Him."                                                     
#> [14] "Tom Brady Heads Back to Super Bowl With Buccaneers’ Win Over Packers"                                                    
#> [15] "At 43, Tom Brady will be playing in his 10th Super Bowl, proving he can still compete at the highest level."             
#> [16] "Analysis: Amid Protests, Kremlin Drops Its ‘Navalny Who?’ Tack"                                                          
#> [17] "Pro-Navalny Protest Photos: Wave of Anger Rolls Across Russia"                                                           
#> [18] "Hong Kong Crackdown Is an Early Test for Biden"                                                                          
#> [19] "Avoiding the Obama-Era Silence Trap"                                                                                     
#> [20] "My Language Is Dying, Too"                                                                                               
#> [21] "Has China Done Too Well Against Covid-19?"                                                                               
#> [22] "America’s Other Front Line"                                                                                              
#> [23] "Democrats, Here’s How to Lose in 2022. And Deserve It."                                                                  
#> [24] "America Has a GPS Problem"                                                                                               
#> [25] "3 Million People Were Deported Under Obama. What Will Biden Do About It?"                                                
#> [26] "Joe Biden’s Catholic Moment"                                                                                             
#> [27] "What Happens When You Click ‘Agree’?"                                                                                    
#> [28] "A Final Interview With Hank Aaron: ‘I Recognized That I Had a Gift’"                                                     
#> [29] "How Can We Read Edith Wharton Today?"                                                                                    
#> [30] "When Some Critics Reject the Film That’s About Your Life"                                                                
#> [31] "A School District Vowed to Stay Open, Until Its Staffing Ran Out"                                                        
#> [32] "Site Index"                                                                                                              
#> [33] "Site Information Navigation"                                                                                             
#> [34] "How West Virginia Became a U.S. Leader in Vaccine Rollout"                                                               
#> [35] "Fauci on What Working for Trump Was Really Like"                                                                         
#> [36] "Mexico’s President Is Latest World Leader Infected With the Virus"                                                       
#> [37] "A virus variant that could be deadlier is a powerful argument that relaxing restrictions in Britain could be calamitous."
#> [38] "Opinion"                                                                                                                 
#> [39] "Editors’ Picks"                                                                                                          
#> [40] "Advertisement"
```

Further, it’s possible to filter the results using the `contain`
argument:

``` r
titles_scrap(link = "https://www.nytimes.com/", contain = "TrUMp", case_sensitive = FALSE)
#> [1] "Trump Wants Back on Facebook. This Star-Studded Jury Might Let Him."
#> [2] "Fauci on What Working for Trump Was Really Like"
```

## `paragraphs_scrap()`

In the same way, we can use the `paragraphs_scrap()` function to extract
paragraphs. This function relies on the `p` HTML tag.

Let’s get some paragraphs from the lovely
[ropensci.org](https://ropensci.org/) website:

``` r
paragraphs_scrap(link = "https://ropensci.org/")
#>  [1] ""                                                                                                                                                                                                                                                                        
#>  [2] "We help develop R packages for the sciences via community driven learning, review and\nmaintenance of contributed software in the R ecosystem"                                                                                                                           
#>  [3] "Use our carefully vetted, staff- and community-contributed R software tools that lower barriers to working with local and remote scientific data sources. Combine our tools with the rich ecosystem of R packages."                                                      
#>  [4] "Workflow Tools for Your Code and Data"                                                                                                                                                                                                                                   
#>  [5] "Get Data from the Web"                                                                                                                                                                                                                                                   
#>  [6] "Convert and Munge Data"                                                                                                                                                                                                                                                  
#>  [7] "Document and Release Your Data"                                                                                                                                                                                                                                          
#>  [8] "Visualize Data"                                                                                                                                                                                                                                                          
#>  [9] "Work with Databases From R"                                                                                                                                                                                                                                              
#> [10] "Access, Manipulate, Convert Geospatial Data"                                                                                                                                                                                                                             
#> [11] "Interact with Web Resources"                                                                                                                                                                                                                                             
#> [12] "Use Image & Audio Data"                                                                                                                                                                                                                                                  
#> [13] "Analyze Scientific Papers (and Text in General)"                                                                                                                                                                                                                         
#> [14] "Secure Your Data and Workflow"                                                                                                                                                                                                                                           
#> [15] "Handle and Transform Taxonomic Information"                                                                                                                                                                                                                              
#> [16] "Get inspired by real examples of how our packages can be used."                                                                                                                                                                                                          
#> [17] "Or browse scientific publications that cited our packages."                                                                                                                                                                                                              
#> [18] "Our suite of packages is comprised of contributions from staff engineers and the wider R\ncommunity via a transparent, constructive and open review process utilising GitHub's open\nsource infrastructure."                                                             
#> [19] "We combine academic peer reviews with production software code reviews to create a\ntransparent, collaborative & more efficient review process\n  "                                                                                                                      
#> [20] "Based on best practices of software development and standards of R, its\napplications and user base."                                                                                                                                                                    
#> [21] "Our diverse community of academics, data scientists and developers provide a\nplatform for shared learning, collaboration and reproducible science"                                                                                                                      
#> [22] "We welcome you to join us and help improve tools and practices available to\nresearchers while receiving greater visibility to your contributions. You can\ncontribute with your packages, resources or post questions so our members will help\nyou along your process."
#> [23] "Discover, learn and get involved in helping to shape the future of Data Science"                                                                                                                                                                                         
#> [24] "Join in our quarterly Community Calls with fellow developers and scientists - open\nto all"                                                                                                                                                                              
#> [25] "Upcoming events including meetings at which our team members are speaking."                                                                                                                                                                                              
#> [26] "The latest developments from rOpenSci and the wider R community"                                                                                                                                                                                                         
#> [27] "Release notes, updates and package related developements"                                                                                                                                                                                                                
#> [28] "A digest of R package and software review news, use cases, blog posts, and events, curated every two weeks. Subscribe to get it in your inbox, or check the archive."                                                                                                    
#> [29] "Happy rOpenSci users can be found at"                                                                                                                                                                                                                                    
#> [30] "Except where otherwise noted, content on this site is licensed under the CC-BY license •\nPrivacy Policy"
```

If needed, it’s possible to collapse the paragraphs into one bag of
words:

``` r
paragraphs_scrap(link = "https://ropensci.org/", collapse = TRUE)
#> [1] " We help develop R packages for the sciences via community driven learning, review and\nmaintenance of contributed software in the R ecosystem Use our carefully vetted, staff- and community-contributed R software tools that lower barriers to working with local and remote scientific data sources. Combine our tools with the rich ecosystem of R packages. Workflow Tools for Your Code and Data Get Data from the Web Convert and Munge Data Document and Release Your Data Visualize Data Work with Databases From R Access, Manipulate, Convert Geospatial Data Interact with Web Resources Use Image & Audio Data Analyze Scientific Papers (and Text in General) Secure Your Data and Workflow Handle and Transform Taxonomic Information Get inspired by real examples of how our packages can be used. Or browse scientific publications that cited our packages. Our suite of packages is comprised of contributions from staff engineers and the wider R\ncommunity via a transparent, constructive and open review process utilising GitHub's open\nsource infrastructure. We combine academic peer reviews with production software code reviews to create a\ntransparent, collaborative & more efficient review process\n   Based on best practices of software development and standards of R, its\napplications and user base. Our diverse community of academics, data scientists and developers provide a\nplatform for shared learning, collaboration and reproducible science We welcome you to join us and help improve tools and practices available to\nresearchers while receiving greater visibility to your contributions. You can\ncontribute with your packages, resources or post questions so our members will help\nyou along your process. Discover, learn and get involved in helping to shape the future of Data Science Join in our quarterly Community Calls with fellow developers and scientists - open\nto all Upcoming events including meetings at which our team members are speaking. The latest developments from rOpenSci and the wider R community Release notes, updates and package related developements A digest of R package and software review news, use cases, blog posts, and events, curated every two weeks. Subscribe to get it in your inbox, or check the archive. Happy rOpenSci users can be found at Except where otherwise noted, content on this site is licensed under the CC-BY license •\nPrivacy Policy"
```

## `weblink_scrap()`

`weblink_scrap()` is used to srape the web links available within a web
page. Useful in some cases, for example, getting a list of the available
PDFs:

``` r
weblink_scrap(link = "https://www.worldbank.org/en/access-to-information/reports/",
              contain = "PDF",
              case_sensitive = FALSE)
#>  [1] "http://pubdocs.worldbank.org/en/304561593192266592/pdf/A2i-2019-annual-report-FINAL.pdf"                         
#>  [2] "http://pubdocs.worldbank.org/en/539071573586305710/pdf/A2I-annual-report-2018-Final.pdf"                         
#>  [3] "http://pubdocs.worldbank.org/en/742661529439484831/WBG-AI-2017-annual-report.pdf"                                
#>  [4] "http://pubdocs.worldbank.org/en/814331507317964642/A2i-annualreport-2016.pdf"                                    
#>  [5] "http://pubdocs.worldbank.org/en/229551497905271134/Experience-18-month-report-Dec-2012.pdf"                      
#>  [6] "http://pubdocs.worldbank.org/en/835741505831037845/pdf/2016-AI-Survey-Report-Final.pdf"                          
#>  [7] "http://pubdocs.worldbank.org/en/698801505831644664/pdf/AI-Survey-written-comments-Final-2016.pdf"                
#>  [8] "http://pubdocs.worldbank.org/pubdocs/publicdoc/2016/3/150501459179518612/Write-in-comments-in-2015-AI-Survey.pdf"
#>  [9] "http://pubdocs.worldbank.org/pubdocs/publicdoc/2015/6/766701433971800319/Written-comments-in-2014-AI-Survey.pdf" 
#> [10] "http://pubdocs.worldbank.org/pubdocs/publicdoc/2015/6/512551434127742109/2013-AI-Survey-Written-comments.pdf"    
#> [11] "http://pubdocs.worldbank.org/pubdocs/publicdoc/2015/6/5361434129036318/2012-AI-Survey-Written-comments.pdf"      
#> [12] "http://pubdocs.worldbank.org/pubdocs/publicdoc/2015/6/168151434129035939/2011-AI-Survey-Written-comments.pdf"    
#> [13] "https://ppfdocuments.azureedge.net/e5c12f4e-7f50-44f7-a0d8-78614350f97cAnnex2.pdf"                               
#> [14] "http://pubdocs.worldbank.org/pubdocs/publicdoc/2016/4/785921460482892684/PPF-Mapping-AI-Policy.pdf"              
#> [15] "http://pubdocs.worldbank.org/pubdocs/publicdoc/2015/6/453041434139030640/AI-Interpretations.pdf"                 
#> [16] "http://pubdocs.worldbank.org/en/157711583443319835/pdf/Access-to-Information-Policy-Spanish.pdf"                 
#> [17] "http://pubdocs.worldbank.org/en/270371588347691497/pdf/Access-to-Information-Policy-Arabic.pdf"                  
#> [18] "http://pubdocs.worldbank.org/en/939471588348288176/pdf/Access-to-Information-Directive-Procedure-Arabic.pdf"     
#> [19] "http://pubdocs.worldbank.org/en/248301574182372360/World-Bank-consultations-guidelines.pdf"
```

## `images_scrap()` and `images_preview()`

`images_preview()` allows you to scrape the URLs of the images available
within a web page so that you can choose which images **extension** (see
below) you want to focus on.

Let’s say we want to list all the images from the official
[RStudio](https://rstudio.com/) website:

``` r
images_preview(link = "https://rstudio.com/")
#>  [1] "https://dc.ads.linkedin.com/collect/?pid=218281&fmt=gif"                                                                       
#>  [2] "https://www.facebook.com/tr?id=151855192184380&ev=PageView&noscript=1"                                                         
#>  [3] "https://d33wubrfki0l68.cloudfront.net/08b39bfcd76ebaf8360ed9135a50a2348fe2ed83/75738/assets/img/logo-white.svg"                
#>  [4] "https://d33wubrfki0l68.cloudfront.net/8bd479afc1037554e6218c41015a8e047b6af0f2/d1330/assets/img/libertymutual-logo-regular.png"
#>  [5] "https://d33wubrfki0l68.cloudfront.net/089844d0e19d6176a5c8ddff682b3bf47dbcb3dc/9ba69/assets/img/walmart-logo.png"              
#>  [6] "https://d33wubrfki0l68.cloudfront.net/a4ebff239e3de426fbb43c2e34159979f9214ce2/fabff/assets/img/janssen-logo-2.png"            
#>  [7] "https://d33wubrfki0l68.cloudfront.net/6fc5a4a8c3fa96eaf7c2dc829416c31d5dbdb514/0a559/assets/img/accenture-logo.png"            
#>  [8] "https://d33wubrfki0l68.cloudfront.net/d66c3b004735d83f205bc8a1c08dc39cc1ca5590/2b90b/assets/img/nasa-logo.png"                 
#>  [9] "https://d33wubrfki0l68.cloudfront.net/521a038ed009b97bf73eb0a653b1cb7e66645231/8e3fd/assets/img/rstudio-icon.png"              
#> [10] "https://d33wubrfki0l68.cloudfront.net/19dbfe44f79ee3249392a5effaa64e424785369e/91a7c/assets/img/connect-icon.png"              
#> [11] "https://d33wubrfki0l68.cloudfront.net/edf453f69b61f156d1d303c9ebe42ba8dc05e58a/213d1/assets/img/icon-rspm.png"                 
#> [12] "https://d33wubrfki0l68.cloudfront.net/62bcc8535a06077094ca3c29c383e37ad7334311/a263f/assets/img/logo.svg"                      
#> [13] "https://d33wubrfki0l68.cloudfront.net/9249ca7ba197318b488c0b295b94357694647802/6d33b/assets/img/logo-lockup.svg"               
#> [14] "https://d33wubrfki0l68.cloudfront.net/30ef84abbbcfbd7b025671ae74131762844e90a1/3392d/assets/img/bcorps-logo.svg"
```

`images_scrap()` on the other hand download the images. It takes the
following arguments:

-   **link**: The URL of the web page;

-   **imgpath**: The destination folder of your images. It defaults to
    `getwd()`

-   **extn**: the extension of the image: jpg, png, jpeg … among others;

-   **askRobot**: ask the robots.txt file if it’s permitted to scrape
    the web page.

In the following example we extract all the `png` images from
[RStudio](https://rstudio.com/) :

``` r
# Suppose we're in a project which has a folder called my_images:

images_scrap(link = "https://rstudio.com/",
             imgpath = here::here("my_images"),
             extn = "png") # without the .
```

# Accessibility related functions

## `images_noalt_scrap()`

> available only in the development version of the package

`images_noalt_scrap()` can be used to get the images within a specific
web page that don’t have an `alt` attribute which can be annoying for
people using a screen reader:

``` r
images_noalt_scrap(link = "https://www.r-consortium.org/")
#> [1] <img src="https://www.r-consortium.org/wp-content/themes/salient-child/images/logo_lf_projects_horizontal_2018.png">
```

If not images without `alt` attributes are found, the function returns
`NULL` and displays an indication message:

``` r
# WebAim is ther reference website for web accessibility

images_noalt_scrap(link = "https://webaim.org/techniques/forms/controls")
#> No images without 'alt' attribute found at: https://webaim.org/techniques/forms/controls
#> NULL
```

## Code of Conduct

Please note that the ralger project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
