# This script is to disperse projects/labs/assignments to students

library(ghclass)
org_sitrep(org = "DSC223-FB4-2021")


setwd("U:/My Drive/Cornell College/Cornell Classes/Data Science/DSC223PrepRep")
# Add students to organzation
roster = read.csv('roster.csv')

org_invite(org = 'DSC223-FB4-2021',user = roster$github)
