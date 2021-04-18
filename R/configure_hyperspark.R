#' @title Configure HyperSpark
#'
#' @description Lets users configure HyperSpark.
#'
#' @param y A number.
#'
#' @return NULL
#'
#' @examples configure_hyperspark()
#'
#' @export configure_hyperspark

configure_hyperspark <- function(...){  # ... = any arguments
  # Take in user parameters

  # Create an executable Scala object (string)

  # Save as Scala file in HyperSpark

  # Temporary example:
  # Writing the file to HyperSpark
  f = "hyperspark-1-master/src/main/scala/it/polimi/hyperh/apps/MainClass.scala"
  fileConn <- file(f)  # File is overwritten if it already exists.
  content = 'package it.polimi.hyperh.apps

  import it.polimi.hyperh.problem.Problem
  import it.polimi.hyperh.spark.Framework
  import it.polimi.hyperh.spark.FrameworkConf
  import it.polimi.hyperh.spark.TimeExpired
  import pfsp.problem.PfsProblem
  import pfsp.algorithms.IGAlgorithm
  import pfsp.algorithms.GAAlgorithm


  object MainClass {
    def main(args: Array[String]) {
      val problem = PfsProblem.fromResources("inst_ta054.txt")
      val makeAlgo = () => new GAAlgorithm()
      val numOfAlgorithms = 4
      val totalTime = problem.getExecutionTime()
      val numOfIterations = 1
      val iterTimeLimit = totalTime / numOfIterations
      val stopCond = new TimeExpired(iterTimeLimit)
      val randomSeed = 118337975

      val conf = new FrameworkConf()
      .setRandomSeed(randomSeed)
      .setDeploymentLocalNumExecutors(numOfAlgorithms)
      .setProblem(problem)
      .setNAlgorithms(makeAlgo, numOfAlgorithms)
      .setNDefaultInitialSeeds(numOfAlgorithms)
      .setNumberOfIterations(numOfIterations)
      .setStoppingCondition(stopCond)

      val solution = Framework.run(conf)
      println(solution)
    }
  }
  '
  writeLines(content, fileConn)
  close(fileConn)
  print("HyperSpark configuration set")
}




