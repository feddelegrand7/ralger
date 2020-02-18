## Submission of a new version
---------------------------------------
Duration: 3m 50.5s

> checking top-level files ... NOTE
  Non-standard file/directory found at top level:
    'bootstrap.min.css'

0 errors v | 0 warnings v | 1 note x

R CMD check succeeded

---------------------------------------

This is a new version of the ralger package which includes these new functionalities: 

- A new argument within each function :askRobot: which allows the user to check if he has the right to scrap a web page 

- I've modified the clean argument to make it faster 

- I've introduced two new functions : 

* table_scrap(): allows the user to extract an HTML table from a webpage
* weblink_scrap(): allows the user to extract all web links within a web page. This can be useful in specific cases. 


