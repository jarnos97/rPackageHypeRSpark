#' @title Execute HyperSpark
#'
#' @description Executes HyperSpark.
#'
#' @param execution_ouput Shows the terminal output of the execution process,
#'   mainly useful for developing and debugging.
#'
#' @return NULL
#'
#' @examples execute_jar()
#'
#' @export execute_jar

execute_jar <- function(execution_output = F){
  # Execute HyperSpark in terminal
  command <- "cd hyperspark-1-master && java -jar target/hyperh-0.0.1-SNAPSHOT-allinone.jar"
  output <- shell(command, intern = T, show.out.on.console = execution_output)
  return(output)
}
