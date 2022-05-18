# Slides

## Instructor Comments

This folder contains the slides used int eh class, many of which have been combined in their original form from [here](https://github.com/rstudio-education/datascience-box/tree/main/course-materials/slides), to *Jumbo* versions that were presented in larger chunks. Generally, these are still group by a larger cohesive chapter/theme. Some of the later more disjoint topics were slightly modified but left as single note sections. 

#### Linking Git and R

PROBABLY NOT NEEDED. This folder contains a simple script to help students link their Github to RStudio on the RStudio server. At the time it was believed that this might mean they would not need to renter their PAT again. This doe not work, though a later lab gives them a command that will lengthen the time before they need to enter it again. 


#### convertnotestopdf.R

Also included is *convertnotestopdf.R* which is an example of using ** xaringanBuilder** R package to convert the Xaringan slides to pdfs. In the future the plan is to host all the slides using Github pages instead. Part of this reasoning is that converting the notes to pdf will create multiple pages for each added figure to a slide. This makes them often over 100 pages long!

#### Notes

The notes u5-d05-shiny-1 and u5-d06-shiny-2 were left unchanged. 

## Data Science in a Box author Mine \c{C}etinkaya-Rundel comments:

### Toolkit

Slides are built in using the **xaringan** package. See [here](https://github.com/yihui/xaringan) for more info on xaringan. There are two main reasons for choosing this format:

1. `xaringan` slides are R Markdown based, meaning code, output, and narrative can all live in one place and compiling the slides will run the R code as well.
2. Slide output is mobile friendly.

### Instructions

Each slide deck is in its own folder, and one level above there is a custom css file. To compile the slides use `xaringan::inf_mr(cast_from = "..")`. This will launch the slides in the Viewer, and it will get updated as you edit and save your work.

