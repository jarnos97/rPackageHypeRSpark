#' @title Execute HyperSpark
#'
#' @description Executes HyperSpark.
#'
#' @param NULL
#'
#' @return NULL
#'
#' @examples execute_hyperspark()
#'
#' @export execute_hyperspark

execute_hyperspark <- function(){

  package <- function(){
    # Navigate to HyperSpark project and package with Maven in terminal
    command <- "cd hyperspark-1-master && mvn package"
    output <- shell(command, intern = F)
    if (out == 1){
      return("Error: shell command failed")
    } else{
      return("Shell command successfuly executed")
    }
  }

  # Package to jar
  package()


  execute_jar <- function(){
    # Execute HyperSpark in terminal
    command <- "cd hyperspark-1-master && java -jar target/hyperh-0.0.1-SNAPSHOT-allinone.jar"
    output <- shell(command, intern = F)
    if (out == 1){
      return("Error: shell command failed")
    } else{
      return("Shell command successfully executed")
    }
  }

  # Execute jar file
  execute_jar()
}
