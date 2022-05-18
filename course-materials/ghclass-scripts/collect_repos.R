# This script is to collect projects/labs/assignments from students

library(ghclass)
#library(gitcreds)
library(gert)
#gitcreds::gitcreds_set()
#org_sitrep(org = "github organization")

assingment_name = 'exam-02'

setwd("C:\\users\\tgeorge\\Desktop")

#dir.create(assingment_name) #if not created yet

# This will clone all repo's in your organziation with exam-02 in their name
local_repo_clone(
  repo = org_repos("github organization name", "exam-02"),
  local_path = assingment_name
)


