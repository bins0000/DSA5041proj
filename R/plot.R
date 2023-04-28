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
#' @importFrom ggplot2 'labs'
#' @importFrom ggplot2 'geom_errorbar'
#' @importFrom ggplot2 'ggtitle'
#' @importFrom ggplot2 'aes'
#'
plot.Rttest = function(x, ...){

  # stacking data
  value <- c(x$data$x, x$data$y)
  data <- rep(c("x", "y"), c(length(x$data$x), length(x$data$y)))
  stacked_data <- data.frame("value" = value, "data" = data)

  # check if t-test is paired, make a boxplot of differences in data when paired = TRUE
  if(x$testType == "Paired"){
    # take the difference between the samples
    differences <- stacked_data[stacked_data[,2]=='x',1] - stacked_data[stacked_data[,2]=='y',1]
    p <- ggplot(stacked_data[stacked_data[,2]=='x',], aes(x=rep("x",length(differences)),y=differences)) +
      geom_boxplot() +
      geom_errorbar(aes(ymin=x$statistics$conf.int[1],
                        ymax=x$statistics$conf.int[2],
                        size = 3,
                        width = 0),
                    show.legend = FALSE) +
      labs(x="Difference", y="Value") +
      ggtitle("Difference Between x And y")
    print(p)
  }
  # if not paired then plot boxplots of the data
  else{
    p <- ggplot(stacked_data) + geom_boxplot(aes(x = data, y = value)) +
      ggtitle("Box-Plot of Data x And y")
    print(p)
  }


}
