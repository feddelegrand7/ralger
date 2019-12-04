
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ralger <a><img src='man/figures/hex.png' align="right" height="200" /></a>

<!-- badges: start -->

<!-- badges: end -->

The goal of **ralger** is to facilitate web scraping in R.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("feddelegrand7/ralger")
```

## scrap()

This is an example which shows how to extract firms denomination from
the website of the Algerian Chamber of Commerce and Industry (CACI). For
simplicity, we’ll focus on firms operating within the capital (Alger).

``` r
library(ralger)

my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver"

my_node <- ".listing_default" # see SelectorGadget

scrap(my_link, my_node)
#>  [1] "Adjerid Hanifa"                                                               
#>  [2] "Dar Chamila"                                                                  
#>  [3] "SAMRIA AUTO / Salon Algerian du Materiel Roulant et de L'industrie Automobile"
#>  [4] "YOUKAIS"                                                                      
#>  [5] "EDIMETAL"                                                                     
#>  [6] "SYRIAN AIR LINES"                                                             
#>  [7] "Turkish Airlines / Direction Générale"                                        
#>  [8] "Aigle Azur / Agence Didouche Mourad"                                          
#>  [9] "British Airways"                                                              
#> [10] "DELTA"                                                                        
#> [11] "Cabinet Ammiche Amer"                                                         
#> [12] "VERITEX"                                                                      
#> [13] "Kermiche Partener"                                                            
#> [14] "Entreprise d'Architecture Aurea"                                              
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
#>  [1] "ALTRUCK"                                                                    
#>  [2] "GFC Négoce"                                                                 
#>  [3] "Esasoud Welding And Cutting"                                                
#>  [4] "Huan Yu"                                                                    
#>  [5] "HRLI"                                                                       
#>  [6] "Dar El Hikma"                                                               
#>  [7] "Trans Canal Centre / Khemis El Khechna"                                     
#>  [8] "Direction Régionale Centre / Ex Trans Canal Centre"                         
#>  [9] "Egt Sidi Fredj / Club Azur Plage"                                           
#> [10] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                 
#> [11] "SPE / Sociéte Algérienne de Production d’Electricité"                       
#> [12] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"        
#> [13] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"
#> [14] "Clef du Sud"                                                                
#> [15] "Adrien.Dz"                                                                  
#> [16] "MPV"                                                                        
#> [17] "SCAL / La Société des Ciments de l'Algérois"                                
#> [18] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                          
#> [19] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                           
#> [20] "VERITAL/ Direction Générale"                                                
#> [21] "ALTRUCK"                                                                    
#> [22] "GFC Négoce"                                                                 
#> [23] "Esasoud Welding And Cutting"                                                
#> [24] "Huan Yu"                                                                    
#> [25] "HRLI"                                                                       
#> [26] "Dar El Hikma"                                                               
#> [27] "Trans Canal Centre / Khemis El Khechna"                                     
#> [28] "Direction Régionale Centre / Ex Trans Canal Centre"                         
#> [29] "Egt Sidi Fredj / Club Azur Plage"                                           
#> [30] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                 
#> [31] "SPE / Sociéte Algérienne de Production d’Electricité"                       
#> [32] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"        
#> [33] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"
#> [34] "Clef du Sud"                                                                
#> [35] "Adrien.Dz"                                                                  
#> [36] "MPV"                                                                        
#> [37] "SCAL / La Société des Ciments de l'Algérois"                                
#> [38] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                          
#> [39] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                           
#> [40] "VERITAL/ Direction Générale"                                                
#> [41] "ALTRUCK"                                                                    
#> [42] "GFC Négoce"                                                                 
#> [43] "Esasoud Welding And Cutting"                                                
#> [44] "Huan Yu"                                                                    
#> [45] "HRLI"                                                                       
#> [46] "Dar El Hikma"                                                               
#> [47] "Trans Canal Centre / Khemis El Khechna"                                     
#> [48] "Direction Régionale Centre / Ex Trans Canal Centre"                         
#> [49] "Egt Sidi Fredj / Club Azur Plage"                                           
#> [50] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                 
#> [51] "SPE / Sociéte Algérienne de Production d’Electricité"                       
#> [52] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"        
#> [53] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"
#> [54] "Clef du Sud"                                                                
#> [55] "Adrien.Dz"                                                                  
#> [56] "MPV"                                                                        
#> [57] "SCAL / La Société des Ciments de l'Algérois"                                
#> [58] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                          
#> [59] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                           
#> [60] "VERITAL/ Direction Générale"
```

## tidy\_scrap()

If you want to extract information in the form of a dataframe, you can
use the `tidy_scrap()` function which returns a tidy dataframe according
to the arguments that you introduce. The function takes three mandatory
arguments:

  - **link** : which is the link of the website you’re interested for;
  - **nodes**: which is a vector of CSS elements that you want to
    extract. These elements will form the columns of your dataframe;
  - **scrap\_names**: this argument represents the vector of names you
    want to assign to your columns. Note that you should respect the
    same order as within the **nodes** vector.

### Example

We’ll work on the famous [IMDb website](https://www.imdb.com/). Let’s
say you need a dataframe composed of:

  - The title of the 50 best ranked movies of all time;
  - Their release year;
  - Their rating.

You we’ll need to use the `tidy_scrap()` function as follows:

``` r

my_link <- "https://www.imdb.com/search/title/?groups=top_250&sort=user_rating"

my_nodes <- c(
  ".lister-item-header a", # The title 
  ".text-muted.unbold", # The year of release 
  ".ratings-imdb-rating strong" # The rating)
  )

names <- c("title", "year", "rating") # respect the nodes order


tidy_scrap(my_link, my_nodes, scrap_names = names)
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

Note that all columns will be of *character* class. You’ll need to
convert them according to your needs. Finally, I appreciate any
feedback, please reach out or DM at
[ihaddadenfodil](https://twitter.com/IhaddadenFodil).
