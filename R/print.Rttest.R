#' Print Function
#'
#' @param x the rttest class object
#' @param ... extra parameters
#'
#' @importFrom kableExtra 'kable' 'row_spec' 'kable_styling'
#' @importFrom dplyr '%>%'
#'
#' @return print the info
#' @rdname print.Rttest
#' @export
#'
#' @examples set.seed(21);x <-rnorm(30,5,2); set.seed(23); y<- rnorm(30, 3,2);
#' alpha <- 0.05; obj <- myttest(x = x, y = y, alpha = 0.05); print(obj)
#'
print.Rttest = function(x, ...) {
  #print test type
  print(paste0("t-test Type: ", x$testType))

  #Print alpha
  print(paste0("Alpha value: ", x$alpha))

  #print the confidence interval
  print(paste0(((1-x$alpha)*100), "% Confidence Interval of mu_x and mu_y: "))
  print(x$statistics$conf.int)

  #Print dataframe using Kable
  print(paste("Dataframe: "))
  # print(kableExtra::kable(x$data))
  kable(x$data) %>% kable_styling("hover", full_width = F, position = "center")
}
