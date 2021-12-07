library(xaringanBuilder)

setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/Notes/mod-u4-d05-more-model-multiple-predictors")

slide_name = "u4-d05-more-model-multiple-predictors"

build_pdf(paste0(slide_name,'.rmd'), complex_slides = TRUE, partial_slides = TRUE)
#build_pdf(paste0(slide_name,'.html'), complex_slides = TRUE, partial_slides = TRUE)

# OR dektape
system("`npm bin`/decktape remark slides.html slides.pdf") #
xaringan::decktape()