## Submission of a new version
---------------------------------------
-- R CMD check results --------------------------------------- ralger 1.1.0 ----
Duration: 2m 34.4s

0 errors v | 0 warnings v | 0 notes v

R CMD check succeeded


---------------------------------------

This is a new version of the ralger package which includes these new functionalities: 

- A new argument within each function :askRobot: which allows the user to check if she has the right to scrap a web page 

- I've modified the clean argument to make it faster 

- I've introduced two new functions : 

* table_scrap(): allows the user to extract an HTML table from a webpage
* weblink_scrap(): allows the user to extract all web links within a web page. This can be useful in specific cases. 


