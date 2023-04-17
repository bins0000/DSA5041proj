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
#' alpha <- 0.05; obj <- myconstr(x = x, y = y, alpha = 0.05); print(obj)
#'
print.Rttest = function(x, ...) {
  #Print alpha
  print(paste("Alpha value: ", x$alpha))

  #print p-value
  print(paste("p-value: ", x$pVal))

  #print the confidence interval
  print(paste("Confidence Interval of mu_x and mu_y: "))
  print(x$confInt)

  #Print dataframe using Kable
  print(paste("Dataframe: "))
  # print(kableExtra::kable(x$data))
  kable(x$data) %>% kable_styling("hover", full_width = F, position = "center")
}
