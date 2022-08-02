# This is to converty my xaringan html to powerpoint
# Code credit: gadenbuie 
# https://github.com/gadenbuie/xaringan2powerpoint

#pagedown::chrome_print("slides\\poster_slides.html", output = "poster_slides.pdf")
# First manually save using google chrome

pages <- pdftools::pdf_info("slides/poster_slides.pdf")$pages
filenames <- sprintf("poster_slides/slides_%02d.png", 1:pages)
#dir.create("slides/poster_slides")
pdftools::pdf_convert("slides/poster_slides.pdf", dpi=300,
                      filenames = paste0("slides/",filenames))

slide_images <- glue::glue(
  "
---

![]({filenames}){{width=100%}}

")

slide_images <- paste(slide_images, collapse = "\n")

md <- glue::glue(
  "
  ---
  output: 
    powerpoint_presentation:
      reference_doc: powerpoint_template.pptx
  ---
  {slide_images}
  "
)

cat(md, file = "slides/slides_powerpoint.Rmd")

rmarkdown::render("slides/slides_powerpoint.Rmd")  ## powerpoint!
