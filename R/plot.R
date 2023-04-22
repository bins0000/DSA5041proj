#' Plot Function
#'
#' @param x data
#' @param ... others just to make the arguments match the base function
#'
#' @return a box plot
#' @export
#'
#' @importFrom ggplot2 'ggplot'
#' @importFrom ggplot2 'geom_boxplot'
#' @importFrom ggplot2 'aes'
#'
plot.Rttest = function(x, ...){
  # stacking data
  value <- c(x$data$x, x$data$y)
  data <- rep(c("x", "y"), c(length(x$data$x), length(x$data$y)))
  stacked_data <- data.frame("value" = value, "data" = data)
  p <- ggplot(stacked_data) + geom_boxplot(aes(x = data, y = value))
  print(p)

}
