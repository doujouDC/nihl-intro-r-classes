# Cleaning Up File Names

startingDir <- ("/Users/douglasjoubert/Documents/nihl-intro-r-series/dataviz-images/")

list.files(startingDir)

filez <- list.files(startingDir, pattern = "*.PNG", full.names = TRUE)
head(filez)

sapply(filez,FUN=function(eachPath){
  file.rename(from=eachPath,to=sub(pattern ="_",replacement = "-",eachPath))
})