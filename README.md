
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
[![Travis build
status](https://travis-ci.com/feddelegrand7/ralger.svg?branch=master)](https://travis-ci.com/feddelegrand7/ralger)
[![R
badge](https://img.shields.io/badge/Build%20with-♥%20and%20R-blue)](https://github.com/feddelegrand7/ralger)
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

## scrap()

This is an example which shows how to extract firms’ denomination from
the website of the [Algerian Chamber of Commerce and
Industry](http://elmouchir.caci.dz) (CACI). For simplicity, we’ll focus
on firms operating within the capital (Algiers).

``` r
library(ralger)

my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver"

my_node <- ".listing_default" # The CSS class, we recommend SelectorGadget

scrap(link = my_link, node = my_node)
#>  [1] "Adjerid Hanifa"                                                               
#>  [2] "Dar Chamila"                                                                  
#>  [3] "BNP Paribas / Agences Alger Bordj El Kiffan"                                  
#>  [4] "TVA / Touring Voyages Algérie Centre / Zighoud Youcef"                        
#>  [5] "SAMRIA AUTO / Salon Algerian du Materiel Roulant et de L'industrie Automobile"
#>  [6] "YOUKAIS"                                                                      
#>  [7] "EDIMETAL"                                                                     
#>  [8] "SYRIAN AIR LINES"                                                             
#>  [9] "Turkish Airlines / Direction Générale"                                        
#> [10] "Aigle Azur / Agence Didouche Mourad"                                          
#> [11] "British Airways"                                                              
#> [12] "Cabinet Ammiche Amer"                                                         
#> [13] "VERITEX"                                                                      
#> [14] "Kermiche Partener"                                                            
#> [15] "Marine Soft"                                                                  
#> [16] "PROGOS"                                                                       
#> [17] "Ambassade du Royaume d'Arabie Saoudite"                                       
#> [18] "Ambassade de la République d'Argentine"                                       
#> [19] "Ambassade du Burkina Faso"                                                    
#> [20] "Ambassade du Canada"
```

If you want to scrap multiple list pages, just use `scrap()` in
conjunction with `paste0()`. Suppose, we want to extract the above
information from the first 3 pages (starts from 0):

``` r
my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=" 

my_node <- ".listing_default"

scrap(link = paste0(my_link, 0:2), node = my_node)
#>  [1] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#>  [2] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#>  [3] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#>  [4] "VERITAL/ Direction Générale"                                                                                                   
#>  [5] "Wilaya d'Alger"                                                                                                                
#>  [6] "Officine Abeille"                                                                                                              
#>  [7] "Twingle"                                                                                                                       
#>  [8] "FCM"                                                                                                                           
#>  [9] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [10] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [11] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [12] "Conseil Constitutionnel"                                                                                                       
#> [13] "Ambassade de la République de Serbie"                                                                                          
#> [14] "Conseil de la Nation"                                                                                                          
#> [15] "Radio El Bahdja"                                                                                                               
#> [16] "Radio Mitidja"                                                                                                                 
#> [17] "Mina Sport"                                                                                                                    
#> [18] "Geete Services Industries"                                                                                                     
#> [19] "Ambassade De Pologne"                                                                                                          
#> [20] "LHC/ Laboratoire de l'Habitat & de Construction Alger"                                                                         
#> [21] "Adjerid Hanifa"                                                                                                                
#> [22] "Dar Chamila"                                                                                                                   
#> [23] "BNP Paribas / Agences Alger Bordj El Kiffan"                                                                                   
#> [24] "TVA / Touring Voyages Algérie Centre / Zighoud Youcef"                                                                         
#> [25] "SAMRIA AUTO / Salon Algerian du Materiel Roulant et de L'industrie Automobile"                                                 
#> [26] "YOUKAIS"                                                                                                                       
#> [27] "EDIMETAL"                                                                                                                      
#> [28] "SYRIAN AIR LINES"                                                                                                              
#> [29] "Turkish Airlines / Direction Générale"                                                                                         
#> [30] "Aigle Azur / Agence Didouche Mourad"                                                                                           
#> [31] "British Airways"                                                                                                               
#> [32] "Cabinet Ammiche Amer"                                                                                                          
#> [33] "VERITEX"                                                                                                                       
#> [34] "Kermiche Partener"                                                                                                             
#> [35] "Marine Soft"                                                                                                                   
#> [36] "PROGOS"                                                                                                                        
#> [37] "Ambassade du Royaume d'Arabie Saoudite"                                                                                        
#> [38] "Ambassade de la République d'Argentine"                                                                                        
#> [39] "Ambassade du Burkina Faso"                                                                                                     
#> [40] "Ambassade du Canada"                                                                                                           
#> [41] "Ambassade de la République de Corée"                                                                                           
#> [42] "Ambassade de la République de Côte d'Ivoire"                                                                                   
#> [43] "Ambassade des Emirats Arabes Unis"                                                                                             
#> [44] "Ambassade du Royaume d'Espagne"                                                                                                
#> [45] "Ambassade des Etats Unis d’Amérique"                                                                                           
#> [46] "Ambassade de la République de Guinée Bissau"                                                                                   
#> [47] "Ambassade du Royaume Hachémite de Jordanie"                                                                                    
#> [48] "ONDA / Office National des Droits d'Auteurs"                                                                                   
#> [49] "Ambassade de la République du Mali"                                                                                            
#> [50] "Ambassade du Royaume du Maroc"                                                                                                 
#> [51] "Ambassade de la République du Niger"                                                                                           
#> [52] "Ambassade de la République Islamique du Pakistan"                                                                              
#> [53] "RPL / Réseaux Poids Lourds"                                                                                                    
#> [54] "Ambassade de l'Etat de Palestine"                                                                                              
#> [55] "Ambassade du Royaume de Suède"                                                                                                 
#> [56] "Ambassade de la République Yemenite"                                                                                           
#> [57] "Ambassade de la République Démocratique du Congo"                                                                              
#> [58] "Ambassade de la République Arabe Sahraouie Démocratique"                                                                       
#> [59] "Ambassade de la République Fédérale du Nigeria"                                                                                
#> [60] "Ambassade du Sultanat d'Oman"
```

Thanks to the [robotstxt](https://github.com/ropensci/robotstxt), you
can set `askRobot = T` to ask the `robots.txt` file if it’s permitted to
scrape a specific web page.

## table\_scrap()

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
#> 3    3                                    Titanic $2,195,170,133 1997
#> 4    4 Star Wars: Episode VII - The Force Awakens $2,068,454,133 2015
#> 5    5                     Avengers: Infinity War $2,048,359,754 2018
#> 6    6                             Jurassic World $1,670,401,444 2015
```

**When you deal with a web page that contains many HTML table you can
use the `choose` argument to target a specific table**

## tidy\_scrap()

Sometimes you’ll find some useful information on the internet that you
want to extract in a tabular manner however these information are not
provided in an HTML format. In this context, you can use the
`tidy_scrap()` function which returns a tidy data frame according to the
arguments that you introduce. The function takes four arguments:

  - **link** : the link of the website you’re interested for;
  - **nodes**: a vector of CSS elements that you want to extract. These
    elements will form the columns of your data frame;
  - **colnames**: this argument represents the vector of names you want
    to assign to your columns. Note that you should respect the same
    order as within the **nodes** vector;
  - **clean**: if true the function will clean the tibble’s columns;
  - **askRobot**: ask the robots.txt file if it’s permitted to scrape
    the web page.

### Example

We’ll work on the famous [IMDb website](https://www.imdb.com/). Let’s
say we need a data frame composed of:

  - The title of the 50 best ranked movies of all time
  - Their release year
  - Their rating

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
#>  5 The Lord of the Rings: The Return of the King (2003) 8.9   
#>  6 Pulp Fiction                                  (1994) 8.9   
#>  7 Schindler's List                              (1993) 8.9   
#>  8 12 Angry Men                                  (1957) 8.9   
#>  9 Inception                                     (2010) 8.8   
#> 10 Fight Club                                    (1999) 8.8   
#> # ... with 40 more rows
```

Note that all columns will be of *character* class. you’ll have to
convert them according to your needs.

## titles\_scrap()

Using `titles_scrap()`, one can efficiently scrape titles which
correspond to the *h1, h2 & h3* HTML tags.

### Example

If we go to the [New York Times](https://www.nytimes.com/), we can
easily extract the titles displayed within a specific web page :

``` r


titles_scrap(link = "https://www.nytimes.com/")
#>  [1] " Live Updates "                                                                                                                                                                                                                                                                                                                      
#>  [2] " See full presidential results "                                                                                                                                                                                                                                                                                                     
#>  [3] " Key States "                                                                                                                                                                                                                                                                                                                        
#>  [4] "U.S. Surpasses 10 Million Coronavirus Cases"                                                                                                                                                                                                                                                                                         
#>  [5] "An Explanation for Some Covid-19 Deaths May Not Be Holding Up"                                                                                                                                                                                                                                                                       
#>  [6] "Alex Trebek, Longtime Host of ‘Jeopardy!,’ Dies at 80"                                                                                                                                                                                                                                                                               
#>  [7] "O Captain, My ‘Jeopardy!’ Captain"                                                                                                                                                                                                                                                                                                   
#>  [8] "“We have no idea what the show is going to be without him.” Fans mourned the loss of Alex Trebek."                                                                                                                                                                                                                                   
#>  [9] "Making It Work"                                                                                                                                                                                                                                                                                                                      
#> [10] "Yes, it is possible to buy a good used computer online. Here’s how."                                                                                                                                                                                                                                                                 
#> [11] "If you’re on edge, try taking a controlled breath."                                                                                                                                                                                                                                                                                  
#> [12] "The Weekender"                                                                                                                                                                                                                                                                                                                       
#> [13] "Did you follow the news this week? Take our quiz."                                                                                                                                                                                                                                                                                   
#> [14] "We Hereby Dump Trump"                                                                                                                                                                                                                                                                                                                
#> [15] "What Alex Trebek Was Really Like"                                                                                                                                                                                                                                                                                                    
#> [16] "Black Empowerment Outside the Headlines"                                                                                                                                                                                                                                                                                             
#> [17] "The Human Experience Will Not Be Quantified"                                                                                                                                                                                                                                                                                         
#> [18] "Elections Don’t Have to Be So Chaotic and Excruciating"                                                                                                                                                                                                                                                                              
#> [19] "A Loving Chastisement for America"                                                                                                                                                                                                                                                                                                   
#> [20] "Victory for Joe Biden, at Last"                                                                                                                                                                                                                                                                                                      
#> [21] "Is There a Trumpism After Trump?"                                                                                                                                                                                                                                                                                                    
#> [22] "A Black Hero in the Jim Crow Navy"                                                                                                                                                                                                                                                                                                   
#> [23] "Biden Can’t Be F.D.R. He Could Still Be L.B.J."                                                                                                                                                                                                                                                                                      
#> [24] "Why You Should Brave the ‘Bad’ Weather"                                                                                                                                                                                                                                                                                              
#> [25] "When the Virus Came for the American Dream"                                                                                                                                                                                                                                                                                          
#> [26] "Cardi B’s ‘WAP’ Proves Censorship Is Good Business"                                                                                                                                                                                                                                                                                  
#> [27] "Review: ‘How to Make a Slave’ Offers Restless Thoughts About Race"                                                                                                                                                                                                                                                                   
#> [28] "Site Index"                                                                                                                                                                                                                                                                                                                          
#> [29] "Site Information Navigation"                                                                                                                                                                                                                                                                                                         
#> [30] "As Biden Plans for Day 1, G.O.P. Navigates Trump’s Refusal to Concede"                                                                                                                                                                                                                                                               
#> [31] "George W. Bush Congratulates Biden"                                                                                                                                                                                                                                                                                                  
#> [32] ".css-11f6h48{margin-right:5px;}.css-11f6h48:hover{border-bottom:1px solid #e2e2e2;}Biden won her state, but her Uncle Sam protest costume isn’t going in storage..css-m7dmkp{font-family:nyt-franklin,helvetica,arial,sans-serif;color:#d0021b;font-weight:600;font-size:0.75rem;line-height:0.8125rem;display:inline-block;}26m ago"
#> [33] "Putin is silent on Biden’s victory, foreshadowing tense years ahead.1h ago"                                                                                                                                                                                                                                                          
#> [34] "Christian conservatives reflect on Trump’s loss and look ahead.2h ago"                                                                                                                                                                                                                                                               
#> [35] "Here are 5 things the Biden administration could do quickly on the environment.2h ago"                                                                                                                                                                                                                                               
#> [36] "President"                                                                                                                                                                                                                                                                                                                           
#> [37] "Senate"                                                                                                                                                                                                                                                                                                                              
#> [38] "House"                                                                                                                                                                                                                                                                                                                               
#> [39] "Senate"                                                                                                                                                                                                                                                                                                                              
#> [40] "House"                                                                                                                                                                                                                                                                                                                               
#> [41] "Can Joe Biden and Mitch McConnell Get It Done?"                                                                                                                                                                                                                                                                                      
#> [42] "Why the Biden Economy Could Be the Same Long Slog as the Obama Economy"                                                                                                                                                                                                                                                              
#> [43] "Kamala Harris’s ancestral village in India rejoiced, but many wondered what changes may come."                                                                                                                                                                                                                                       
#> [44] "‘It’s Such a Relief’: Biden Voters Rebuild a Wall That Trump Smashed"                                                                                                                                                                                                                                                                
#> [45] "As a Bitter Election Ends, 26 Americans Look to the Future"                                                                                                                                                                                                                                                                          
#> [46] "Christian Conservatives Respond to Trump’s Loss and Look Ahead"                                                                                                                                                                                                                                                                      
#> [47] "For 9 of 10 Voters, Protests Over Police Violence Played Role in Their Choice"                                                                                                                                                                                                                                                       
#> [48] "What’s Next for Trump? Family Business Awaits His Return"                                                                                                                                                                                                                                                                            
#> [49] "Georgia, From Reliably Republican to Political Ground Zero"                                                                                                                                                                                                                                                                          
#> [50] "How Biden Flipped Pennsylvania and Won the Election"                                                                                                                                                                                                                                                                                 
#> [51] "Here’s an overview of Joe Biden’s positions on coronavirus, health care, the economy, taxes and climate change."                                                                                                                                                                                                                     
#> [52] "AT HOME"                                                                                                                                                                                                                                                                                                                             
#> [53] "Opinion"                                                                                                                                                                                                                                                                                                                             
#> [54] "Editors’ Picks"                                                                                                                                                                                                                                                                                                                      
#> [55] "Advertisement"
```

Further, it’s possible to filter the results using the `contain`
argument:

``` r

titles_scrap(link = "https://www.nytimes.com/", contain = "TrUMp", case_sensitive = FALSE)
#> [1] "We Hereby Dump Trump"                                                 
#> [2] "Is There a Trumpism After Trump?"                                     
#> [3] "‘Saturday Night Live’ Sends Off Trump With a Ballad"                  
#> [4] "As Biden Plans for Day 1, G.O.P. Navigates Trump’s Refusal to Concede"
#> [5] "Christian conservatives reflect on Trump’s loss and look ahead.1h ago"
#> [6] "‘It’s Such a Relief’: Biden Voters Rebuild a Wall That Trump Smashed" 
#> [7] "Christian Conservatives Respond to Trump’s Loss and Look Ahead"       
#> [8] "What’s Next for Trump? Family Business Awaits His Return"
```

## paragraphs\_scrap()

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
#> [20] "Based on best practices of software development and standards of R, it’s\napplications and user base."                                                                                                                                                                   
#> [21] "Our diverse community of academics, data scientists and developers provide a\nplatform for shared learning, collaboration and reporoducible science"                                                                                                                     
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
#> [1] " We help develop R packages for the sciences via community driven learning, review and\nmaintenance of contributed software in the R ecosystem Use our carefully vetted, staff- and community-contributed R software tools that lower barriers to working with local and remote scientific data sources. Combine our tools with the rich ecosystem of R packages. Workflow Tools for Your Code and Data Get Data from the Web Convert and Munge Data Document and Release Your Data Visualize Data Work with Databases From R Access, Manipulate, Convert Geospatial Data Interact with Web Resources Use Image & Audio Data Analyze Scientific Papers (and Text in General) Secure Your Data and Workflow Handle and Transform Taxonomic Information Get inspired by real examples of how our packages can be used. Or browse scientific publications that cited our packages. Our suite of packages is comprised of contributions from staff engineers and the wider R\ncommunity via a transparent, constructive and open review process utilising GitHub's open\nsource infrastructure. We combine academic peer reviews with production software code reviews to create a\ntransparent, collaborative & more efficient review process\n   Based on best practices of software development and standards of R, it’s\napplications and user base. Our diverse community of academics, data scientists and developers provide a\nplatform for shared learning, collaboration and reporoducible science We welcome you to join us and help improve tools and practices available to\nresearchers while receiving greater visibility to your contributions. You can\ncontribute with your packages, resources or post questions so our members will help\nyou along your process. Discover, learn and get involved in helping to shape the future of Data Science Join in our quarterly Community Calls with fellow developers and scientists - open\nto all Upcoming events including meetings at which our team members are speaking. The latest developments from rOpenSci and the wider R community Release notes, updates and package related developements A digest of R package and software review news, use cases, blog posts, and events, curated every two weeks. Subscribe to get it in your inbox, or check the archive. Happy rOpenSci users can be found at Except where otherwise noted, content on this site is licensed under the CC-BY license •\nPrivacy Policy"
```

## weblink\_scrap()

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

## Code of Conduct

Please note that the ralger project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
