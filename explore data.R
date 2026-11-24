source('load_data.R')

library(tidyverse)

var_label(demo)

ggplot(demo, aes(RIAGENDR, RIDAGEYR)) +
  geom_violin()

var_label(supp)

ggplot(supp, aes(DSDCOUNT, DSQTPOTA)) +
  geom_point()

demo2 <- demo %>%
  select(SEQN, RIAGENDR)

supp2 <- supp %>%
  select(SEQN, DSDCOUNT, DSQTPOTA)

dat <- left_join(supp2, demo2)

ggplot(dat, aes(RIAGENDR, DSDCOUNT)) +
  stat_summary(geom = 'bar', fun = mean)

ggplot(dat, aes(RIAGENDR, DSDCOUNT)) +
  geom_bar(stat = 'sum')

by(dat$DSDCOUNT, dat$RIAGENDR, function(x) sum(x, na.rm = TRUE))