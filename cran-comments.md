## Submission of a new version
-- R CMD check results ---------------------------- ralger 2.1.0 ----
Duration: 2m 37.8s

0 errors √ | 0 warnings √ | 0 notes √
---------------------------------------

Fixing issues related to : 

"It looks as if the CRAN policy

'Packages which use Internet resources should fail gracefully with an
informative message if the resource is not available or has changed (and
not give a check warning nor error).'

needs to be implemented here."

Email received the 08th November 2020 from Professor Brian D. Ripley,

#######################
Answers
#######################

Thank you very much for your feedback. In order to fix the above mentioned issue I have wrapped all the `ralger` functions inside a `tryCatch()` function. Now `ralger` detects catches the following errors: 

+ No internet connection: In this case, `ralger` displays a message and returns `NA` 
+ Invalid link: package's functions display an informative message and returns also `NA`


