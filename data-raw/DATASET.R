# code to prepare `bank` dataset
# bank <- read.csv("bank.csv")
usethis::use_data(bank, overwrite = TRUE)

# ____________Setup code________________
library(devtools)
has_devel()

usethis::create_package("C:/BOI/Macquarie/STAT1378/Assignment2/Exercise2/Assignment2Question2dankhanhnguyen")
# opens RStudio window - copy these commands in there
#____________Setup code________________
#
# create .R scripts for our multiserver functions
usethis::use_r("Multiserver")

# load the functions into R using load_all()
devtools::load_all()
Multiserver()
# error

# check that our package is in full working order
devtools::check()
# 0 errors √ | 1 warning x | 0 notes √

usethis::use_mit_license("Kate Nguyen")
devtools::check()
# 0 errors √ | 0 warnings √ | 0 notes √

# Insert roxygen skeleton
devtools::document()
# Able to generate help page ?Multiserver
# And, update NAMESPACE

usethis::use_package("tibble")

devtools::document() #Ctrl+Shift+D
devtools::check() #Ctrl+Shift+E

usethis::use_testthat()
# declare our intent

usethis::use_test("Multiserver")
# create a source file(Rscript) for testing
# update test-Multiserver.R

devtools::test()

usethis::use_data_raw()
# Setup DATASET.R to save code used to setup R package

# Version Control with Github________________________________________________

library(gitcreds)
usethis::git_sitrep()
# to check all is well

usethis::use_readme_rmd()
# Create a readme file
# Need to knit the file before commit: Ctrl + Shift + k

usethis::git_vaccinate()
# automate ignoring personal files that you don't want to publish on git

pkgdown::build_site()
# create a website for the package
