
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
#> [15] "Marine Soft"                                                                  
#> [16] "PROGOS"                                                                       
#> [17] "Ambassade du Royaume d'Arabie Saoudite"                                       
#> [18] "Ambassade de la République d'Argentine"                                       
#> [19] "Ambassade du Burkina Faso"                                                    
#> [20] "Ambassade du Canada"
```

If you want to scrap multiple list pages, just use `scrap()` in
conjunction with `paste()`. Suppose, we want to extract the above
information from the first 3 pages (starts from 0):

``` r
my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=" 

my_node <- ".listing_default"

scrap(paste(my_link, 0:2), my_node)
#>  [1] "Dar El Hikma"                                                                                                                  
#>  [2] "Trans Canal Centre / Khemis El Khechna"                                                                                        
#>  [3] "Direction Régionale Centre / Ex Trans Canal Centre"                                                                            
#>  [4] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#>  [5] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#>  [6] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#>  [7] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#>  [8] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#>  [9] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [10] "Adrien.Dz"                                                                                                                     
#> [11] "MPV"                                                                                                                           
#> [12] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [13] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [14] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [15] "VERITAL/ Direction Générale"                                                                                                   
#> [16] "Wilaya d'Alger"                                                                                                                
#> [17] "Officine Abeille"                                                                                                              
#> [18] "Twingle"                                                                                                                       
#> [19] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [20] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [21] "Dar El Hikma"                                                                                                                  
#> [22] "Trans Canal Centre / Khemis El Khechna"                                                                                        
#> [23] "Direction Régionale Centre / Ex Trans Canal Centre"                                                                            
#> [24] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#> [25] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#> [26] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#> [27] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#> [28] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#> [29] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [30] "Adrien.Dz"                                                                                                                     
#> [31] "MPV"                                                                                                                           
#> [32] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [33] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [34] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [35] "VERITAL/ Direction Générale"                                                                                                   
#> [36] "Wilaya d'Alger"                                                                                                                
#> [37] "Officine Abeille"                                                                                                              
#> [38] "Twingle"                                                                                                                       
#> [39] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [40] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
#> [41] "Dar El Hikma"                                                                                                                  
#> [42] "Trans Canal Centre / Khemis El Khechna"                                                                                        
#> [43] "Direction Régionale Centre / Ex Trans Canal Centre"                                                                            
#> [44] "Egt Sidi Fredj / Club Azur Plage"                                                                                              
#> [45] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                                                                    
#> [46] "SPE / Sociéte Algérienne de Production d’Electricité"                                                                          
#> [47] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"                                                           
#> [48] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"                                                   
#> [49] "Clef du Sud / Miftah El Djanoub"                                                                                               
#> [50] "Adrien.Dz"                                                                                                                     
#> [51] "MPV"                                                                                                                           
#> [52] "SCAL / La Société des Ciments de l'Algérois"                                                                                   
#> [53] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                                                                             
#> [54] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                                                                              
#> [55] "VERITAL/ Direction Générale"                                                                                                   
#> [56] "Wilaya d'Alger"                                                                                                                
#> [57] "Officine Abeille"                                                                                                              
#> [58] "Twingle"                                                                                                                       
#> [59] "UGTA / Union Générale des Travailleurs Algériens"                                                                              
#> [60] "ENEFEP / Etablissement National Des Equipements Techniques Et Pédagogiques de la Formation et de L’enseignement Professionnels"
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
