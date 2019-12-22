
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ralger <a><img src='man/figures/hex.png' align="right" height="200" /></a>

<!-- badges: start -->

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

my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver"

my_node <- ".listing_default" # The CSS element, we recommend SelectorGadget

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
#> [14] "PROGOS"                                                                       
#> [15] "Ambassade du Royaume d'Arabie Saoudite"                                       
#> [16] "Ambassade de la République d'Argentine"                                       
#> [17] "Ambassade du Burkina Faso"                                                    
#> [18] "Ambassade du Canada"                                                          
#> [19] "Ambassade de la République de Corée"                                          
#> [20] "Ambassade de la République de Côte d'Ivoire"
```

If you want to scrap multiple list pages, just use `scrap()` in
conjunction with `paste()`. Suppose, we want to extract the above
information from the first 3 pages (starts from 0):

``` r
my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=" 

my_node <- ".listing_default"

scrap(paste(my_link, 0:2), my_node)
#>  [1] "Esasoud Welding And Cutting"                                                
#>  [2] "Huan Yu"                                                                    
#>  [3] "HRLI"                                                                       
#>  [4] "Dar El Hikma"                                                               
#>  [5] "Trans Canal Centre / Khemis El Khechna"                                     
#>  [6] "Direction Régionale Centre / Ex Trans Canal Centre"                         
#>  [7] "Egt Sidi Fredj / Club Azur Plage"                                           
#>  [8] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                 
#>  [9] "SPE / Sociéte Algérienne de Production d’Electricité"                       
#> [10] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"        
#> [11] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"
#> [12] "Clef du Sud"                                                                
#> [13] "Adrien.Dz"                                                                  
#> [14] "MPV"                                                                        
#> [15] "SCAL / La Société des Ciments de l'Algérois"                                
#> [16] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                          
#> [17] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                           
#> [18] "VERITAL/ Direction Générale"                                                
#> [19] "Wilaya d'Alger"                                                             
#> [20] "Officine Abeille"                                                           
#> [21] "Esasoud Welding And Cutting"                                                
#> [22] "Huan Yu"                                                                    
#> [23] "HRLI"                                                                       
#> [24] "Dar El Hikma"                                                               
#> [25] "Trans Canal Centre / Khemis El Khechna"                                     
#> [26] "Direction Régionale Centre / Ex Trans Canal Centre"                         
#> [27] "Egt Sidi Fredj / Club Azur Plage"                                           
#> [28] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                 
#> [29] "SPE / Sociéte Algérienne de Production d’Electricité"                       
#> [30] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"        
#> [31] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"
#> [32] "Clef du Sud"                                                                
#> [33] "Adrien.Dz"                                                                  
#> [34] "MPV"                                                                        
#> [35] "SCAL / La Société des Ciments de l'Algérois"                                
#> [36] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                          
#> [37] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                           
#> [38] "VERITAL/ Direction Générale"                                                
#> [39] "Wilaya d'Alger"                                                             
#> [40] "Officine Abeille"                                                           
#> [41] "Esasoud Welding And Cutting"                                                
#> [42] "Huan Yu"                                                                    
#> [43] "HRLI"                                                                       
#> [44] "Dar El Hikma"                                                               
#> [45] "Trans Canal Centre / Khemis El Khechna"                                     
#> [46] "Direction Régionale Centre / Ex Trans Canal Centre"                         
#> [47] "Egt Sidi Fredj / Club Azur Plage"                                           
#> [48] "EGT Zeralda / Entreprise de Gestion Touristique de Zeralda"                 
#> [49] "SPE / Sociéte Algérienne de Production d’Electricité"                       
#> [50] "GRTG / Société Algérienne de Gestion du Réseau de Transport  de Gaz"        
#> [51] "GRTE  / Société Algérienne de Gestion du Réseau de Transport de Electricité"
#> [52] "Clef du Sud"                                                                
#> [53] "Adrien.Dz"                                                                  
#> [54] "MPV"                                                                        
#> [55] "SCAL / La Société des Ciments de l'Algérois"                                
#> [56] "EVSM / Entreprise de Viabilisation de Sidi Moussa"                          
#> [57] "Chambre d'Agriculture de la Wilaya d'Alger / CNA"                           
#> [58] "VERITAL/ Direction Générale"                                                
#> [59] "Wilaya d'Alger"                                                             
#> [60] "Officine Abeille"
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
