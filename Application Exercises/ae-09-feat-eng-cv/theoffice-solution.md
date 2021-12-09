The Office
================
Mine Çetinkaya-Rundel
Modified by Tyler George

``` r
library(tidyverse)
library(tidymodels)
library(schrute)
library(lubridate)
```

Use `theoffice` data from the [**schrute**](https://bradlindblad.github.io/schrute/) package to predict IMDB scores for episodes of The Office.

``` r
glimpse(theoffice)
```

    ## Rows: 55,130
    ## Columns: 12
    ## $ index            <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16~
    ## $ season           <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,~
    ## $ episode          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,~
    ## $ episode_name     <chr> "Pilot", "Pilot", "Pilot", "Pilot", "Pilot", "Pilot",~
    ## $ director         <chr> "Ken Kwapis", "Ken Kwapis", "Ken Kwapis", "Ken Kwapis~
    ## $ writer           <chr> "Ricky Gervais;Stephen Merchant;Greg Daniels", "Ricky~
    ## $ character        <chr> "Michael", "Jim", "Michael", "Jim", "Michael", "Micha~
    ## $ text             <chr> "All right Jim. Your quarterlies look very good. How ~
    ## $ text_w_direction <chr> "All right Jim. Your quarterlies look very good. How ~
    ## $ imdb_rating      <dbl> 7.6, 7.6, 7.6, 7.6, 7.6, 7.6, 7.6, 7.6, 7.6, 7.6, 7.6~
    ## $ total_votes      <int> 3706, 3706, 3706, 3706, 3706, 3706, 3706, 3706, 3706,~
    ## $ air_date         <fct> 2005-03-24, 2005-03-24, 2005-03-24, 2005-03-24, 2005-~

Fix `air_date` for later use.

``` r
theoffice <- theoffice %>%
  mutate(air_date = ymd(as.character(air_date)))
```

We will

-   engineer features based on episode scripts
-   train a model
-   perform cross validation
-   make predictions

Note: The episodes listed in `theoffice` don't match the ones listed in the data we used in the [cross validation lesson](https://ids-s1-20.github.io/slides/week-10/w10-d02-cross-validation/w10-d02-cross-validation.html).

``` r
theoffice %>%
  distinct(season, episode)
```

    ## # A tibble: 186 x 2
    ##    season episode
    ##     <int>   <int>
    ##  1      1       1
    ##  2      1       2
    ##  3      1       3
    ##  4      1       4
    ##  5      1       5
    ##  6      1       6
    ##  7      2       1
    ##  8      2       2
    ##  9      2       3
    ## 10      2       4
    ## # ... with 176 more rows

### Exercise 1 - Calculate the percentage of lines spoken by Jim, Pam, Michael, and Dwight for each episode of The Office.

``` r
office_lines <- theoffice %>%
  group_by(season, episode) %>%
  mutate(
    n_lines = n(),
    lines_jim = sum(character == "Jim") / n_lines,
    lines_pam = sum(character == "Pam") / n_lines,
    lines_michael = sum(character == "Michael") / n_lines,
    lines_dwight = sum(character == "Dwight") / n_lines,
  ) %>%
  ungroup() %>%
  select(season, episode, episode_name, contains("lines_")) %>%
  distinct(season, episode, episode_name, .keep_all = TRUE)
```

### Exercise 2 - Identify episodes that touch on Halloween, Valentine's Day, and Christmas.

``` r
theoffice <- theoffice %>%
  mutate(text = tolower(text))

halloween_episodes <- theoffice %>%
  filter(str_detect(text, "halloween")) %>% 
  count(episode_name) %>%
  filter(n > 1) %>%
  mutate(halloween = 1) %>%
  select(-n)

valentine_episodes <- theoffice %>%
  filter(str_detect(text, "valentine")) %>% 
  count(episode_name) %>%
  filter(n > 1) %>%
  mutate(valentine = 1) %>%
  select(-n)

christmas_episodes <- theoffice %>%
  filter(str_detect(text, "christmas")) %>% 
  count(episode_name) %>%
  filter(n > 1) %>%
  mutate(christmas = 1) %>%
  select(-n)
```

### Exercise 3 - Put together a modeling dataset that includes features you've engineered. Also add an indicator variable called `michael` which takes the value `1` if Michael Scott (Steve Carrell) was there, and `0` if not. Note: Michael Scott (Steve Carrell) left the show at the end of Season 7.

``` r
office_df <- theoffice %>%
  select(season, episode, episode_name, imdb_rating, total_votes, air_date) %>%
  distinct(season, episode, .keep_all = TRUE) %>%
  left_join(halloween_episodes, by = "episode_name") %>% 
  left_join(valentine_episodes, by = "episode_name") %>% 
  left_join(christmas_episodes, by = "episode_name") %>% 
  replace_na(list(halloween = 0, valentine = 0, christmas = 0)) %>%
  mutate(michael = if_else(season > 7, 0, 1)) %>%
  mutate(across(halloween:michael, as.factor)) %>%
  left_join(office_lines, by = c("season", "episode", "episode_name"))
```

### Exercise 4 - Split the data into training (75%) and testing (25%).

``` r
set.seed(1122)
office_split <- initial_split(office_df)
office_train <- training(office_split)
office_test <- testing(office_split)
```

### Exercise 5 - Specify a linear regression model.

``` r
office_mod <- linear_reg() %>%
  set_engine("lm")
```

### Exercise 6 - Create a recipe that updates the role of `episode_name` to not be a predictor, removes `air_date` as a predictor, and removes all zero variance predictors.

``` r
office_rec <- recipe(imdb_rating ~ ., data = office_train) %>%
  update_role(episode_name, new_role = "id") %>%
  step_rm(air_date) %>%
  step_dummy(all_nominal(), -episode_name) %>%
  step_zv(all_predictors())
```

### Exercise 7 - Build a workflow for fitting the model specified earlier and using the recipe you developed to preprocess the data.

``` r
office_wflow <- workflow() %>%
  add_model(office_mod) %>%
  add_recipe(office_rec)
```

### Exercise 8 - Fit the model to training data and interpret a couple of the slope coefficients.

``` r
office_fit <- office_wflow %>%
  fit(data = office_train)

tidy(office_fit)
```

    ## # A tibble: 12 x 5
    ##    term           estimate std.error statistic  p.value
    ##    <chr>             <dbl>     <dbl>     <dbl>    <dbl>
    ##  1 (Intercept)    6.34     0.298       21.2    1.24e-43
    ##  2 season         0.0542   0.0224       2.42   1.68e- 2
    ##  3 episode        0.0125   0.00439      2.85   5.05e- 3
    ##  4 total_votes    0.000372 0.0000390    9.55   1.25e-16
    ##  5 lines_jim      0.653    0.679        0.962  3.38e- 1
    ##  6 lines_pam      0.0329   0.696        0.0473 9.62e- 1
    ##  7 lines_michael  0.111    0.544        0.204  8.39e- 1
    ##  8 lines_dwight   0.806    0.522        1.54   1.25e- 1
    ##  9 halloween_X1  -0.00340  0.181       -0.0188 9.85e- 1
    ## 10 valentine_X1  -0.0573   0.180       -0.318  7.51e- 1
    ## 11 christmas_X1   0.285    0.129        2.22   2.82e- 2
    ## 12 michael_X1     0.585    0.141        4.15   6.01e- 5

### Exercise 9 - Perform 5-fold cross validation and view model performance metrics.

``` r
set.seed(345)
folds <- vfold_cv(office_train, v = 5)
folds
```

    ## #  5-fold cross-validation 
    ## # A tibble: 5 x 2
    ##   splits           id   
    ##   <list>           <chr>
    ## 1 <split [111/28]> Fold1
    ## 2 <split [111/28]> Fold2
    ## 3 <split [111/28]> Fold3
    ## 4 <split [111/28]> Fold4
    ## 5 <split [112/27]> Fold5

``` r
set.seed(456)
office_fit_rs <- office_wflow %>%
  fit_resamples(folds)

collect_metrics(office_fit_rs)
```

    ## # A tibble: 2 x 6
    ##   .metric .estimator  mean     n std_err .config             
    ##   <chr>   <chr>      <dbl> <int>   <dbl> <chr>               
    ## 1 rmse    standard   0.367     5  0.0512 Preprocessor1_Model1
    ## 2 rsq     standard   0.543     5  0.0386 Preprocessor1_Model1

### Exercise 10 - Use your model to make predictions for the testing data and calculate the RMSE. Also use the model developed in the [cross validation lesson](https://ids-s1-20.github.io/slides/week-10/w10-d02-cross-validation/w10-d02-cross-validation.html) to make predictions for the testing data and calculate the RMSE as well. Which model did a better job in predicting IMDB scores for the testing data?

#### New model

``` r
office_test_pred <- predict(office_fit, new_data = office_test) %>%
  bind_cols(office_test %>% select(imdb_rating, episode_name))

rmse(office_test_pred, truth = imdb_rating, estimate = .pred)
```

    ## # A tibble: 1 x 3
    ##   .metric .estimator .estimate
    ##   <chr>   <chr>          <dbl>
    ## 1 rmse    standard       0.401

#### Old model

``` r
office_mod_old <- linear_reg() %>%
  set_engine("lm")

office_rec_old <- recipe(imdb_rating ~ season + episode + total_votes + air_date, data = office_train) %>%
  # extract month of air_date
  step_date(air_date, features = "month") %>%
  step_rm(air_date) %>%
  # make dummy variables of month 
  step_dummy(contains("month")) %>%
  # remove zero variance predictors
  step_zv(all_predictors())

office_wflow_old <- workflow() %>%
  add_model(office_mod_old) %>%
  add_recipe(office_rec_old)

office_fit_old <- office_wflow_old %>%
  fit(data = office_train)

tidy(office_fit_old)
```

    ## # A tibble: 12 x 5
    ##    term                estimate std.error statistic  p.value
    ##    <chr>                  <dbl>     <dbl>     <dbl>    <dbl>
    ##  1 (Intercept)         7.20     0.188        38.4   9.92e-72
    ##  2 season             -0.0501   0.0140       -3.57  5.04e- 4
    ##  3 episode             0.0449   0.00877       5.11  1.13e- 6
    ##  4 total_votes         0.000360 0.0000404     8.89  4.99e-15
    ##  5 air_date_month_Feb -0.145    0.139        -1.04  2.99e- 1
    ##  6 air_date_month_Mar -0.376    0.134        -2.81  5.69e- 3
    ##  7 air_date_month_Apr -0.309    0.131        -2.36  1.96e- 2
    ##  8 air_date_month_May -0.128    0.162        -0.791 4.30e- 1
    ##  9 air_date_month_Sep  0.512    0.178         2.88  4.63e- 3
    ## 10 air_date_month_Oct  0.270    0.139         1.95  5.38e- 2
    ## 11 air_date_month_Nov  0.116    0.126         0.924 3.57e- 1
    ## 12 air_date_month_Dec  0.407    0.165         2.47  1.49e- 2

``` r
office_test_pred_old <- predict(office_fit_old, new_data = office_test) %>%
  bind_cols(office_test %>% select(imdb_rating, episode_name))

rmse(office_test_pred_old, truth = imdb_rating, estimate = .pred)
```

    ## # A tibble: 1 x 3
    ##   .metric .estimator .estimate
    ##   <chr>   <chr>          <dbl>
    ## 1 rmse    standard       0.403
