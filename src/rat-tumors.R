library(rstan)
library(loo)
library(tidyverse)
library(reshape2)
rat_tumors_df <- read.csv("rat-tumors.csv", sep=",", comment.char="#");
y <- rat_tumors_df$y;
K <- rat_tumors_df$n;
N <- length(y);
K_new <- rep(0, N);
y_new <- rep(0.0, N);

fit_rats_pool <- stan("pool.stan", chains = 4,
                       data = c("N", "K", "y", "K_new", "y_new"));

fit_rats_no_pool <- stan("no-pool.stan", chains = 4,
                         data = c("N", "K", "y", "K_new", "y_new"));

fit_rats_hier <- stan("hier.stan", chains = 4,
                      data = c("N", "K", "y", "K_new", "y_new"));

fit_rats_hier_logit <- stan("hier-logit.stan", chains = 4,
                            data = c("N", "K", "y", "K_new", "y_new"));

save.image(file = "fits_stan.Rdata")