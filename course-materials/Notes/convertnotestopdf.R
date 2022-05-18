library(xaringanBuilder)

setwd("Your directory")

slide_name = "mod-u4-d09-CV"

# This sometimes needs run twice
build_pdf(paste0(slide_name,'.rmd'), complex_slides = TRUE, partial_slides = TRUE)
#build_pdf(paste0(slide_name,'.html'), complex_slides = TRUE, partial_slides = TRUE)

# OR dektape
system("`npm bin`/decktape remark slides.html slides.pdf") #
xaringan::decktape()