# This script is to collect projects/labs/assignments from students

library(ghclass)
#library(gitcreds)
library(gert)
#gitcreds::gitcreds_set()
#org_sitrep(org = "DSC223-FB4-2021")




assingment_name = 'exam-02'

setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/Grading/Final Exams")

#dir.create(assingment_name)

local_repo_clone(
  repo = org_repos("DSC223-FB4-2021", "exam-02"),
  local_path = assingment_name
)







setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/DSC223PrepRep")



# Add students to organzation
#org_invite(org = 'DSC223-FB4-2021',user = roster$github)

# Add individual user
#org_invite(org = 'DSC223-FB4-2021', user = 'Twu23')


# Check current org members
org_members('DSC223-FB4-2021')

# Check pending invites
org_pending('DSC223-FB4-2021')

# This next section is how to prep and disperse repos

# First you need to create a repo out of just the hw/lab you want to disperse
# Next make it a template

repo_name = "lab-03-nobel-laureates"

repo_set_template(paste0("DSC223-FB4-2021/",repo_name))

repo_is_template(paste0("DSC223-FB4-2021/",repo_name))

# add the yml file for badge
setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/Assignment and Lab Repos")
dir.create("lab-03-nobel-laureates/.github")
dir.create("lab-03-nobel-laureates/.github/Workflows")
file.copy("U:/My Drive/Cornell College/Cornell Classes/Data Science/Tech Setup/check_rmd.yml", "lab-03-nobel-laureates/.github/workflows")

# PUSH

# Add the rmarkdown compile badge
action_add_badge(
  repo=paste0("DSC223-FB4-2021/",repo_name),
  workflow = 'Render R Markdown files',
  where = "",
  line_padding = "\n\n\n",
  file = "README.md"
)

# This will create an individual assignment
org_create_assignment(
  org = "DSC223-FB4-2021",
  user = "Twu23",
  repo = paste0(paste0(repo_name,"-indi-2"), "Twu23"),
  source_repo = paste0("DSC223-FB4-2021/",repo_name),
  private = TRUE
)

#Team assignment
org_create_assignment(
  org = "DSC223-FB4-2021",
  user = roster$github,
  repo = paste0(repo_name,"_team_",roster$lab2),
  team = paste0(repo_name,"_team_",roster$lab2),
  source_repo = paste0("DSC223-FB4-2021/",repo_name),
  private = TRUE
)

