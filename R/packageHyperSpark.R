#' @title Execute HyperSpark
#'
#' @description Executes HyperSpark.
#'
#' @param NULL
#'
#' @return NULL
#'
#' @examples packageHyperSpark()
#'
#' @export packageHyperSpark

packageHyperSpark <- function(){
  # Navigate to HyperSpark project and package with Maven in terminal
  command <- "cd HyperSpark-master && mvn package"
  # output <- shell(command, intern = F, show.output.on.console = build_output)
  output <- shell(command, intern = F)
  if (output == 1){
    return("Error: shell command failed")
  } else{
    return("HyperSpark succesfully packaged")
  }
}
