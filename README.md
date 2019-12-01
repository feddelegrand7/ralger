
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

## Example

This is an example which shows how to extract firms’ denomination from
the website of the Algerian Chamber of Commerce and Industry (CACI). For
simplicity, we’ll focus on firms operating within the capital (Alger).

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

If you want to scrap multiple list pages, use the `scrap_more()`
function. **IMPORTANT: Note that the `scrap_more()` function requires
your link to end with** `&page=`. Here we’ll scrap from page 0 to page 3
(included).

``` r
my_link <- "http://elmouchir.caci.dz/search_results.php?keyword=&category=&location=Alger&submit=Trouver&page=" 
# mind the change within the link
# it ends with '&page='

scrap_more(my_link, my_node, from = 0, to = 3)
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
#> [21] "Adjerid Hanifa"                                                               
#> [22] "Dar Chamila"                                                                  
#> [23] "SAMRIA AUTO / Salon Algerian du Materiel Roulant et de L'industrie Automobile"
#> [24] "YOUKAIS"                                                                      
#> [25] "EDIMETAL"                                                                     
#> [26] "SYRIAN AIR LINES"                                                             
#> [27] "Turkish Airlines / Direction Générale"                                        
#> [28] "Aigle Azur / Agence Didouche Mourad"                                          
#> [29] "British Airways"                                                              
#> [30] "DELTA"                                                                        
#> [31] "Cabinet Ammiche Amer"                                                         
#> [32] "VERITEX"                                                                      
#> [33] "Kermiche Partener"                                                            
#> [34] "Entreprise d'Architecture Aurea"                                              
#> [35] "PROGOS"                                                                       
#> [36] "Ambassade du Royaume d'Arabie Saoudite"                                       
#> [37] "Ambassade de la République d'Argentine"                                       
#> [38] "Ambassade du Burkina Faso"                                                    
#> [39] "Ambassade du Canada"                                                          
#> [40] "Ambassade de la République de Corée"                                          
#> [41] "Ambassade de la République de Côte d'Ivoire"                                  
#> [42] "Ambassade des Emirats Arabes Unis"                                            
#> [43] "Ambassade du Royaume d'Espagne"                                               
#> [44] "Ambassade des Etats Unis d’Amérique"                                          
#> [45] "Ambassade de la République de Guinée Bissau"                                  
#> [46] "Ambassade du Royaume Hachémite de Jordanie"                                   
#> [47] "Chef du Gouvernement"                                                         
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
#> [61] "CNIS / Centre National de l'Informatique et des Statistiques"                 
#> [62] "L'amiral Communication"                                                       
#> [63] "Hopital d'El Kettar"                                                          
#> [64] "Ambassade de la République Slovaque"                                          
#> [65] "Ambassade de Malaisie"                                                        
#> [66] "Ambassade de l'Afrique du Sud"                                                
#> [67] "ONM / Office National de la Météorologie"                                     
#> [68] "CGEA / Confédération Générale des Entreprises Algériennes"                    
#> [69] "Musee pour Enfants"                                                           
#> [70] "Musee National des Antiquites"                                                
#> [71] "Musée National du Bardo"                                                      
#> [72] "Hopital  de Ain Taya"                                                         
#> [73] "Secteur Sanitaire Bologhine"                                                  
#> [74] "Hopital Bel Kasmi Taib (Hopital de Zéralda)"                                  
#> [75] "ANEFA / Association Nationale des Etablissements de Formation Agrées"         
#> [76] "Musée les Beaux Arts"                                                         
#> [77] "Musée National des Arts et Traditions Populaires"                             
#> [78] "CIEFAC / Centre Inter Entreprise de Formation Administrative et Comptabilité" 
#> [79] "CSPA / Conseil Supérieur du Patronat Algérien"                                
#> [80] "UNEB / Union Nationale des Entrepreneurs du Bâtiment"
```

I appreciate any feedback, please reach out or DM at
[ihaddadenfodil](https://twitter.com/IhaddadenFodil).
