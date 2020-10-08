# ralger 2.1.0

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
