# This script reads data to objects and does some baseline cleaning
library(haven)
library(tidyverse)
#install.packages('labelled')
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
demo_orig <- read_xpt('DEMO_L.xpt')
#select variables needed for app
demo <- demo_orig %>% select(
  SEQN, RIDSTATR, RIAGENDR, RIDAGEYR, RIDRETH3, DMDEDUC2, DMDMARTZ,
  RIDEXPRG, DMDHHSIZ, INDFMPIR
)

## clean variables ----
# set values "refused" and "don't know" as missing, since we will handle that
# information the same
demo$DMDEDUC2[demo$DMDEDUC2 >= 7] <- NA_real_
demo$DMDMARTZ[demo$DMDMARTZ > 3] <- NA_real_

## set factors ----
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

demo$DMDEDUC2 <- factorize(
  demo$DMDEDUC2,
  levels = c(1:5),
  labels = c(
    'Less than 9th grade',
    '9-11th grade (Includes 12th grade with no diploma)',
    'High school graduate/GED or equivalent',
    'Some college or AA degree',
    'College graduate or above'
  )
)

demo$DMDMARTZ <- factorize(
  demo$DMDMARTZ,
  levels = c(1:3),
  labels = c(
    'Married/Living with parter',
    'Widowed/Divorced/Separated',
    'Never married'
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
supp_orig <- read_xpt('DSQTOT_L.xpt')
# select variables needed for app
supp <- supp_orig %>% select(
  -c(WTDRD1, DSDANCNT, DSD010AN, DSQTFDFE)
)
## clean variables ----
# set values "refused" and "don't know" as missing, since we will handle that
# information the same
supp$DSDCOUNT[supp$DSDCOUNT > 30] <- NA_real_
supp$DSD010[supp$DSD010 > 2] <- NA_real_

## set factors ----

supp$DSD010 <- factorize(
  supp$DSD010,
  levels = c(1, 2),
  labels = c(
    'Yes',
    'No'
  )
)

