# ralger 2.2.3

# ralger 2.2.2

+ Adding the `attribute_scrap()` 
+ Adding the `images_noalt_scrap()`
+ I've added skip_on_cran on some tests that require an internet connexion and take an important amount of time to run. 


# ralger 2.2.1

+ Adding the `images_scrap()` function which allows the user to download images from a website
+ Adding the `images_preview()` function which allows the user to list the images url from a specific web page
+ Wrapping `paragraphs_scrap()` within a `tryCatch` function. 
+ adding the string::stri_remove_empty() to the scrap() function in order to remove empty elements


# ralger 2.2.0

I have wrapped `ralger` functions inside a `tryCatch()` function. Now `ralger` detects catches the following errors: 

+ No internet connection: In this case, `ralger` displays a message and returns `NA` 
+ Invalid link: package's functions display an informative message and returns also `NA`


# ralger 2.1.0

+ code cleaning 
+ removing some dependencies
+ modifying the message displayed by the robot.txt
+ now titles_scrap() scrapes h1, h2 & h3 (previously only h1 and h2)

# ralger 2.0.1

1- Thanks to Ezekiel (ctb) I've added an argument to the table_scrap() function which is fill (the argument is from the rvest package), the user has now the ability to set fill = TRUE when dealing with tables with inconsistent number of columns/rows. 


# ralger 2.0.0

1- I've added the __choose__ argument to the `table_scrap()` function, which allows the user to choose which table to extract.

2- I've added two  functions: 
+ `titles_scrap()` for scraping titles from a website. 
+ `paragraphs_scrap()` for scraping paragraphs from a website. 

# ralger 1.1.1

Two new functions: 
 - `table_scrap()`: allows the user to extract an HTML table from a web page.  
 - `weblink_scrap()`: allows the user to extract all web links within a web page. 
 
Also, introducting a new arguments within each function : __askRobot__





# ralger 1.0.0

Initial release

* Added a `NEWS.md` file to track changes to the package.
