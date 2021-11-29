
setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/DSC223PrepRep/Notes/Jumbo Slide 4")

slide_name = "u2-Jumbo03-u2-10-11-12-13"

library(xaringanBuilder)

build_pdf(paste0(slide_name,'.rmd'), complex_slides = TRUE, partial_slides = TRUE)
#build_pdf(paste0(slide_name,'.html'), complex_slides = TRUE, partial_slides = TRUE)

# OR dektape
system("`npm bin`/decktape remark slides.html slides.pdf") #
xaringan::decktape()