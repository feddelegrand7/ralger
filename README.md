
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
#>  [1] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#>  [2] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#>  [3] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#>  [4] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#>  [5] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#>  [6] "Clef du Sud / Miftah El Djanoub"                                                                                               
#>  [7] "MPV"                                                                                                                           
#>  [8] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#>  [9] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [10] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [11] "VERITAL/ Direction Générale"                                                                                                   
#> [12] "Wilaya d'Alger"                                                                                                                
#> [13] "Officine Abeille"                                                                                                              
#> [14] "Twingle"                                                                                                                       
#> [15] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [16] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [17] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [18] "Conseil Constitutionnel"                                                                                                       
#> [19] "Ambassade de la République de Serbie"                                                                                          
#> [20] "Conseil de la Nation"                                                                                                          
#> [21] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#> [22] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#> [23] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#> [24] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#> [25] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#> [26] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [27] "MPV"                                                                                                                           
#> [28] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [29] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [30] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [31] "VERITAL/ Direction Générale"                                                                                                   
#> [32] "Wilaya d'Alger"                                                                                                                
#> [33] "Officine Abeille"                                                                                                              
#> [34] "Twingle"                                                                                                                       
#> [35] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [36] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [37] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [38] "Conseil Constitutionnel"                                                                                                       
#> [39] "Ambassade de la République de Serbie"                                                                                          
#> [40] "Conseil de la Nation"                                                                                                          
#> [41] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#> [42] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#> [43] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#> [44] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#> [45] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#> [46] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [47] "MPV"                                                                                                                           
#> [48] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [49] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [50] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [51] "VERITAL/ Direction Générale"                                                                                                   
#> [52] "Wilaya d'Alger"                                                                                                                
#> [53] "Officine Abeille"                                                                                                              
#> [54] "Twingle"                                                                                                                       
#> [55] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [56] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [57] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [58] "Conseil Constitutionnel"                                                                                                       
#> [59] "Ambassade de la République de Serbie"                                                                                          
#> [60] "Conseil de la Nation"
```

## tidy\_scrap()

If you want to extract a dataframe from a web page, you can use the
`tidy_scrap()` function which returns a tidy dataframe according to the
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
#> Warning: The `x` argument of `as_tibble.matrix()` must have column names if `.name_repair` is omitted as of tibble 2.0.0.
#> Using compatibility `.name_repair`.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_warnings()` to see where this warning was generated.
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
convert them according to your needs. Finally, I appreciate any
feedback, please reach out or DM at
[ihaddaden\_moh\_fodil](https://twitter.com/moh_fodil).
