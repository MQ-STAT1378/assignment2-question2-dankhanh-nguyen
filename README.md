
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Assignment2Question2dankhanhnguyen

<!-- badges: start -->
<!-- badges: end -->

The goal of Assignment2Question2dankhanhnguyen is to show the created
Rpackage that generate a data frame of information about customer’s
transitions times and their chosen server

## Installation

You can install the development version from
[GitHub](https://github.com/MQ-STAT1378/assignment2-question2-dankhanh-nguyen)
with:

``` r
# install.packages("devtools")
library(devtools)
devtools::install_github("MQ-STAT1378/assignment2-question2-dankhanh-nguyen")
```

## Multiserver() function setup

``` r
Multiserver <- function(Arrivals, ServiceTimes, NumServers = 1) {
  if (any(Arrivals <= 0 | ServiceTimes <= 0) || NumServers <= 0){
    stop("Arrivals, ServiceTimes must be positive & NumServers must be positive" )
  }
  if (length(Arrivals) != length(ServiceTimes)){
    stop("Arrivals and ServiceTimes must have the same length")
  }
  # Feed customers through a multiserver queue system to determine each
  # customer's transition times.

  NumCust = length(Arrivals)  #  number of customer arrivals
  # When each server is next available (this will be updated as the simulation proceeds):
  AvailableFrom <- rep(0, NumServers)
  # i.e., when the nth server will next be available

  # These variables will be filled up as the simulation proceeds:
  ChosenServer <- ServiceBegins <- ServiceEnds <- rep(0, NumCust)

  # ChosenServer = which server the ith customer will use
  # ServiceBegins = when the ith customer's service starts
  # ServiceEnds = when the ith customer's service ends

  # This loop calculates the queue system's "Transitions by Customer":
  for (i in seq_along(Arrivals)){
    # go to next available server
    avail <-  min(AvailableFrom)
    ChosenServer[i] <- which.min(AvailableFrom)
    # service begins as soon as server & customer are both ready
    ServiceBegins[i] <- max(avail, Arrivals[i])
    ServiceEnds[i] <- ServiceBegins[i] + ServiceTimes[i]
    # server becomes available again after serving ith customer
    AvailableFrom[ChosenServer[i]] <- ServiceEnds[i]
  }
  out <- tibble::tibble(Arrivals, ServiceBegins, ChosenServer, ServiceEnds)
  return(out)
}
```

## Example

This is a basic example which shows you how to use *Multiserver()*
function with provided *bank* dataset:

``` r
library(Assignment2Question2dankhanhnguyen)
#> 
#> Attaching package: 'Assignment2Question2dankhanhnguyen'
#> The following object is masked _by_ '.GlobalEnv':
#> 
#>     Multiserver
## basic example code
# call the bank dataset provided with the package
head(bank)
#>   X arrival_time service_time
#> 1 1     118.9688     29.82404
#> 2 2     133.9700    155.00763
#> 3 3     325.6309     30.70186
#> 4 4     338.5996     85.52865
#> 5 5     371.9286    280.30339
#> 6 6     395.9377     78.11599

Multiserver(bank$arrival_time[7], bank$service_time[7],2)
#> # A tibble: 1 x 4
#>   Arrivals ServiceBegins ChosenServer ServiceEnds
#>      <dbl>         <dbl>        <dbl>       <dbl>
#> 1     400.          400.            1        435.
```
