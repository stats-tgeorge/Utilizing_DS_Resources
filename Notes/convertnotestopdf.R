library(xaringanBuilder)

setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/Notes/mod-u4-d09-CV")

slide_name = "mod-u4-d09-CV"

build_pdf(paste0(slide_name,'.rmd'), complex_slides = TRUE, partial_slides = TRUE)
#build_pdf(paste0(slide_name,'.html'), complex_slides = TRUE, partial_slides = TRUE)

# OR dektape
system("`npm bin`/decktape remark slides.html slides.pdf") #
xaringan::decktape()