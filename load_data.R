# This script reads data to objects and does some baseline cleaning
library(haven)
library(tidyverse)
install.packages('labelled')
library(labelled)

factorize <- function(var, levels, labels){
  var_lab <- var_label(var)
  var <- factor(
    var,
    levels = levels,
    labels = labels
  )
  var_label(var) <- var_lab
  return(var)
}

# Demographics ------------------------------------------------------------
# read in dataset
demo <- read_xpt('DEMO_L.xpt')

## set factors ------------------------------------------------------------
demo$RIDSTATR <- factorize(
  demo$RIDSTATR,
  levels = c(1, 2),
  labels = c('Interviewed only', 'Both interviewed and MEC examined')
)

demo$RIAGENDR <- factorize(
  demo$RIAGENDR,
  levels = c(1, 2),
  labels = c('Male', 'Female')
)

demo$RIDRETH1 <- factorize(
  demo$RIDRETH1,
  levels = c(1:5),
  labels = c(
    'Mexican American',
    'Other Hispanic',
    'Non-Hispanic White',
    'Non-Hispanic Black',
    'Other Race - Including Multi-Racial'
  )
)

demo$RIDRETH3 <- factorize(
  demo$RIDRETH3,
  levels = c(1, 2, 3, 4, 6, 7),
  labels = c(
    'Mexican American',
    'Other Hispanic',
    'Non-Hispanic White',
    'Non-Hispanic Black',
    'Non-Hispanic Asian',
    'Other Race - Including Multi-Racial'
  )
)

demo$RIDEXMON <- factorize(
  demo$RIDEXMON,
  levels = c(1, 2),
  labels = c(
    'November 1 through April 30',
    'May 1 through October 31'
  )
)

demo$DMQMILIZ <- factorize(
  demo$DMQMILIZ,
  levels = c(1, 2, 7, 9),
  labels = c(
    'Yes',
    'No',
    'Refused',
    'Don\'t know'
  )
)

demo$DMDBORN4 <- factorize(
  demo$DMDBORN4,
  levels = c(1, 2, 77, 99),
  labels = c(
    'Born in 50 US states or Washington',
    'Others',
    'Refused',
    'Don\'t know'
  )
)

demo$DMDYRUSR <- factorize(
  demo$DMDYRUSR,
  levels = c(1:6, 77, 99),
  labels = c(
    'Less than 1 year',
    '1 to 4 years',
    '5 to 9 years',
    '10 to 14 years',
    '15 to 19 years',
    '20 years or more',
    'Refused',
    'Don\'t know'
  )
)

demo$DMDEDUC2 <- factorize(
  demo$DMDEDUC2,
  levels = c(1:5, 7, 9),
  labels = c(
    'Less than 9th grade',
    '9-11th grade (Includes 12th grade with no diploma)',
    'High school graduate/GED or equivalent',
    'Some college or AA degree',
    'College graduate or above',
    'Refused',
    'Don\'t know'
  )
)

demo$DMDMARTZ <- factorize(
  demo$DMDMARTZ,
  levels = c(1:3, 77, 99),
  labels = c(
    'Married/Living with parter',
    'Widowed/Divorced/Separated',
    'Never married',
    'Refused',
    'Don\'t know'
  )
)

demo$RIDEXPRG <- factorize(
  demo$RIDEXPRG,
  levels = c(1:3),
  labels = c(
    'Yes, positive lab pregnancy test or self-reported pregnant at exam',
    'The participant was not pregnant at exam',
    'Cannot ascertain if teh participant is pregnant at exam'
  )
)

# Supplements -------------------------------------------------------------

# read in dataset
supp <- read_xpt('DSQTOT_L.xpt')

## set factors ------------------------------------------------------------

supp$DSD010 <- factorize(
  supp$DSD010,
  levels = c(1, 2, 7, 9),
  labels = c(
    'Yes',
    'No',
    'Refused',
    'Don\'t know'
  )
)

supp$DSD010AN <- factorize(
  supp$DSD010AN,
  levels = c(1, 2, 7, 9),
  labels = c(
    'Yes',
    'No',
    'Refused',
    'Don\'t know'
  )
)

## clean numeric variables ---------------------------------------------
# The following variables are a mix of numeric and categorical information.
# e.g. 0 to 30 are actual values, 77 = 'Refused', 99 = 'Dont Know'. 
# Will handle the categorical values as missing.

supp$DSDCOUNT[supp$DSDCOUNT > 30] <- NA_real_

supp$DSDANCNT[supp$DSDANCNT > 3] <- NA_real_

