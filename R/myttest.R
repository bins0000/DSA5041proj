#' Constructor Function
#'
#' @param x data list
#' @param y data list
#' @param paired flag for paired t-test
#' @param alpha error level
#'
#' @importFrom stats t.test
#' @importFrom stats var.test
#'
#' @return a named list containing data, alpha value, confidence interval, p-Value
#' @export
#'
#' @examples set.seed(21);x <-rnorm(30,5,2); set.seed(23); y <- rnorm(40, 3,2);
#' alpha <- 0.05; obj <- myttest(x = x, y = y, alpha = 0.05)
#'
myttest <- function(x, y, paired = FALSE, alpha = 0.05){

  # checking arguments if they are input correctly
  # check if x is numeric
  if(!is.numeric(x)){
    stop(paste0("Input x is of class ", class(x), ". A numeric vector must be passed."))
  }

  # check if y is numeric
  if(!is.numeric(y)){
    stop(paste0("Input y is of class ", class(y), ". A numeric vector must be passed."))
  }

  # check if paired flag is Boolean
  if(!is.logical(paired)){
    stop(paste0("input paired is of class ", class(paired), ". only TRUE or FALSE must be passed."))
  }

  # check if alpha is between 0 - 1
  if(alpha < 0 || alpha > 1){
    stop(paste0("Input alpha out of bounds -- Alpha must be between 0 and 1"))
  }

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


  # check sample variance, decide which t-test to run

  # if the paired argument is true, we can so a paired t-test
  if(paired){
    ttestType <- "Paired"
    ttest<-t.test(x, y, mu=0, paired = TRUE, conf.level = 1-alpha)
  }

  # else we use unpaired t-test
  else{
    # perform an f-test to check variances
    # if f-test p-value is more than alpha, we can assume that the sample variances are equal
    if(var.test(x,y)$p.value > alpha){
      ttestType <- "T-test"
      ttest<-t.test(x, y, var.equal = TRUE, conf.level = 1-alpha)
    }
    else{
      ttestType <- "Welch"
      ttest<-t.test(x, y, var.equal = FALSE, conf.level = 1-alpha)
    }
  }

  # evaluate the result
  if(ttest$p.value < alpha) {
    result = 'Y'
  }
  else{
    result = 'N'
  }

  # return a named list containing a data frame containing x and y, alpha,
  # confidence interval for mux-muy, pvalue
  obj <- list(data = df,
              alpha = alpha,
              result = result,
              statistics = ttest,
              testType = ttestType)

  # the list will be of class "Rttest"
  class(obj) <- "Rttest"

  # just output the list if function being called without storing
  obj
}
