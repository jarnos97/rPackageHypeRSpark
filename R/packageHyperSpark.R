#' @title Execute HyperSpark
#'
#' @description Packages the framework to a JAR archive.
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
  output <- shell(command, intern = F)
  if (output == 1){
    return("Error: shell command failed")
  } else{
    return("HyperSpark succesfully packaged")
  }
}
