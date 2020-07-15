
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ralger <a><img src='man/figures/hex.png' align="right" height="200" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/ralger)](https://cran.r-project.org/package=ralger)

<!-- badges: end -->

[![](http://cranlogs.r-pkg.org/badges/grand-total/ralger?color=blue)](https://cran.r-project.org/package=ralger)

The goal of **ralger** is to facilitate web scraping in R.

## Installation

You can install the ralger package from
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

This is an example which shows how to extract firms denomination from
the website of the [Algerian Chamber of Commerce and
Industry](http://elmouchir.caci.dz) (CACI). For simplicity, we’ll focus
on firms operating within the capital (Algiers).

``` r
library(ralger)

my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver"

my_node <- ".listing_default" # The CSS element, we recommend SelectorGadget

scrap(my_link, my_node)
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
#> [12] "DELTA"                                                                        
#> [13] "Cabinet Ammiche Amer"                                                         
#> [14] "VERITEX"                                                                      
#> [15] "Kermiche Partener"                                                            
#> [16] "Marine Soft"                                                                  
#> [17] "PROGOS"                                                                       
#> [18] "Ambassade du Royaume d'Arabie Saoudite"                                       
#> [19] "Ambassade de la République d'Argentine"                                       
#> [20] "Ambassade du Burkina Faso"
```

If you want to scrap multiple list pages, just use `scrap()` in
conjunction with `paste()`. Suppose, we want to extract the above
information from the first 3 pages (starts from 0):

``` r
my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=" 

my_node <- ".listing_default"

scrap(paste(my_link, 0:2), my_node)
#>  [1] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#>  [2] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#>  [3] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#>  [4] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#>  [5] "Clef du Sud / Miftah El Djanoub"                                                                                               
#>  [6] "MPV"                                                                                                                           
#>  [7] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#>  [8] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#>  [9] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [10] "VERITAL/ Direction Générale"                                                                                                   
#> [11] "Wilaya d'Alger"                                                                                                                
#> [12] "Officine Abeille"                                                                                                              
#> [13] "Twingle"                                                                                                                       
#> [14] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [15] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [16] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [17] "Conseil Constitutionnel"                                                                                                       
#> [18] "Ambassade de la République de Serbie"                                                                                          
#> [19] "Conseil de la Nation"                                                                                                          
#> [20] "Radio El Bahdja"                                                                                                               
#> [21] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#> [22] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#> [23] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#> [24] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#> [25] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [26] "MPV"                                                                                                                           
#> [27] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [28] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [29] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [30] "VERITAL/ Direction Générale"                                                                                                   
#> [31] "Wilaya d'Alger"                                                                                                                
#> [32] "Officine Abeille"                                                                                                              
#> [33] "Twingle"                                                                                                                       
#> [34] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [35] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [36] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [37] "Conseil Constitutionnel"                                                                                                       
#> [38] "Ambassade de la République de Serbie"                                                                                          
#> [39] "Conseil de la Nation"                                                                                                          
#> [40] "Radio El Bahdja"                                                                                                               
#> [41] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#> [42] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#> [43] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#> [44] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#> [45] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [46] "MPV"                                                                                                                           
#> [47] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [48] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [49] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [50] "VERITAL/ Direction Générale"                                                                                                   
#> [51] "Wilaya d'Alger"                                                                                                                
#> [52] "Officine Abeille"                                                                                                              
#> [53] "Twingle"                                                                                                                       
#> [54] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [55] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [56] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [57] "Conseil Constitutionnel"                                                                                                       
#> [58] "Ambassade de la République de Serbie"                                                                                          
#> [59] "Conseil de la Nation"                                                                                                          
#> [60] "Radio El Bahdja"
```

# table\_scrap()

If you want to extrang an **HTML Table**, you can use the
`table_scrap()` function. Take a look at this
[webpage](https://www.boxofficemojo.com/chart/top_lifetime_gross/?area=XWW)
which lists the highest gross revenues in the cinema industry. You can
extract the HTML table as follows:

``` r


data <- table_scrap(link ="https://www.boxofficemojo.com/chart/top_lifetime_gross/?area=XWW")

head(data)
#>   Rank                                      Title Lifetime Gross Year
#> 1    1                          Avengers: Endgame $2,797,800,564 2019
#> 2    2                                     Avatar $2,790,439,000 2009
#> 3    3                                    Titanic $2,196,043,167 1997
#> 4    4 Star Wars: Episode VII - The Force Awakens $2,068,223,624 2015
#> 5    5                     Avengers: Infinity War $2,048,359,754 2018
#> 6    6                              Black Panther $2,047,313,161 2018
```

## tidy\_scrap()

Sometimes you’ll find some useful information on the internet that you
want to extract in a tabular manner however these information are not
provided in an HTML format. In this context, you can use the
`tidy_scrap()` function which returns a tidy data frame according to the
arguments that you introduce. The function takes four arguments:

  - **link** : the link of the website you’re interested for
  - **nodes**: a vector of CSS elements that you want to extract. These
    elements will form the columns of your dataframe
  - **colnames**: this argument represents the vector of names you want
    to assign to your columns. Note that you should respect the same
    order as within the **nodes** vector
  - **clean**: if true the function will clean the tibble’s columns.

### Example

We’ll work on the famous [IMDb website](https://www.imdb.com/). Let’s
say we need a dataframe composed of:

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


tidy_scrap(my_link, my_nodes, colnames = names)
#> Warning: The `x` argument of `as_tibble.matrix()` must have unique column names if `.name_repair` is omitted as of tibble 2.0.0.
#> Using compatibility `.name_repair`.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_warnings()` to see where this warning was generated.
#> Warning: `...` is not empty.
#> 
#> We detected these problematic arguments:
#> * `needs_dots`
#> 
#> These dots only exist to allow future extensions and should be empty.
#> Did you misspecify an argument?
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

## Code of Conduct

Please note that the ralger project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
