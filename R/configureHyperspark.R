#' @title Configure HyperSpark
#'
#' @description Lets users configure HyperSpark. The result is a written .scala
#' file, which is added to the HyperSpark source code.
#'
#' @param setProblem Set the problem to be solved.
#' @param data Set the data for the application.
#' @param setStoppingCondition Set the stopping condition for algorithms to
#' terminate.
#' @param stoppingValue Set the stopping value for the stopping condition.
#' @param setAlgorithms Set the algorithms to execute. Always include
#' parentheses, e.g. GAAlgorithm()
#
#'
#' @return NULL
#'
#' @examples hypeRSpark::configureHyperSpark(setProblem = 'PfsProblem',
#' data = 'inst_ta054.txt', setStoppingCondition = 'TimeExpired',
#' stoppingValue = 1000, setAlgorithms = 'GAAlgorithm', numOfAlgorithms = 4,
#' setDeploymentLocalMaxCores = T, setNumberOfIterations = 100,
#' setNDefaultInitialSeeds = 4)
#'
#' @export configureHyperSpark
#'
#' @importFrom rt3 NONE

# Function needs to accept an arbitrary number of arguments.
configureHyperSpark <- function(setProblem,
                                data,
                                setStoppingCondition,
                                stoppingValue,
                                setAlgorithms,
                                numOfAlgorithms = NONE,
                                setNumberOfIterations = NONE,
                                setInitialSeeds = NONE,
                                setNInitialSeeds= NONE,
                                setNDefaultInitialSeeds = NONE,
                                setSeedingStrategy = NONE,
                                setProperty = NONE,
                                setMapReduceHandler = NONE,
                                setRandomSeed = NONE,
                                setSparkMaster = NONE,
                                setAppName = NONE,
                                setNumberOfExecutors = NONE,
                                setNumberOfResultingRDDPartitions = NONE,
                                setDeploymentLocalNoParallelism = NONE,
                                setDeploymentLocalNumExecutors = NONE,
                                setDeploymentLocalMaxCores = NONE,
                                setDeploymentSpark = NONE,
                                setDeploymentMesos = NONE,
                                setDeploymentYarnClient = NONE,
                                setDeploymentYarnCluster = NONE){
  # Define scala file
  class_file <- "HyperSpark-master/src/main/scala/it/polimi/hyperh/apps/MainClass.scala"  # TODO: this will be different!s

  # Create scala file and add constant code
  initializeFile <- function(){
    # Define constant code (which we always need)
    constantCode <- 'package it.polimi.hyperh.apps

import it.polimi.hyperh.solution.EvaluatedSolution
import it.polimi.hyperh.spark.Framework
import it.polimi.hyperh.spark.FrameworkConf
import java.io._
'

    # Create scala file with constant code
    fileConn <- file(class_file)  # File is overwritten if it already exists.
    writeLines(constantCode, fileConn)
    close(fileConn)  # Close connection here, we cannot use this to append
  }  # end initializeFile


    # Add additional imports based on user input
  addImports <- function(){
    # Define stopping condition import
    stoppingImport <- sprintf("import it.polimi.hyperh.spark.%s", setStoppingCondition)
    write(stoppingImport, class_file, append = T)
    # Find the problem path
    problemPath <- tolower(setProblem)
    problemPath <- stringr::str_remove(problemPath, "problem")
    # Define problem import
    problemImport <- sprintf("import %sp.problem.%s", problemPath, setProblem)
    write(problemImport, class_file, append = T)
    # Define algorithm import(s) and write to file
    for (alg in setAlgorithms){
      alg <- strsplit(alg, "\\(")[[1]][1]  # Extract algorithm
      alg_import <- sprintf("import %sp.algorithms.%s", problemPath, alg)
      write(alg_import, class_file, append = T)
    }

    if (setMapReduceHandler != NONE){
      mp_import <- sprintf("import it.polimi.hyperh.spark.%s", setMapReduceHandler)
      write(mp_import, class_file, append = T)
    }
  }  # end addImports


  # Create MainClass object and define main function
  createObject <- function(){
    object <- '
object MainClass{
  def main(args: Array[String]) {
'
    write(object, class_file, append = T)
  }  # end createObject


  # Define the necessary variables
  defineVariables <- function(){
    # Define problem
    defProblem <- sprintf('    val problem = %s.fromResources(fileName="%s")',
                          setProblem, data)  # fromResources is problem specific!
    write(defProblem, class_file, append = T)
    # Define algorithms
    if (numOfAlgorithms != NONE){  # i.e. if a single algorithm is set
      defAlgorithm <- sprintf('    val makeAlgo = new %s', setAlgorithms)
      write(defAlgorithm, class_file, append = T)
      defNumOfAlgorithms <- sprintf('    val numOfAlgorithms = %s', numOfAlgorithms)
      write(defNumOfAlgorithms, class_file, append = T)
    } else{
      for (alg in setAlgorithms){
        alg2 <- strsplit(alg, "\\(")[[1]][1]  # Extract algorithm
        defAlgorithm <- sprintf('    val alg%s = new %s', alg2, alg)
        write(defAlgorithm, class_file, append = T)
      }
    }
  }  # end defineVariables


  # helper function for configuration()
  string_array <- function(algs){
    text <- 'Array('
    index <- 1
    for (item in algs){
      if (index == length(algs)){ # if it is the last item
        text <- paste0(text, item, ')')
      } else {
        text <- paste0(text, item, ', ')
      }
      index <- index + 1
    }
    return(text)
  }


  # Create Framework configuration
  configuration <- function(){
    # Constant beginning
    frameworkConf <- '    val conf = new FrameworkConf()'
    problem <- '      .setProblem(problem)'
    # Define algorithms
    if (numOfAlgorithms != NONE){  # i.e. if a single algorithm is set
      defAlgorithms <- '      .setNAlgorithms(makeAlgo, numOfAlgorithms)'
    } else {  # i.e. array of algorithms
      algs <- NULL
      for (alg in setAlgorithms){
        alg <- strsplit(alg, "\\(")[[1]][1]  # Extract algorithm
        alg_code <- sprintf('alg%s', alg)
        algs <- c(algs, alg_code)
      }
      # Convert algs to string array
      algs <- string_array(algs)
      defAlgorithms <- sprintf('      .setAlgorithms(%s)', algs)  # Should be an array!
    }
    # Define stopping condition
    defStoppingCondition <- sprintf("      .setStoppingCondition(new %s(%s))",
                                    setStoppingCondition, stoppingValue)
    # Write lines to file
    for (line in c(frameworkConf, problem, defAlgorithms, defStoppingCondition)){
      write(line, class_file, append = T)
    }
    # Set deployment parameter
    deployment_names <- c('setDeploymentLocalNoParallelism',
                          'setDeploymentLocalNumExecutors',
                          'setDeploymentLocalMaxCores', 'setDeploymentSpark',
                          'setDeploymentMesos', 'setDeploymentYarnClient',
                          'setDeploymentYarnCluster')
    deployment_params <- c(setDeploymentLocalNoParallelism,
                           setDeploymentLocalNumExecutors,
                           setDeploymentLocalMaxCores, setDeploymentSpark,
                           setDeploymentMesos, setDeploymentYarnClient,
                           setDeploymentYarnCluster)
    index <- 1
    for (deployment in deployment_params){
      if (deployment != NONE){
        if (deployment == T){  # if there is no parameter for the deployment mode
          defDeployment <- sprintf('      .%s()', deployment_names[index])
        } else {  # if there is a parameter
          defDeployment <- sprintf('      .%s(%s)', deployment_names[index],
                                                    deployment)
        }
        write(defDeployment, class_file, append = T)
        break  # Only one deployment mode should not be NONE, thus we can break
      }
      index <- index + 1
    }
    # Set the optional parameters. Except seeding strategy
    param_names <- c('setNumberOfIterations', 'setInitialSeeds',
                     'setInitialSeeds', 'setNDefaultInitialSeeds',
                     'setProperty', 'setRandomSeed',
                     'setSparkMaster', 'setAppName', 'setNumberOfExecutors',
                     'setNumberOfResultingRDDPartitions')
    optional_params <- c(setNumberOfIterations, setInitialSeeds,
                         setNInitialSeeds, setNDefaultInitialSeeds,
                         setProperty, setRandomSeed,
                         setSparkMaster, setAppName, setNumberOfExecutors,
                         setNumberOfResultingRDDPartitions)
    # Write all defined parameters to file
    index <- 1
    for (param in optional_params){
      if (param != NONE){
        param_line <- sprintf('      .%s(%s)', param_names[index],  param)  # Assumes each parameter gets an argument, True?
        write(param_line, class_file, append = T)
      }
      index <- index + 1
    }

    # Set seeding strategy
    if (setSeedingStrategy != NONE){
      s_str <- sprintf('      .setSeedingStrategy(new %s)', setSeedingStrategy)
      write(s_str, class_file, append = T)
    }

    # Set MapReduce handler
    if (setMapReduceHandler != NONE){
      s_str <- sprintf('      .setMapReduceHandler(new %s())', setMapReduceHandler)
      write(s_str, class_file, append = T)
    }




  } # End configuration

  # Add constant ending
  addEnding <- function(){
    ending <- '
    val solution: EvaluatedSolution = Framework.run(conf)

    // Write solutions to file
    val fw = new FileWriter("solution.txt.")
    try {
      fw.write(solution.toString)
    }
    finally fw.close()

    println(solution)
  }
}
'
  # Write to file
  write(ending, class_file, append = T)
  }  # end addEnding


  # Execute functions
  initializeFile()
  addImports()
  createObject()
  defineVariables()
  configuration()
  addEnding()
}
