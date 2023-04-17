#' Print Function
#'
#' @param obj
#'
#' @return
#' @export
#'
#' @examples
#'
print.Rttest = function(obj) {
  library(magrittr)
  library("kableExtra")

  #Print alpha
  print(paste("Alpha value: ", obj$alpha))

  #print p-value
  print(paste("p-value: ", obj$pVal))

  #print the confidence interval
  print(paste("Confidence Interval of mu_x and mu_y: "))
  print(obj$confInt)

  #Print dataframe using Kable
  print(paste("Dataframe: "))
  # print(kableExtra::kable(obj$data))
  kable(obj$data) %>% kable_styling("hover", full_width = F, position = "center")
}
