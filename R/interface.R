##' Interface
##' 
##' This is the main function that runs the program.
##' 
##' @return Nothing, but files are modified and the quizzes ran.
##' 

interface <- function(){
  #Load vocabFile: either record of progress or new file to add words
  while(!"vocabFile" %in% ls(".GlobalEnv")){
    name = start()
  }
  finished=FALSE
  while(!finished){
    prompt = -1
    while(!prompt %in% 1:9){
      cat("Your vocabulary list currently has",nrow(vocabFile),"words.\n")
      cat("What would you like to do?\n")
      cat("(1) Enter new words\n")
      cat("(2) Begin vocabulary quiz\n")
      cat("(3) Begin conjugation quiz\n")
      cat("(4) Begin verb quiz\n")
      cat("(5) Save and Exit\n")
      cat("(6) Create Backup\n")
      cat("(7) Don't Save and Exit\n")
      cat("(8) Check for duplicates\n")
      cat("(9) Show Statistics\n")
      prompt = readline()
    }
    if(prompt==1)
      addWord()
    if(prompt==2)
      beginQuiz(type = "vocabulary")
    if(prompt==3){
      if(numLanguages != 2)
        stop("This isn't implemented for numLanguages != 2!")
      beginQuiz(type = "conjugation")
    }
    if(prompt==4){
      if(numLanguages != 2)
        stop("This isn't implemented for numLanguages != 2!")
      while(!"verbFile" %in% ls(".GlobalEnv"))
        name = startVerb() # defines verbFile
      wrapVerbQuiz(name = name)
    }
    if(prompt==5){
      finished=TRUE
      #save(vocabFile, file=paste0(name,".RData"))
      success = FALSE
      while(!success){
        test = try(write.csv(vocabFile, file=paste0(name,".csv"), row.names = FALSE))
        if(is(test, "try-error")){
            readline(("File save was unsuccessful.  Please close and press enter to try again."))
        } else {
            success = TRUE
            cat("File saved successfully!\n")
        }
      }
    }
    if(prompt==6){
#       file =paste0(name,"_",round(as.numeric(Sys.time())),".RData")
#       save(vocabFile, file=file)
      file =paste0(name,"_",round(as.numeric(Sys.time())),".csv")
      write.csv(vocabFile, file=file, row.names = FALSE)
      cat("Backup file", file, "created.\n\n")
    }
    if(prompt==7)
      finished=TRUE
    if(prompt==8){
      if(numLanguages != 2){
        warning("This isn't implemented for numLanguages != 2!")
      } else {
        checkDupes()
      }
    }
    if(prompt==9){
      computeStats()
    }
  }
}