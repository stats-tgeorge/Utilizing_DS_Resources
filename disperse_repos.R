# This script is to disperse projects/labs/assignments to students

library(ghclass)
library(gitcreds)

gitcreds::gitcreds_set()
org_sitrep(org = "DSC223-FB4-2021")


setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/DSC223PrepRep")

roster = read.csv('roster.csv')

# Add students to organzation
#org_invite(org = 'DSC223-FB4-2021',user = roster$github)

# Add individual user
#org_invite(org = 'DSC223-FB4-2021', user = 'MMccoy22cornell')


# Check current org members
org_members('DSC223-FB4-2021')

# Check pending invites
org_pending('DSC223-FB4-2021')

# This next section is how to prep and disperse repos

# First you need to create a repo out of just the hw/lab you want to disperse
# Next make it a template
repo_set_template('DSC223-FB4-2021/HW-1-pet-names')

repo_is_template('DSC223-FB4-2021/HW-1-pet-names')

# This will create an individual assingment
org_create_assignment(
  org = "DSC223-FB4-2021",
  user = roster$github,
  repo = paste0("hw-1-ind-", roster$github),
  source_repo = 'DSC223-FB4-2021/HW-1-pet-names',
  private = TRUE
)

