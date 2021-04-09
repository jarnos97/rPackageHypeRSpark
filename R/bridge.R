#' @title A framework for parallel and distributed metaheuristics
#'
#' @description
#'
#' @param NULL
#'
#' @return scala bridge
#'
#' @examples config()
#'
#' @export config

config <- function(){
  conn <- rscala::scala(JARs = "inst/temp_2.13-0.1.jar")
  return(conn)
}
