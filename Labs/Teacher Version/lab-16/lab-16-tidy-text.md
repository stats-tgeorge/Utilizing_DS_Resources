Lab 16 - tidytext
================
Tyler George  
Based on Materials from  
Julia Silge’s Workshop  
<https://juliasilge.github.io/tidytext-tutorial/site/>  
And Data Science in a Box by Mine Çetinkaya-Rundel  
<https://datasciencebox.org/>

Change the following to eval = T to get chunks to evaluate.

``` r
knitr::opts_chunk$set(eval = FALSE)
```

# Learning goals

-   Learn text mine (text analysis) terminology
-   Introduction to tidytext
-   Sentiment analysis
-   term frequency (tf) and inverse document frequency (idf)
    (wordlcouds)
-   Ngrams and network analysis

# Getting started

Go to the course GitHub organization and locate your lab repo, clone it
in RStudio and open the R Markdown document. Knit the document to make
sure it compiles without errors.

## Warm up

Let’s warm up with some simple exercises. Update the YAML of your R
Markdown file with your information, knit, commit, and push your
changes. Make sure to commit with a meaningful commit message. Then, go
to your repo on GitHub and confirm that your changes are visible in your
Rmd **and** md files. If anything is missing, commit and push again.

## Packages

In addition to `tidyverse` we will be using other packages today

## Tidytext

-   Using tidy data principles can make many text mining tasks easier,
    more effective, and consistent with tools already in wide use.
-   Learn more at <https://www.tidytextmining.com/>.

## Follow along

Fill in the blanks as we go along and run the R chunks

## What is tidy text?

**There Is a Light That Never Goes Out** by The Smiths

``` r
text <- c("Take me out tonight",
          "Where there's music and there's people",
          "And they're young and alive",
          "Driving in your car",
          "I never never want to go home",
          "Because I haven't got one",
          "Anymore")
text
```

``` r
text_df <- tibble(line = 1:7, text = text)

text_df
```

``` r
text_df %>%
  unnest_tokens(word, text)
```

#### What are you Listening to?

(Excluding those with derogatory words)

``` r
listening <- read_csv("data/listening.csv")
listening
```

#### Looking for commonalities

``` r
listening %>%
  unnest_tokens(word, songs) %>%
  count(word, sort = TRUE)
```

#### Stop words

-   In computing, stop words are words which are filtered out before or
    after processing of natural language data (text).
-   They usually refer to the most common words in a language, but there
    is not a single list of stop words used by all natural language
    processing tools.

#### English stop words

``` r
get_stopwords()
```

#### Spanish stop words

``` r
get_stopwords(language = "es")
```

#### Various lexicons

See `?get_stopwords` for more info.

``` r
get_stopwords(source = "smart")
```

#### Back to looking for commonalities

``` r
listening %>%
  unnest_tokens(word, songs) %>%
  anti_join(stop_words) %>%                           
  filter(!(word %in% c("1", "2", "3", "4", "5"))) %>% 
  count(word, sort = TRUE)
```

#### Top 20 common words in songs

``` r
top20_songs <- listening %>%
  unnest_tokens(word, songs) %>%
  anti_join(stop_words) %>%
  filter(
    !(word %in% c("1", "2", "3", "4", "5"))
    ) %>%
  count(word) %>%
  top_n(20)

top20_songs %>%
  arrange(desc(n))
```

#### Visualizing commonalities: bar chart

``` r
top20_songs %>%
  ggplot(aes(x = fct_reorder(word, n), y = n)) +
  geom_col() +
  labs(x = "Common words", y = "Count") +
  coord_flip()
```

#### Visualizing commonalities: wordcloud

``` r
set.seed(1234)
wordcloud(words = top20_songs$word, 
          freq = top20_songs$n, 
          colors = brewer.pal(5,"Blues"),
          random.order = FALSE)
#Note: You may need to increase the size of your plot area to get this to display properly
```

``` r
top_artist <- "_____"              #<
str_subset(listening$songs, top_artist)
```

#### Using the genius package (or whats left of it)

``` r
artist_albums <- tribble(
  ~artist,      ~album,
  "_______", "____________")             #<

artist <- artist_albums %>%
  add_genius(artist, album, "album")

# attach the lyrics (the genius functions no longer supported)
artist_lyrics <- read_csv('data/artistlyrics.csv')
artist <- artist %>%
  mutate(track_title = str_squish(track_title))%>%
  left_join(artist_lyrics,by="track_title") %>%
  mutate(lyric = str_replace_all(lyric,"\\\n|\\[.*\\]"," "),
         lyric = str_squish(lyric))

# Print it with unique lines
artist %>%
  distinct(album, track_title) 
```

#### Tidy up your lyrics!

``` r
artist_lyrics <- artist %>%
  unnest_tokens(word, _____)             #<

artist_lyrics
```

#### What are the most common words?

``` r
artist_lyrics %>%
  count(word, sort = TRUE)
```

#### Remove Stop Words

``` r
artist_lyrics %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE)
```

#### Bar Chart of Common Words

``` r
artist_lyrics %>%
  anti_join(stop_words) %>%
  count(word)%>%
  top_n(20) %>%
  ggplot(aes(fct_reorder(word, n), n)) +
    geom_col() +
    labs(title = "Frequency of Artists lyrics",
         y = "",
         x = "") +
    coord_flip()
```

## Sentiment Analysis

-   One way to analyze the sentiment of a text is to consider the text
    as a combination of its individual words
-   and the sentiment content of the whole text as the sum of the
    sentiment content of the individual words

``` r
get_sentiments("afinn")
```

#### Sentiments in Artists lyrics

``` r
artist_lyrics %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment, word, sort = TRUE)
```

**Goal:** Find the top 10 most common words with positive and negative
sentiments. Fill in and modify below to get this.

-   Step 1: Top 10 words for each sentiment

-   Step 2: `ungroup()`

-   Step 3: Save the result

``` r
artist_lyrics %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment, word) %>%
  group_by(sentiment) %>%
  ________ %>%                #<
  ________                    #<
```

## Now We want to plot our results:

#### Step 1: Create a bar chart

``` r
________ %>%      #< Based on what you named yours above
  ggplot(aes(x = word, y = n, fill = sentiment)) +
  geom_col()
```

#### Step 2: Order bars by frequency

``` r
artist_top10 %>%
  ggplot(aes(x = fct_reorder(word, n), y = n, fill = sentiment)) +
  geom_col()
```

#### Step 3: Facet by sentiment

``` r
artist_top10 %>%
  ggplot(aes(x = fct_reorder(word, n), y = n, fill = sentiment)) +
  geom_col() +
  _____wrap(~ sentiment)        #<
```

#### Step 4: Free the scales!

``` r
artist_top10 %>%
  ggplot(aes(x = fct_reorder(word, n), y = n, fill = sentiment)) +
  geom_col() +
  facet_wrap(~ sentiment, scales = "free")
```

#### Step 4: Flip the coordinates

``` r
artist_top10 %>%
  ggplot(aes(x = fct_reorder(word, n), y = n, fill = sentiment)) +
  geom_col() +
  facet_wrap(~ sentiment, scales = "free") +
  coord_flip()
```

#### Step 5: Clean up labels

``` r
artist_top10 %>%
  ggplot(aes(x = fct_reorder(word, n), y = n, fill = sentiment)) +
  geom_col() +
  facet_wrap(~ sentiment, scales = "free") +
  coord_flip() +
  labs(title = "Sentiments in Artists lyrics", x = "", y = "")
```

#### Step 6: Remove redundant info

``` r
artist_top10 %>%
  ggplot(aes(x = fct_reorder(word, n), y = n, fill = sentiment)) +
  geom_col() +
  facet_wrap(~ sentiment, scales = "free") +
  coord_flip() +
  labs(title = "Sentiments in Artists lyrics", x = "", y = "") +
  guides(fill = "none") 
```

## Scoring sentiments

#### Assign a sentiment score

``` r
artist_lyrics %>%
  anti_join(stop_words) %>%
  left_join(get_sentiments("afinn")) 
```

#### Sum Sentiment for each Album

``` r
artist_lyrics %>%
  anti_join(stop_words) %>%
  left_join(get_sentiments("afinn")) %>%
  dplyr::filter(!is.na(value)) %>%
  ______(album) %>%                          #<
  summarise(total_sentiment = sum(value)) %>%
  arrange(total_sentiment)
```

## Access the full text of one book

What book does *your table* want to analyze today?

Replace `18247` below with your own choice:
<https://www.gutenberg.org/browse/scores/top>

``` r
full_text <- gutenberg_download(18247)
```

Now it’s time to tokenize and tidy this text data.

``` r
tidy_book <- full_text %>%
  mutate(line = row_number()) %>%
  _____                             #<

tidy_book
```

What do you predict will happen if we run the following code?

**PREDICT WITH YOUR TABLE BEFORE YOU RUN**

Answer:

``` r
tidy_book %>%
  count(___,sort = T)             #<
```

#### Stop words

``` r
get_stopwords()
```

Try out some

-   different languages (`language`)
-   different sources (`source`)

#### What are the most common words?

**U N S C R A M B L E**

``` r
anti_join(get_stopwords(source = "smart")) %>%

tidy_book %>%

count(word, sort = TRUE) %>%

geom_col()

slice_max(n, n = 20) %>%

ggplot(aes(n, fct_reorder(word, n))) +  
```

#### Sentiment lexicons

Explore some sentiment lexicons.

``` r
get_sentiments("bing")
```

#### Implement sentiment analysis with an `inner_join()`

``` r
tidy_book %>%
  ___(get_sentiments("bing")) %>%         #< 
  count(sentiment, sort = TRUE)
```

#### What do you predict will happen if we run the following code?

**PREDICT WITH YOUR TABLE BEFORE YOU RUN**

Answer:

``` r
tidy_book %>%
  inner_join(get_sentiments("bing")) %>%            
  ___                                      #<
```

#### What words contribute the most to sentiment scores for **your** book?

``` r
tidy_book %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment, word, sort = TRUE) %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>%
  ungroup %>%
  ggplot(aes(n,
             fct_reorder(word,_____),              #<
             fill = sentiment)) +
  geom_col() +
  facet_wrap(~ sentiment, scales = "free") 
```

#### More packages!

``` r
library(widyr)
library(tidygraph)
library(ggraph)
```

#### Term frequency and inverse document frequency

According to [Wikipedia](https://en.wikipedia.org/wiki/Tf%E2%80%93idf)

“In information retrieval, tf–idf, TF\*IDF, or TFIDF, short for term
frequency–inverse document frequency, is a numerical statistic that is
intended to reflect how important a word is to a document in a
collection or corpus.”

Go back to Project Gutenberg and make a collection (*corpus*) for
yourself!

Default numbers are for The Last Man and Frankenstein by Mary Shelley

``` r
full_collection <- gutenberg_download(
                      c(18247,42324),
                      meta_fields = "title",
                      mirror = my_mirror)
full_collection
```

#### Count word frequencies in your collection.

``` r
book_words <- full_collection %>%
  ___(word,text) %>%                       #< 
  count(title, word, sort = TRUE)
```

``` r
book_words
```

#### Calculate tf-idf.

``` r
book_tfidf <- book_words %>%
  bind_tf_idf(_____,____,___)            #<

book_tfidf
```

#### What do you predict will happen if we run the following code?

**PREDICT WITH YOUR TABLE BEFORE YOU RUN**

Answer:

``` r
book_tfidf %>%
  arrange(-tf_idf)
```

**U N S C R A M B L E**

``` r
group_by(title) %>%

book_tfidf %>%

slice_max(tf_idf, n = 10) %>%

ggplot(aes(tf_idf, fct_reorder(word, tf_idf), fill = title)) +

facet_wrap(~title, scales = "free")

geom_col(show.legend = FALSE) +
```

## N-grams… and BEYOND

``` r
tidy_ngram <- full_text %>%
  unnest_tokens(___,text,token="____",n=___)%>%   #<
  dplyr::filter(!is.na(bigram))

tidy_ngram
```

#### What are the most common bigrams?

``` r
tidy_ngram %>%
  ____(bigram,sort = T)       #<
```

#### Let’s use `separate()` from tidyr to remove stop words.

``` r
bigram_counts <- tidy_ngram %>%
  separate(bigram,c("word1","word2"),sep=" ") %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word) %>%
  count(word1, word2, sort = TRUE)

bigram_counts
```

## Network analysis

#### Create a word network from bigrams!

``` r
bigram_graph <- bigram_counts %>%
  filter(n > 5) %>%
  ___                               #<

bigram_graph
```

#### Visualize the network.

``` r
bigram_graph %>%
  ggraph(layout = "kk") +
  geom_edge_link(aes(______)) +  #< 
  geom_node_text(aes(______)) +  #< 
  theme_graph() 
```

#### Lots of ways to make the graph nicer!

``` r
bigram_graph %>%
  ggraph(layout = "kk") +
  geom_edge_link(___,                    #<
                 show.legend = FALSE, 
                 arrow = arrow(length = unit(1.5, 'mm')), 
                 start_cap = circle(3, 'mm'),
                 end_cap = circle(3, 'mm')) + 
  geom_node_text(___) +                  #< 
  theme_graph() 
```

🧶 ✅ ⬆️ *If you haven’t done so recently, knit, commit, and push your
changes to GitHub with an appropriate commit message. Make sure to
commit and push all changed files so that your Git pane is cleared up
afterwards.*
