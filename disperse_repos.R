# This script is to disperse projects/labs/assignments to students

library(ghclass)
library(gitcreds)

#gitcreds::gitcreds_set()
org_sitrep(org = "DSC223-FB4-2021")


setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/DSC223PrepRep")

roster = read.csv('roster.csv')

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

repo_name = "lab-15-shiny-intro"

repo_set_template(paste0("DSC223-FB4-2021/",repo_name))

repo_is_template(paste0("DSC223-FB4-2021/",repo_name))

# add the yml file for badge
setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/Assignment and Lab Repos")

dir.create(paste0(repo_name,"/.github"))
dir.create(paste0(repo_name,"/.github/workflows"))
file.copy("U:/My Drive/Cornell College/Cornell Classes/Data Science/Tech Setup/check_rmd.yml", paste0(repo_name,"/.github/workflows"))

# PUSH

# Add the rmarkdown compile badge
action_add_badge(
  repo=paste0("DSC223-FB4-2021/",repo_name),
  workflow = 'Render R Markdown files',
  where = "^.",
  line_padding = "\n\n\n",
  file = "README.md"
)

# This will create an individual assignment
org_create_assignment(
  org = "DSC223-FB4-2021",
  user = roster$github,
  repo = paste0(paste0(repo_name,"-indi-"), roster$github),
  source_repo = paste0("DSC223-FB4-2021/",repo_name),
  private = TRUE
)



#Team assignment
org_create_assignment(
  org = "DSC223-FB4-2021",
  user = roster$github,
  repo = paste0(repo_name,"_team_",roster$labs),
  team = paste0(repo_name,"_team_",roster$labs),
  source_repo = paste0("DSC223-FB4-2021/",repo_name),
  private = TRUE
)

