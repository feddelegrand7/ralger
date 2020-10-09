## Submission of a new version
-- R CMD check results ---------------------------- ralger 2.1.0 ----
Duration: 2m 37.8s

0 errors √ | 0 warnings √ | 0 notes √
---------------------------------------


- I've changed the message printed when using the askRobot argument, which is now more precise. 

- I've cleaned considerably the code. 

- I've replace the str_detect function from string by the grepl base R function which provides the ability to enable/disable case sensitive character searching. 

- I've added new tests. 

- I've added the h3 html tag to the titles_scrap function. Now when executed the user gets the h1, h2 and h3 elements from a web page (h1 and h2 only before)
