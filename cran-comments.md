## Submission of a new version
---------------------------------------
-- R CMD check results --------------------------- ralger 2.0.1 ----
Duration: 1m 55.8s

0 errors √ | 0 warnings √ | 0 notes √

---------------------------------------

1- Thanks to Ezekiel (ctb) I've added an argument to the table_scrap() function which is fill = F (the argument is from the rvest package), the user has now the ability to set fill = TRUE when dealing with tables with inconsistent number of columns. 
