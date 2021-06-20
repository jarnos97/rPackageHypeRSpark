#' @title Execute HyperSpark
#'
#' @description Executes the framework locally. This requires that packaging has
#' been successfully executed.
#'
#' @return NULL
#'
#' @examples executeHyperSpark()
#'
#' @export executeHyperSpark

executeHyperSpark <- function(){
  # Execute HyperSpark in terminal
  command <- "cd HyperSpark-master && java -jar target/hyperh-0.0.1-SNAPSHOT-allinone.jar"
  output <- shell(command, intern = T)
  return(output)
}
