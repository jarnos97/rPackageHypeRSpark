#' @title Execute HyperSpark
#'
#' @description Executes HyperSpark.
#'
#' @param NULL
#'
#' @return NULL
#'
#' @examples package()
#'
#' @export package()

package <- function(build_output = F){
  # Navigate to HyperSpark project and package with Maven in terminal
  command <- "cd hyperspark-1-master && mvn package"
  output <- shell(command, intern = F, show.out.on.console = build_output)
  if (output == 1){
    return("Error: shell command failed")
  } else{
    return("HyperSpark succesfully packaged")
  }
}
