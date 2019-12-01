
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

pacman::p_load(usethis, roxygen2, devtools, available)


# Find a package name

available('ralger') # OK !


# sync with Github

use_git()

use_github()
