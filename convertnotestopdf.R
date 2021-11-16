
setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/DSC223PrepRep/Notes/Jumbo Slide 2")

slide_name = "u2-Jumbo01-u2-01-02-03-04"

library(xaringanBuilder)

build_pdf(paste0(slide_name,'.rmd'), complex_slides = TRUE, partial_slides = TRUE)
#build_pdf(paste0(slide_name,'.html'), complex_slides = TRUE, partial_slides = TRUE)
