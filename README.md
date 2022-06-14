
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
conjunction with `paste0()`. Suppose that you want to scrape all
`RStudio::conf 2021` speakers:

``` r
base_link <- "https://global.rstudio.com/student/catalog/list?category_ids=1796-speakers&page="

links <- paste0(base_link, 1:3) # the speakers are listed from page 1 to 3

node <- ".pr-1"


head(scrap(links, node), 10) # printing the first 10 speakers
#>  [1] "Hadley Wickham"    "Vicki Boykis"      "John Burn-Murdoch"
#>  [4] "Matt Thomas, "     "Mike Page"         "Ahmadou Dicko"    
#>  [7] "Shelmith Kariuki"  "Andrew Ba Tran"    "Michael Chow"     
#> [10] "Sean Lopp"
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
#>  [1] "navbar-brand logo" "nav-link"          NA                 
#>  [4] NA                  NA                  "nav-link"         
#>  [7] NA                  "nav-link"          NA                 
#> [10] NA
```

Another example, let’s we want to get all javascript dependencies within
the same web page:

``` r
js_depend <- attribute_scrap(link = "https://ropensci.org/", 
                             node = "script", 
                             attr = "src")

js_depend
#> [1] "https://cdn.jsdelivr.net/npm/cookieconsent@3/build/cookieconsent.min.js"                                                                                            
#> [2] "/scripts/matomo.js"                                                                                                                                                 
#> [3] "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"                                                                                                  
#> [4] "https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"                                                                                               
#> [5] "https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"                                                                                             
#> [6] "https://cdnjs.cloudflare.com/ajax/libs/fuse.js/6.4.6/fuse.js"                                                                                                       
#> [7] "https://cdnjs.cloudflare.com/ajax/libs/autocomplete.js/0.38.0/autocomplete.js"                                                                                      
#> [8] "/scripts/search.js"                                                                                                                                                 
#> [9] "https://ropensci.org/common.min.a685190e216b8a11a01166455cd0dd959a01aafdcb2fa8ed14871dafeaa4cf22cec232184079e5b6ba7360b77b0ee721d070ad07a24b83d454a3caf7d1efe371.js"
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
#> 1     1 Avatar                                     $2,847,397,339    2009
#> 2     2 Avengers: Endgame                          $2,797,501,328    2019
#> 3     3 Titanic                                    $2,201,647,264    1997
#> 4     4 Star Wars: Episode VII - The Force Awakens $2,069,521,700    2015
#> 5     5 Avengers: Infinity War                     $2,048,359,754    2018
#> 6     6 Spider-Man: No Way Home                    $1,901,216,740    2021
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
#> # A tibble: 50 × 3
#>    title                                         year   rating
#>    <chr>                                         <chr>  <chr> 
#>  1 The Shawshank Redemption                      (1994) 9.3   
#>  2 The Godfather                                 (1972) 9.2   
#>  3 The Dark Knight                               (2008) 9.0   
#>  4 The Lord of the Rings: The Return of the King (2003) 9.0   
#>  5 Schindler's List                              (1993) 9.0   
#>  6 The Godfather Part II                         (1974) 9.0   
#>  7 12 Angry Men                                  (1957) 9.0   
#>  8 Jai Bhim                                      (2021) 8.9   
#>  9 Pulp Fiction                                  (1994) 8.9   
#> 10 Inception                                     (2010) 8.8   
#> # … with 40 more rows
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
#>  [1] "Tracking the Coronavirus ›"                                                                     
#>  [2] "Site Information Navigation"                                                                    
#>  [3] "Ukraine Faces Hard Fight to Hold Key City as Last Bridge Is Blown"                              
#>  [4] "Wall Street Stabilizes in Bear Market Territory as Fed Decision Approaches"                     
#>  [5] "What some analysts are focused on after Wall Street’s meltdown."                                
#>  [6] "Why Gas Prices Are So High"                                                                     
#>  [7] "Jan. 6 House Committee Hearings"                                                                
#>  [8] "Panel Lays Out Case That Trump Created and Spread Election Lies"                                
#>  [9] "The Fractious Night That Began Trump’s Bid to Overturn the Election"                            
#> [10] "The Jan. 6 panel delayed a hearing scheduled for Wednesday to allow staff more time to prepare."
#> [11] "The Coronavirus Pandemic"                                                                       
#> [12] "For Its Next Zero Covid Chapter, China Turns to Mass Testing"                                   
#> [13] "F.D.A. Advisers Discuss Moderna Vaccine for Children Ages 6 to 17"                              
#> [14] "U.S. hot spots ›"                                                                               
#> [15] "Vaccinations ›"                                                                                 
#> [16] "Global hot spots ›"                                                                             
#> [17] "Cases rising fastest"                                                                           
#> [18] "Other trackers"                                                                                 
#> [19] "Cases rising fastest"                                                                           
#> [20] "Other trackers"                                                                                 
#> [21] "How Houston Moved 25,000 People From the Streets Into Their Own Homes"                          
#> [22] "If Housing Is a Health Care Issue, Should Medicaid Pay the Rent?"                               
#> [23] "Seeing the loss of housing as a collective challenge could guide a response."                   
#> [24] "Happy the Elephant Isn’t Legally a Person, New York’s Top Court Rules"                          
#> [25] "Entrances to Yellowstone Park Are Closed After Heavy Rain and Floods"                           
#> [26] "Risking Society’s Retribution, a Growing Numbers of Girls Resist Genital Cutting"               
#> [27] "Saving a Texan Bayou, ‘16 Bottles’ at a Time"                                                   
#> [28] "Our columnist shares 10 recipes that define Korean cuisine for him."                            
#> [29] "An offensive lyric nearly tarnished Lizzo’s reputation, but fans were “blown away” by her fix." 
#> [30] "Jamelle Bouie"                                                                                  
#> [31] "The Gerontocracy of the Democratic Party Doesn’t Understand That We’re at the Brink"            
#> [32] "This Is How It Feels to Be Russian Right Now. This Is How It Feels to Be Us."                   
#> [33] "Ben S. Bernanke"                                                                                
#> [34] "Inflation Isn’t Going to Bring Back the 1970s"                                                  
#> [35] "Paul Krugman"                                                                                   
#> [36] "What a Dying Lake Says About the Future"                                                        
#> [37] "Sohrab Ahmari, Patrick Deneen and Chad Pecknold"                                                
#> [38] "We Know How America Got Such a Corporate-Friendly Court"                                        
#> [39] "Daniela J. Lamas"                                                                               
#> [40] "America’s Hospitals Are in Transition"                                                          
#> [41] "Todd Tanner"                                                                                    
#> [42] "Don’t Add Curbs on Guns. But Repeal Liability Protections for Gun Makers and Sellers."          
#> [43] "Jagoda Marinic"                                                                                 
#> [44] "Germany’s Chancellor Promised to Deter Putin. Then He Did Nothing."                             
#> [45] "‘The Ezra Klein Show’"                                                                          
#> [46] "U.F.O.s, Trump and Twitter, and Biden 2024: Your Questions, Answered"                           
#> [47] "Gun Safety Plan: A ‘Band-Aid’ for a Hemorrhage"                                                 
#> [48] "Linda Kinstler"                                                                                 
#> [49] "‘The Aim of This Operation Is Genocide.’ Here’s What Putin Is Burning."                         
#> [50] "The Editorial Board"                                                                            
#> [51] "Kathy Hochul Is the Best Choice for Democrats in the June 28 Primary"                           
#> [52] "Aaron Timms"                                                                                    
#> [53] "What It Took for a Country With a Strong Gun Culture to Give Them Up"                           
#> [54] "Gail Collins and Bret Stephens"                                                                 
#> [55] "It’s Not Easy Being President"                                                                  
#> [56] "Deepta Bhattacharya"                                                                            
#> [57] "New Tools Can Make Our Covid Immunity Even Stronger"                                            
#> [58] "Margaret Renkl"                                                                                 
#> [59] "I Helped These Very Hungry Caterpillars Become Butterflies. Was That Wrong?"                    
#> [60] "Advertisement"                                                                                  
#> [61] "The Morning"                                                                                    
#> [62] "Listen to ‘The Daily’"                                                                          
#> [63] "Listen to ‘Popcast’"                                                                            
#> [64] "Tell Us How the Return to Office Is Going"                                                      
#> [65] "Biden Trip to Saudi Arabia Is Set for July, but Energy Help Is Not"                             
#> [66] "Britain Prepares to Send Asylum Seekers to Rwanda"                                              
#> [67] "What to Watch in Tuesday’s Primary Elections"                                                   
#> [68] "The Celtics Stopped Stephen Curry. Everyone Else Made Them Pay."                                
#> [69] "Zimbabwe Court Convicts Reporter for The New York Times"                                        
#> [70] "Massachusetts Court Throws Out Gig Worker Ballot Measure"                                       
#> [71] "Serena Williams Plans to Play in Wimbledon After Injury Last Year"                              
#> [72] "Officer Who Displayed Nazi Insignia Will Receive $1.5 Million to Resign"                        
#> [73] "Mashama Bailey and Owamni Win Top Honors at James Beard Awards"                                 
#> [74] "Amber Heard Says She Stands by ‘Every Word’ of Testimony in Defamation Trial"                   
#> [75] "Cambodia Sends U.S. Activist and Other Opposition Members to Prison"                            
#> [76] "Bloomberg News Employee Detained by China Has Been Released on Bail"                            
#> [77] "Advertisement"                                                                                  
#> [78] "Can Supplements Really Help With Depression or Anxiety?"                                        
#> [79] "How to Help a Loved One Having Suicidal Thoughts"                                               
#> [80] "Autistic Children Use  Virtual Reality to Navigate the World"                                   
#> [81] "This Is What Postpartum Anxiety Feels Like"                                                     
#> [82] "The Pandemic’s Lingering Effect: ‘Never-Ending’ Guilt"                                          
#> [83] "At the U.S. Open, Saving the House That Built Golf"                                             
#> [84] "Can Carbon Capture Be Part of the Climate Solution?"                                            
#> [85] "Never Missing a Curtain This Season, the Met Takes a Bow"                                       
#> [86] "Best of Late Night: Blaming It on the Alcohol"                                                  
#> [87] "How Do I Force My Landlord to Make Needed Repairs?"                                             
#> [88] "Advertisement"                                                                                  
#> [89] "Spelling Bee"                                                                                   
#> [90] "Wordle"                                                                                         
#> [91] "The Crossword"                                                                                  
#> [92] "Chess Replay"                                                                                   
#> [93] "New York Times Games"                                                                           
#> [94] "Letter Boxed"                                                                                   
#> [95] "Tiles"                                                                                          
#> [96] "Advertisement"
```

Further, it’s possible to filter the results using the `contain`
argument:

``` r
titles_scrap(link = "https://www.nytimes.com/", contain = "TrUMp", case_sensitive = FALSE)
#> [1] "Panel Lays Out Case That Trump Created and Spread Election Lies"         
#> [2] "The Fractious Night That Began Trump’s Bid to Overturn the Election"     
#> [3] "U.F.O.s, Trump and Twitter, and Biden 2024: Your Questions, Answered"    
#> [4] "Fealty to Trump Arises as Litmus Test in G.O.P. Debate for N.Y. Governor"
```

## `paragraphs_scrap()`

In the same way, we can use the `paragraphs_scrap()` function to extract
paragraphs. This function relies on the `p` HTML tag.

Let’s get some paragraphs from the lovely
[ropensci.org](https://ropensci.org/) website:

``` r
paragraphs_scrap(link = "https://ropensci.org/")
#>  [1] ""                                                                                                                                                                                                                                                                            
#>  [2] "\nWe help develop R packages for the sciences via community driven learning, review and\nmaintenance of contributed software in the R ecosystem\n"                                                                                                                           
#>  [3] "\nUse our carefully vetted, staff- and community-contributed R software tools that lower barriers to working with local and remote scientific data sources. Combine our tools with the rich ecosystem of R packages.\n"                                                      
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
#> [18] "\nOur suite of packages is comprised of contributions from staff engineers and the wider R\ncommunity via a transparent, constructive and open review process utilising GitHub's open\nsource infrastructure.\n"                                                             
#> [19] "\nWe combine academic peer reviews with production software code reviews to create a\ntransparent, collaborative & more efficient review process\n   "                                                                                                                       
#> [20] "\nBased on best practices of software development and standards of R, its\napplications and user base.\n"                                                                                                                                                                    
#> [21] "\nOur diverse community of academics, data scientists and developers provide a\nplatform for shared learning, collaboration and reproducible science\n"                                                                                                                      
#> [22] "\nWe welcome you to join us and help improve tools and practices available to\nresearchers while receiving greater visibility to your contributions. You can\ncontribute with your packages, resources or post questions so our members will help\nyou along your process.\n"
#> [23] "\nDiscover, learn and get involved in helping to shape the future of Data Science\n"                                                                                                                                                                                         
#> [24] "\nJoin in our quarterly Community Calls with fellow developers and scientists - open\nto all\n"                                                                                                                                                                              
#> [25] "\nUpcoming events including meetings at which our team members are speaking.\n"                                                                                                                                                                                              
#> [26] "The latest developments from rOpenSci and the wider R community"                                                                                                                                                                                                             
#> [27] "Release notes, updates and package related developements"                                                                                                                                                                                                                    
#> [28] "\nA digest of R package and software review news, use cases, blog posts, and events, curated monthly. Subscribe to get it in your inbox, or check the archive.\n"                                                                                                            
#> [29] "\nHappy rOpenSci users can be found at\n"                                                                                                                                                                                                                                    
#> [30] "\nExcept where otherwise noted, content on this site is licensed under the CC-BY license •\nPrivacy Policy\n"
```

If needed, it’s possible to collapse the paragraphs into one bag of
words:

``` r
paragraphs_scrap(link = "https://ropensci.org/", collapse = TRUE)
#> [1] " \nWe help develop R packages for the sciences via community driven learning, review and\nmaintenance of contributed software in the R ecosystem\n \nUse our carefully vetted, staff- and community-contributed R software tools that lower barriers to working with local and remote scientific data sources. Combine our tools with the rich ecosystem of R packages.\n Workflow Tools for Your Code and Data Get Data from the Web Convert and Munge Data Document and Release Your Data Visualize Data Work with Databases From R Access, Manipulate, Convert Geospatial Data Interact with Web Resources Use Image & Audio Data Analyze Scientific Papers (and Text in General) Secure Your Data and Workflow Handle and Transform Taxonomic Information Get inspired by real examples of how our packages can be used. Or browse scientific publications that cited our packages. \nOur suite of packages is comprised of contributions from staff engineers and the wider R\ncommunity via a transparent, constructive and open review process utilising GitHub's open\nsource infrastructure.\n \nWe combine academic peer reviews with production software code reviews to create a\ntransparent, collaborative & more efficient review process\n    \nBased on best practices of software development and standards of R, its\napplications and user base.\n \nOur diverse community of academics, data scientists and developers provide a\nplatform for shared learning, collaboration and reproducible science\n \nWe welcome you to join us and help improve tools and practices available to\nresearchers while receiving greater visibility to your contributions. You can\ncontribute with your packages, resources or post questions so our members will help\nyou along your process.\n \nDiscover, learn and get involved in helping to shape the future of Data Science\n \nJoin in our quarterly Community Calls with fellow developers and scientists - open\nto all\n \nUpcoming events including meetings at which our team members are speaking.\n The latest developments from rOpenSci and the wider R community Release notes, updates and package related developements \nA digest of R package and software review news, use cases, blog posts, and events, curated monthly. Subscribe to get it in your inbox, or check the archive.\n \nHappy rOpenSci users can be found at\n \nExcept where otherwise noted, content on this site is licensed under the CC-BY license •\nPrivacy Policy\n"
```

## `weblink_scrap()`

`weblink_scrap()` is used to srape the web links available within a web
page. Useful in some cases, for example, getting a list of the available
PDFs:

``` r
weblink_scrap(link = "https://www.worldbank.org/en/access-to-information/reports/",
              contain = "PDF",
              case_sensitive = FALSE)
#>  [1] "https://thedocs.worldbank.org/en/doc/142b0dab31674dfda9092a5ff75f8839-0090012021/original/Access-to-Infromation-FY20-annual-report.pdf"                  
#>  [2] "https://pubdocs.worldbank.org/en/304561593192266592/pdf/A2i-2019-annual-report-FINAL.pdf"                                                                
#>  [3] "https://pubdocs.worldbank.org/en/539071573586305710/pdf/A2I-annual-report-2018-Final.pdf"                                                                
#>  [4] "https://pubdocs.worldbank.org/en/742661529439484831/WBG-AI-2017-annual-report.pdf"                                                                       
#>  [5] "https://thedocs.worldbank.org/en/doc/37f0a0f7158d36ceba6dced594e0941b-0090012017/original/Access-to-Information-2016-annual-report.pdf"                  
#>  [6] "https://thedocs.worldbank.org/en/doc/271c77cc992b371a5483b1a673a7e585-0090012012/original/18-month-report-Dec-2012.pdf"                                  
#>  [7] "https://thedocs.worldbank.org/en/doc/73c97ee6cfadac12ad3707b94a17c5f5-0090012016/original/2016-AI-Survey-Report-Final.pdf"                               
#>  [8] "https://thedocs.worldbank.org/en/doc/12089854b2021eab67813ac3848bec80-0090012016/original/Write-in-comments-AI-Survey-2016.pdf"                          
#>  [9] "https://thedocs.worldbank.org/en/doc/d86a6fa48d020ec4a4bccca3fbb8e7c0-0090012015/original/Write-in-comments-AI-Survey-2015.pdf"                          
#> [10] "https://thedocs.worldbank.org/en/doc/62c28144331b0da23493528701e98ef6-0090012014/original/2014-AI-Survey-Written-comments.pdf"                           
#> [11] "https://thedocs.worldbank.org/en/doc/e376a3efb71bd6992e9effd802c03a16-0090012013/original/2013-AI-Survey-Written-comments.pdf"                           
#> [12] "https://thedocs.worldbank.org/en/doc/72a6e671a0bad69a7bfa47e49b2ae66c-0090012012/original/2012-AI-Survey-Written-comments.pdf"                           
#> [13] "https://thedocs.worldbank.org/en/doc/cd0c45e42c81512e7097199a87535815-0090012011/original/2011-AI-Survey-Written-comments.pdf"                           
#> [14] "https://ppfdocuments.azureedge.net/e5c12f4e-7f50-44f7-a0d8-78614350f97cAnnex2.pdf"                                                                       
#> [15] "https://thedocs.worldbank.org/en/doc/f0f3591783459d7180c63031952926b0-0090012021/original/Atttachment-C-Guidance-for-Clients-Partners-FINAL-4-1-2011.pdf"
#> [16] "https://thedocs.worldbank.org/en/doc/3381060fb1b8d4f07813f5e9bb5f7998-0090012015/original/PPF-Mapping-AI-Policy.pdf"                                     
#> [17] "https://thedocs.worldbank.org/en/doc/66cf8f975d74166e1e38994df4c525b4-0090012021/original/AI-Interpretations.pdf"                                        
#> [18] "https://pubdocs.worldbank.org/en/270371588347691497/pdf/Access-to-Information-Policy-Arabic.pdf"                                                         
#> [19] "https://thedocs.worldbank.org/en/doc/ef071720690bb6c89776d517e61cdf21-0090012021/original/2020001878SPAspa001-Access-to-Information.pdf"                 
#> [20] "https://thedocs.worldbank.org/en/doc/80b3b3a77e393ec0037a1423a75ba636-0090012021/original/Access-to-Information-Policy-Chinese.pdf"                      
#> [21] "https://thedocs.worldbank.org/en/doc/f0385d282839e81d30ea1a5f5c58ae62-0090012021/original/2021002699FREfre001-Access-to-Information-Policy.pdf"          
#> [22] "https://thedocs.worldbank.org/en/doc/037289eeabe873a3ef5333ff84b7fd16-0090012021/original/2021002699BRAbra001-Access-to-Information-Policy.pdf"          
#> [23] "https://thedocs.worldbank.org/en/doc/d33b6d9c76a74b49f46d340356944428-0090012021/original/2020002699RUSrus001-Access-to-Information-Policy.pdf"          
#> [24] "https://thedocs.worldbank.org/en/doc/cd11ab063135a060e9bb485394126755-0090012021/original/2020002217ARAara002-Bank-Directive-Procedure.pdf"              
#> [25] "https://thedocs.worldbank.org/en/doc/262f4c625213d09b7eca2969a9afa65e-0090012021/original/2020001878SPAspa002-Access-to-Information-Directive.pdf"       
#> [26] "https://thedocs.worldbank.org/en/doc/1e72e7e8cc2794fad2b8c283b31714e3-0090012021/original/Access-to-Information-Directive-Procedure-Chinese.pdf"         
#> [27] "https://thedocs.worldbank.org/en/doc/3db68ad4e1266899a8bd785c28532a26-0090012021/original/2021002699FREfre002-Access-to-Information-Directive.pdf"       
#> [28] "https://thedocs.worldbank.org/en/doc/18fd3f2d8f00f821d9ea8abe9f2f378b-0090012021/original/2021002699BRAbra002-Access-to-Information-Directive.pdf"       
#> [29] "https://thedocs.worldbank.org/en/doc/5b94bae1ae338622cb6053fb565026a8-0090012021/original/2020002699RUSrus002-Access-to-Information-Directive.pdf"       
#> [30] "https://pubdocs.worldbank.org/en/248301574182372360/World-Bank-consultations-guidelines.pdf"
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
#>  [3] "https://www.rstudio.com/assets/img/logo.svg"                                                                             
#>  [4] "https://d33wubrfki0l68.cloudfront.net/67940f370880b23384e582bf3065b0143d0752a0/4c8d2/assets/img/acad-icon_training.svg"  
#>  [5] "https://d33wubrfki0l68.cloudfront.net/8522ca6e5816b0ccbfa04ca4194f9c058ffcff02/7f904/assets/img/acad-icon_milestones.svg"
#>  [6] "https://d33wubrfki0l68.cloudfront.net/605bd8ecb0e2985159315eecee09e4426ba7efe2/906a3/assets/img/acad-icon_calendar.svg"  
#>  [7] "https://d33wubrfki0l68.cloudfront.net/8756f1a22dabd9f7d2f5e6f4c20e3363f795cfe4/a4762/assets/img/acad-icon_mentor.svg"    
#>  [8] "https://d33wubrfki0l68.cloudfront.net/521a038ed009b97bf73eb0a653b1cb7e66645231/8e3fd/assets/img/rstudio-icon.png"        
#>  [9] "https://d33wubrfki0l68.cloudfront.net/19dbfe44f79ee3249392a5effaa64e424785369e/91a7c/assets/img/connect-icon.png"        
#> [10] "https://d33wubrfki0l68.cloudfront.net/edf453f69b61f156d1d303c9ebe42ba8dc05e58a/213d1/assets/img/icon-rspm.png"           
#> [11] "https://d33wubrfki0l68.cloudfront.net/62bcc8535a06077094ca3c29c383e37ad7334311/a263f/assets/img/logo.svg"                
#> [12] "https://d33wubrfki0l68.cloudfront.net/9249ca7ba197318b488c0b295b94357694647802/6d33b/assets/img/logo-lockup.svg"         
#> [13] "https://d33wubrfki0l68.cloudfront.net/30ef84abbbcfbd7b025671ae74131762844e90a1/3392d/assets/img/bcorps-logo.svg"
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

`images_noalt_scrap()` can be used to get the images within a specific
web page that don’t have an `alt` attribute which can be annoying for
people using a screen reader:

``` r
images_noalt_scrap(link = "https://www.r-consortium.org/")
#> [1] <img src="https://www.r-consortium.org/wp-content/themes/salient-child/images/logo_lf_projects_horizontal_2018.png">
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
