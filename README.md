
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ralger

<!-- badges: start -->

<!-- badges: end -->

The goal of ralger is to facilitate web scraping in R.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("feddelegrand7/ralger")
```

## Example

This is an example which shows how to extract firms’ denomination from
the website of the Algerian Chamber of Commerce and Industry (CACI). For
simplicity, we’ll focus on firms operating in the capital.

``` r
library(ralger)

my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver"

my_node <- ".listing_default" # see SelectorGadget

scrap_one(my_link, my_node)
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
