# file_head: tdaUtils.R
create_unif_cover <- function(inf, sup, overlap = .1, n_int = 30) {
  step <- (sup - inf)/n_int
  d <- data.frame()
  for (i in 1:n_int) {
    d <- rbind(d, data.frame(
      inf = inf + (i-1)*step - overlap*step/2,
      sup = inf + i*step + overlap*step/2
    ))
  }
  d
}

map_from_cover <- function(cover, var, condensed = FALSE) {
  if (condensed) {
    out <- vector("list", length(var))
  } else{
    out <- matrix(0, nrow = length(var), ncol = nrow(cover))
  }
  for (i in 1:length(var)) {
    belongs_to <- which(var[i] >= cover[[1]] & var[i] <= cover[[2]])
    if (condensed) {
      out[[i]] <- belongs_to
    } else {
      out[i, belongs_to] <- 1
    }
  }
  out
}

# tda_group <- function(data, var) {
#   
# }


# test
cover <- create_unif_cover(0, 1)
belong_to <- map_from_cover(cover, seq(0,1,.1))
object.size(belong_to)
belong_to2 <- map_from_cover(cover, seq(0,1,.1), condensed = TRUE)
object.size(belong_to2)
