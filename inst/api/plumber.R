library(plumber)
r <- plumb("inst/api/api.R")
r$run(port = 8888, host = "0.0.0.0")
