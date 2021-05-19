#' @title Execute HyperSpark
#'
#' @description Executes HyperSpark.
#'
#' @param execution_ouput If set to TRUE the terminal output of the execution
#'   process is shown in the console, mainly useful for developing and
#'   debugging. The default value is FALSE.
#'
#' @return NULL
#'
#' @examples execute_jar()
#'
#' @export executeHyperSpark

executeHyperSpark <- function(){
  # Execute HyperSpark in terminal
  command <- "cd HyperSpark-master && java -jar target/hyperh-0.0.1-SNAPSHOT-allinone.jar"
  output <- shell(command, intern = T)
  return(output)
}
