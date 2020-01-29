
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ralger <a><img src='man/figures/hex.png' align="right" height="200" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/ralger)](https://cran.r-project.org/package=ralger)

<!-- badges: end -->

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
#> Warning: package 'ralger' was built under R version 3.6.2

my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver"

my_node <- ".listing_default" # The CSS element, we recommend SelectorGadget

scrap(my_link, my_node)
#>  [1] "Adjerid Hanifa"                                                               
#>  [2] "Dar Chamila"                                                                  
#>  [3] "TVA / Touring Voyages Algérie Centre / Zighoud Youcef"                        
#>  [4] "SAMRIA AUTO / Salon Algerian du Materiel Roulant et de L'industrie Automobile"
#>  [5] "YOUKAIS"                                                                      
#>  [6] "EDIMETAL"                                                                     
#>  [7] "SYRIAN AIR LINES"                                                             
#>  [8] "Turkish Airlines / Direction Générale"                                        
#>  [9] "Aigle Azur / Agence Didouche Mourad"                                          
#> [10] "British Airways"                                                              
#> [11] "DELTA"                                                                        
#> [12] "Cabinet Ammiche Amer"                                                         
#> [13] "VERITEX"                                                                      
#> [14] "Kermiche Partener"                                                            
#> [15] "PROGOS"                                                                       
#> [16] "Ambassade du Royaume d'Arabie Saoudite"                                       
#> [17] "Ambassade de la République d'Argentine"                                       
#> [18] "Ambassade du Burkina Faso"                                                    
#> [19] "Ambassade du Canada"                                                          
#> [20] "Ambassade de la République de Corée"
```

If you want to scrap multiple list pages, just use `scrap()` in
conjunction with `paste()`. Suppose, we want to extract the above
information from the first 3 pages (starts from 0):

``` r
my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=" 

my_node <- ".listing_default"

scrap(paste(my_link, 0:2), my_node)
#>  [1] "Direction Régionale Centre / Ex Trans Canal Centre"                                                                            
#>  [2] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#>  [3] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#>  [4] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#>  [5] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#>  [6] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#>  [7] "Clef du Sud / Miftah El Djanoub"                                                                                               
#>  [8] "Adrien.Dz"                                                                                                                     
#>  [9] "MPV"                                                                                                                           
#> [10] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [11] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [12] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [13] "VERITAL/ Direction Générale"                                                                                                   
#> [14] "Wilaya d'Alger"                                                                                                                
#> [15] "Officine Abeille"                                                                                                              
#> [16] "Twingle"                                                                                                                       
#> [17] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [18] "Les Pages Jaunes"                                                                                                              
#> [19] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [20] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [21] "Direction Régionale Centre / Ex Trans Canal Centre"                                                                            
#> [22] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#> [23] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#> [24] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#> [25] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#> [26] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#> [27] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [28] "Adrien.Dz"                                                                                                                     
#> [29] "MPV"                                                                                                                           
#> [30] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [31] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [32] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [33] "VERITAL/ Direction Générale"                                                                                                   
#> [34] "Wilaya d'Alger"                                                                                                                
#> [35] "Officine Abeille"                                                                                                              
#> [36] "Twingle"                                                                                                                       
#> [37] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [38] "Les Pages Jaunes"                                                                                                              
#> [39] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [40] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"                                                                        
#> [41] "Direction Régionale Centre / Ex Trans Canal Centre"                                                                            
#> [42] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#> [43] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#> [44] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#> [45] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#> [46] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#> [47] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [48] "Adrien.Dz"                                                                                                                     
#> [49] "MPV"                                                                                                                           
#> [50] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [51] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [52] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [53] "VERITAL/ Direction Générale"                                                                                                   
#> [54] "Wilaya d'Alger"                                                                                                                
#> [55] "Officine Abeille"                                                                                                              
#> [56] "Twingle"                                                                                                                       
#> [57] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [58] "Les Pages Jaunes"                                                                                                              
#> [59] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [60] "CCIM / Chambre de Commerce et d'Industrie de Mezghenna"
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

  - The title of the 50 best ranked movies of all time;
  - Their release year;
  - Their rating.

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

Note that all columns will be of *character* class. We’ll have to
convert them according to our needs. Finally, I appreciate any feedback,
please reach out or DM at
[ihaddaden\_moh\_fodil](https://twitter.com/moh_fodil).
