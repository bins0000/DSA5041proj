#' Constructor Function
#'
#' @param x
#' @param y
#' @param alpha
#'
#' @return
#' @export
#'
#' @examples
#'
myconstr <- function(x,y,alpha){
  # put x and y in a dataframe **however, a dataframe needs same length vectors..
  # thus, fill the 'missing values'
  if(length(x) < length(y)){                    # if y is larger than x
    x <- c(x,rep(NA, length(y) - length(x)))    # fill NAs to meet the same length
    df <- data.frame(x,y)                       # put x and y in a dataframe
  }
  else if(length(x) > length(y)){               # if x is larger than y
    y <- c(y,rep(NA, length(x) - length(y)))    # do the opposite of the above
    df <- data.frame(x,y)
  }
  else{                                         # else x and y has equal length
    df <- data.frame(x,y)
  }

  # t-test (assuming that the variances in the population are the same)
  ttest <-  t.test(x , y, mu = 0, paired = FALSE, var.equal = TRUE, conf.level = 1-alpha)

  # a named list containing A data frame containing x and y, alpha,
  # The confidence interval for mux-muy, The pvalue
  obj <- list(data = df, alpha = alpha, confInt = ttest$conf.int, pVal = ttest$p.value)

  # the list will be of class "Rttest"
  class(obj) <- "Rttest"

  # just output the list if function being called without storing
  obj
}
