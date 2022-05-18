# This script is to disperse projects/labs/assignments to students

library(ghclass)
library(gitcreds)

#gitcreds::gitcreds_set()
org_sitrep(org = "github organization")


setwd("directory of repo clone and share")

roster = read.csv('roster.csv')

# Add students to organzation
#org_invite(org = 'github organization',user = roster$github)

# Add individual user
#org_invite(org = 'github organization', user = 'Twu23')


# Check current org members
org_members('github organization')

# Check pending invites
org_pending('github organization')

# This next section is how to prep and disperse repos

# First you need to create a repo out of just the hw/lab you want to disperse
# Next make it a template

repo_name = "exam-02"

repo_set_template(paste0("github organization/",repo_name))

repo_is_template(paste0("github organization/",repo_name))

# add the yml file for badge
setwd("directory you have yml file")

dir.create(paste0(repo_name,"/.github"))
dir.create(paste0(repo_name,"/.github/workflows"))
file.copy("yml file", paste0(repo_name,"/.github/workflows"))

# PUSH

# Add the rmarkdown compile badge
action_add_badge(
  repo=paste0("github organization/",repo_name),
  workflow = 'Render R Markdown files',
  where = "^.",
  line_padding = "\n\n\n",
  file = "README.md"
)

# This will create an individual assignment
org_create_assignment(
  org = "github organization",
  user = roster$github,
  repo = paste0(paste0(repo_name,"-indi-"), roster$github),
  source_repo = paste0("github organization/",repo_name),
  private = TRUE
)



#Team assignment
org_create_assignment(
  org = "github organization",
  user = roster$github,
  repo = paste0(repo_name,"_team_",roster$labs),
  team = paste0(repo_name,"_team_",roster$labs),
  source_repo = paste0("github organization/",repo_name),
  private = TRUE
)

