# EXAM 2

## Rules

1. Your solutions must be written up in the R Markdown (Rmd) file called `exam-02.Rmd`. This file must include your code and write up for each task. Your "submission" will be whatever is in your exam repository at the deadline (3:00pm 12/15/2021) and has the commit message ?final submission?. Commit and push the Rmd and the md outputs of that file.

2. This exam is open book, open internet, closed other people. You may use any online or book-based resource you would like, but you must include citations for any code that you use (directly or indirectly). You **may not** consult with anyone else about this exam other than the Professor. You may not ask questions except for any issues not allowing you to retrieve, commit, or push your exam. You cannot ask direct questions on the internet, or consult with each other, not even for hypothetical questions.

3. You have until **3:00pm on Friday, December 15th** to complete this exam and turn it in via your personal Github repo - late work will **not** be accepted. Technical difficulties are **not** an excuse for late work - do not wait until the last minute to knit / commit / push.

4. Each question requires a (brief) narrative as well as a 
(brief) description of your approach. I should be able to suppress **all** the code in your document and still be able to read and make sense of your answers. See the first setup code chunk in your Rmd file to experiment with suppressing and revealing your code. 

5. Even if the answer seems obvious from the R output, make sure to state it in your narrative as well. For example, if the question is asking what is 2 + 2, and you have the following in your document, you should additionally have a sentence that states "2 + 2 is 4."

```r
2 + 2
# 4
```

## Academic Integrity Statement

*I, ____________, hereby state that I have not communicated with or gained information in any way from my classmates or anyone other than the Professor during this exam, and that all work is my own.*

**A note on sharing / reusing code:** I am well aware that a huge volume of code is available on the web to solve any number of problems. For this exam you are allowed to make use of any online resources (e.g. StackOverflow) but you must explicitly cite where you obtained any code you directly use (or use as inspiration). You are also not allowed to ask a question on an external forum, you can only use answers to questions that have already been answered.
Any recycled code that is discovered and is not explicitly cited will be treated as plagiarism. All communication with classmates is explicitly forbidden.

## Getting help

You are not allowed to post any questions on the public community repo or the public questions channel on Slack. Any questions about the exam must be asked in person or via email. You may only ask questions related to issues inhibiting (preventing) you from being able to work on your exam and submit it. For example, if R crashes, let me know. 

## Grading and feedback

The total points for the questions add up to 90 points. The remaining 10 points are allocated to code style, commit frequency and messages, overall organization, spelling, grammar, etc. There is also an extra credit question that is worth 5 points. You will receive feedback as an issue posted to your repository, and your grade will also be recorded on Moodle.

## Logistics

Answer the questions in the document called `exam-00.Rmd`. Add your code and narrative in the spaces below each question. Add code chunks as needed. Use as many lines as you need, but keep your narrative concise.

Before completing, make sure to suppress the code and look over your answers one more time. If the narrative seems sparse or choppy, edit as needed. Then, revert back to revealing your code.

## The original data

The source:

[Giant Pumpkins](https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-10-19/readme.md)


"The Great Pumpkin Commonwealth's (GPC) mission cultivates the hobby of growing giant pumpkins throughout the world by establishing standards and regulations that ensure quality of fruit, fairness of competition, recognition of achievement, fellowship and education for all participating growers and weigh-off sites."


## Questions 

1. **Question 1 (35 points)** - Your first task is to clean this data including:
a. Remove rows with damaged pumpkins (see *place*)
b. Create a new column called *exhibition* based on the column *place* with 1 for if it is "EXH" or 0 if not.
c. Convert the word "EXH" in the *place* column to NAs and make the place column numeric. 
d. Convert the *weight_lbs* variable to numeric. You will need to deal with commas. 

2. **Question 2 (20 points)** - The *id* column has both the year and the type of vegetable in its values. Break this column up into two columns *year* and *type*. Afterward, look at the bottom of the github page about the dataset to see what the letters in your type column mean - relabel the letters to have the full names.

3. **Question 3 (15 points)** - Create a *nice* visualization that shows variables you cleaned up including *exhibition*, *weight_lbs*, *year* and *type*. This should be one plot (but could have multiple facets). The plot must have a purpose. What does it tell you? Give a narrative. 

5. **Question 5 (20 points)** - Now I want you to build a linear model. Your goal is to build a model that could predict the place (like 1st or 2nd, not location) a pumpkin gets based on *weight_lbs* and your new variable *type*. Interpret the coefficient of *weight_lbs* and one of the coefficients of *type*. Since the "EXH" pumpkins have no placing, filter our those rows before fitting your model but don't overwrite your original data.  


**BONUS Question (5 points)** - You may need external sources. Make a new column named *gourd* with only two levels - "gourd" and "other" by reading about gourds [HERE](https://en.wikipedia.org/wiki/Gourd) and looking at your *type* column. Now, make a visualization of *place* vs *weight_lbs* where each point is little image of a pumpkin (gourd) or a little picture of a watermelon. 

See [HERE](shorturl.at/sAIKL) and [HERE](shorturl.at/ciEGN) for clipart links. Make sure to cite your sources of images too. 
