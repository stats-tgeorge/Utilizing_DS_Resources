# EXAM 1

## Rules

1. Your solutions must be written up in the R Markdown (Rmd) file called `exam-01.Rmd`. This file must include your code and write up for each task. Your "submission" will be whatever is in your exam repository at the deadline (11:59pm 12/3/2021) and has the commit message ?final submission?. Commit and push the Rmd and the md outputs of that file.

2. This exam is open book, open internet, closed other people. You may use any online or book-based resource you would like, but you must include citations for any code that you use (directly or indirectly). You **may not** consult with anyone else about this exam other than the Professor. You may not ask questions except for any issues not allowing you to retrieve, commit, or push your exam. You cannot ask direct questions on the internet, or consult with each other, not even for hypothetical questions.

3. You have until **11:59pm on Friday, December 3rd** to complete this exam and turn it in via your personal Github repo - late work will **not** be accepted. Technical difficulties are **not** an excuse for late work - do not wait until the last minute to knit / commit / push.

4. Each question requires a (brief) narrative as well as a 
(brief) description of your approach. I should be able to suppress **all** the code in your document and still be able to read and make sense of your answers. See the first setup code chunk in your Rmd file to experiment with suppressing and revealing your code. 

5. Even if the answer seems obvious from the R output, make sure to state it in your narrative as well. For example, if the question is asking what is 2 + 2, and you have the following in your document, you should additionally have a sentence that states "2 + 2 is 4."

```r
2 + 2
# 4
```

6. You may only use `tidyverse` and `nycflights13` (and its dependencies) for this assignment. Your solutions may not use any other R packages.

## Academic Integrity Statement

*I, ____________, hereby state that I have not communicated with or gained information in any way from my classmates or anyone other than the Professor or TA during this exam, and that all work is my own.*

**A note on sharing / reusing code:** I am well aware that a huge volume of code is available on the web to solve any number of problems. For this exam you are allowed to make use of any online resources (e.g. StackOverflow) but you must explicitly cite where you obtained any code you directly use (or use as inspiration). You are also not allowed to ask a question on an external forum, you can only use answers to questions that have already been answered.
Any recycled code that is discovered and is not explicitly cited will be treated as plagiarism. All communication with classmates is explicitly forbidden.

## Getting help

You are not allowed to post any questions on the public community repo or the public questions channel on Slack. Any questions about the exam must be asked in person or via email. You may only ask questions related to issues inhibiting (preventing) you from being able to work on your exam and submit it. For example, if R crashes, let me know. 

## Grading and feedback

The total points for the questions add up to 90 points. The remaining 10 points are allocated to code style, commit frequency and messages, overall organization, spelling, grammar, etc. There is also an extra credit question that is worth 5 points. You will receive feedback as an issue posted to your repository, and your grade will also be recorded on Sakai.

## Logistics

Answer the questions in the document called `exam-01.Rmd`. Add your code and narrative in the spaces below each question. Add code chunks as needed. Use as many lines as you need, but keep your narrative concise.

Before completing, make sure to supress the code and look over your answers one more time. If the narrative seems sparse or choppy, edit as needed. Then, revert back to revealing your code.

## Packages

In addition to `tidyverse ` and others we have used in class.

## The original data

[Superbowl](https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-02/readme.md)

``The data comes from FiveThirtyEight. They have a corresponding article on the topic. Note that the original source was superbowl-ads.com. You can watch all the ads via the FiveThirtyEight article above.
Like millions of viewers who tune into the big game year after year, we at FiveThirtyEight LOVE Super Bowl commercials. We love them so much, in fact, that we wanted to know everything about them ? by analyzing and categorizing them, of course. We dug into the defining characteristics of a Super Bowl ad, then grouped commercials based on which criteria they shared ? and let me tell you, we found some really weird clusters of commercials.
We watched 233 ads from the 10 brands that aired the most spots in all 21 Super Bowls this century, according to superbowl-ads.com.1 While we watched, we evaluated ads using seven specific criteria, marking every spot as a "yes" or "no" for each.?

## Questions 

### Open ended
1. **Question 1 (15 points)** - Choose 3 meaningful categorial variables and 3 quantitative variables you find interesting. Investigate each of them individually with tables and graphs. Make sure to describe what you see (and interesting things you notice).

2. **Question 2 (15 points)** - Now compare your variables from number 1 to each other. Compare at least: 2 quantitative, 2 categorical, and 1 categorical to a quantitative - using tables and/or graphs. Give a narrative for every table or plot made. This is a minimal of three comparisons.

3. **Question 3 (15 points)** - Now I want you to make a **good** (easy to read, nice colors, well-polished) visualization that utilizes two of the categorical variables and two of the quantitative. You are welcome to use faceting as needed. The plot must have a purpose ? what does it tell you? Give a narrative about it. 

4. **Question 4 (10 points)** - Pick one of your categorical variables and changes its column values to something with text (rather than TRUE FALSE). Make a visualization with this newly formatted column (with any other columns you have worked with) and give a narrative about what you see. 

### More direct
5. **Question 5 (7 points)** - What types of videos have the highest proportion of liked over views ratios? Compare liked/views ratios between variables funny, show _product_quickly, patriotic, celebrity, danger, animals, and use_sex.

6. **Question 6 (7 points)** - Answer the previous question with a disliked over view ratio. Do the same videos that are least often liked when viewed correspond to those that are most often disliked? Discuss. 

7. **Question 7 (7 points)** - What is the frequency of each pair-wise (2 at a time) combination of video content (for example, how often are videos both funny and patriotic).

8. **Question 8 (7 points)** - Investigate how the type number of add in each of the categories in number 3 changed throughout time. Make a nice graph to visualize this and discuss. 

9. **Question 9 (7 points)** - If a company wants to make an add that gets a lot of youtube likes, what components should it have? 

**BONUS Question (5 points)** - You may need external sources. What proportion of videos likely has vehicles in it? 
