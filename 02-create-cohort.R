# load libraries
library(MatchIt)
library(arrow)

# load population
pop <- read_feather("<population filepath>")

# apply correct formula, depending on if you want to include healthcare utilization covariates
m.out <- matchit(endo ~ age + gender + race + ethnicity, data = pop, method = "nearest", ratio = 30)
m.out <- matchit(endo ~ age + gender + race + ethnicity + num_visits + record_duration, data = pop, method = "nearest", ratio = 30)

# save results
m.data <- match.data(m.out, distance = "pscore")
write_feather(m.data, "<cohort filepath>")