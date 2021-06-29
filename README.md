# rPackageHypeRSpark

This package offers a low-code R-interface for the [HyperSpark Framework](https://github.com/jarnos97/HyperSpark); a data-intensive programming environment for parallel metaheuristics. 
The package allows users to easily create an application in HyperSpark for the distributed execution of metaheuristics. 
The intention is that through the open-source nature of HyperSpark, more problems and algorithms will be implemented in the future, which can then be applied in this package. 
The R package is structured around four main functions: installing HyperSpark's source code, configuring HyperSpark, packaging, and execution. 
Users can select a problem, algorithm(s), and configure the framework based on their needs. 
Subsequently, the framework is packaged to a JAR archive. 
Upon execution the framework either connects to a JVM instance and executes HyperSpark, in the case of local execution, or the user submits the packaged framework to a cluster with Spark, in case of distributed execution. 

*Please note that the package has currently only been tested for Windows systems.*


The package needs to be built in order to be used. HypeRSpark can be directly installed from GitHub using R's developer tools package, called \emph{devtools}. 
Doing only requires a single line of code, shown below (line 28). In the case that the user does not have devtools installed, line 26 should also be executed.
Two forms of documentation have been developed to guide users. 
First, the package includes object documentation, accessible through R's *help* function. 
This type of documentation is useful when the user knows which function they want information about. 
However, this is not always the case. Subsequently, a detailed \emph{vignette} was developed as a secondary form of documentation. 
The vignette is added to the GitHub repository of the package. 
The vignette is built when installing the packages, through the *build_vignettes* argument, this can be time consuming. 
Building the vignette requires *rmarkdown* to be installed. 
Consequently, users who do not have rmarkdown installed need to execute line 27. 
Inside the package, the vignette can be viewed using R's  *browseVignettes* function. 

install.packages("devtools")
install.packages("rmarkdown")
devtools::install_github("jarnos97/rPackageHypeRSpark", build_vignettes = TRUE)
