---
title: "R programming (r4ds Section III)"
author: "Mitch"
date: "1-30-18"
output: 
  html_document: 
    keep_md: yes
---

<span style="color:blue">some *blue* text</span>

# Ch 18: Pipes

_Demonstrate the use of the regular pipe (`%>%`) and the "explosion" operator (`%$%`) in some example_


```r
library(magrittr)
nums = c(1,2,3,4,5,6,7,8,9) %>% matrix(ncol = 3) %>% data.frame()

wtb = nums %$% table(X1,X2,X3)
```


----

# Ch 19: Functions

### 19.2: When should you write a function?
Answer any 3

```r
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(c(0, 5, 10))
```

```
## [1] 0.0 0.5 1.0
```

```r
rescale01(c(1, 2, 3, NA, 5))
```

```
## [1] 0.00 0.25 0.50   NA 1.00
```
1. If na.rm = FALSE, then all the max's and mins become na. 

3. 

```r
meanfun = function(x){
  c(mean(is.na(x)))
}

anotherfun = function(x){
  c(x / sum(x, na.rm = TRUE))
}

sdmean = function(x){
  c(sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE))
}
```

6. 

```r
setwd("C:/Users/mitch2/Documents/School/499/assignments-mborgert")
is_directory <- function(x) file.info(x)$isdir
```
This tells you whether a file is a directory.


```r
is_readable <- function(x) file.access(x, 4) == 0
?file.access
```

```
## starting httpd help server ... done
```
This is a function to test if a file is readable.

_Describe one time where you wish you had written a function, but didn't._
For a project in Math 458. It took way too much copying and pasting. 


### 19.3: Functions are for humans and computers

1.

```r
contains_prefix <- function(string, prefix) {
  substr(string, 1, nchar(prefix)) == prefix
}

contains_prefix("prefix","pre")
```

```
## [1] TRUE
```
This says if a prefix is in a word. 


```r
final_number_remover <- function(x) {
  if (length(x) <= 1) return(NULL)
  x[-length(x)]
}

final_number_remover(c(1,2,3,4))
```

```
## [1] 1 2 3
```
This removes the final number in a vector, if there is 1 number or less it returns null.


```r
f3 <- function(x, y) {
  rep(y, length.out = length(x))
}

f3(555,"dootfsdfs")
```

```
## [1] "dootfsdfs"
```

```r
?rep
```




_What does "Functions are for humans and computers" mean to you?_
<span style="color:red">answer missing</span>

### 19.4 Conditional execution
Answer any 3
1. 

```r
?ifelse
x = c(6:-4)
sqrt(x)
```

```
## Warning in sqrt(x): NaNs produced
```

```
##  [1] 2.449490 2.236068 2.000000 1.732051 1.414214 1.000000 0.000000
##  [8]      NaN      NaN      NaN      NaN
```

```r
sqrt(ifelse(x >= 0, x, NA))
```

```
##  [1] 2.449490 2.236068 2.000000 1.732051 1.414214 1.000000 0.000000
##  [8]       NA       NA       NA       NA
```

```r
x = 11
if(x == 11){
  x = x + 1
}
```

ifelse does the else in the function. 

3. 

```r
fizzbuzz.fun = function(x){
if(x %% 3 == 0 && x %% 5 == 0) {
  c("fizzbuzz")
}
else if(x %% 3 == 0){
  c("fizz")
}
else if(x %% 5 == 0){
  c("buzz")
}
}

fizzbuzz.fun(45)
```

```
## [1] "fizzbuzz"
```

6. 

```r
x = "e"
switch(x, 
  a = ,
  b = "ab",
  c = ,
  d = "cd"
)
```
Nothing happens if x = "e". Switch switches stuff. 

```r
switch(1,"red","green","blue")
```

```
## [1] "red"
```

```r
switch(2,"red","green","blue")
```

```
## [1] "green"
```

```r
centre <- function(x, type) {
 switch(type,
        mean = mean(x),
      median = median(x),
         trimmed = mean(x, trim = .1))
}
x = rnorm(10)
centre(x,"mean")
```

```
## [1] 0.06786185
```

### 19.5 Function arguments

2. Trim chops off an amount of decimals. You use it when you want less decimals. 

4.

```r
?cor
```
Pearson is default. The three are different types of computing the correlation. 

### 19.6: Return values
_Is it mandatory that you `return()` a value from a function? If not, give on reasons for why you would want to do so. If so, explain what happens if you don't include the return._

It's not necessary to return someone, the function still runs. 

### 19.7: Environment
_What's the problem with the example function at the beginning of this chapter?_

Y wasn't initialized. 

----

# 20: Vectors

###  20.3: Important types of atomic vector


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
near
```

```
## function (x, y, tol = .Machine$double.eps^0.5) 
## {
##     abs(x - y) < tol
## }
## <environment: namespace:dplyr>
```
if x-y is less than some total, they are near. 

5. the parse atomic functions let you turn a string into others. 

### 20.4: Using Atomic Vectors

4. 

```r
last.fun = function(x){
  last = length(x)
  c(x[[last]])
}

even.fun = function(x){
  leng = length(x)
  vec = list()
  for(i in leng){
    if(i %% 2 == 0){
      vec[[i]] = x
    }
  }
}

notlast.fun = function(x){
  leng = length(x)
  c(x[-leng])
}

even.fun = function(x){
  y = 2*x 
  c(y)
}
```


### 20.5: Recursive vectors (lists)
I drew the lists. 

### 20.7: Augmented vectors

_Describe at least two differences between a `data.frame` and a `tibble`_

All elements must be vectors. All elements must be the same length. 

----

# Chapter 21: Iteration

### 21.2: For Loops

```r
out <- ""
for (x in letters) {
  out <- stringr::str_c(out, x)
}
letters
```

```
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"
## [18] "r" "s" "t" "u" "v" "w" "x" "y" "z"
```

```r
library(stringr)

paste(letters, collapse="")
```

```
## [1] "abcdefghijklmnopqrstuvwxyz"
```

```r
x <- sample(100)
sd <- 0
for (i in seq_along(x)) {
  sd <- sd + (x[i] - mean(x)) ^ 2
}
sd <- sqrt(sd / (length(x) - 1))


sd(x)
```

```
## [1] 29.01149
```

```r
x <- runif(100)
out <- vector("numeric", length(x))
out[1] <- x[1]
for (i in 2:length(x)) {
  out[i] <- out[i - 1] + x[i]
}


out[100]
```

```
## [1] 51.07759
```

```r
sum(x)
```

```
## [1] 51.07759
```

```r
?sum
```


### 21.3: For Loop Variations
create a list with each dataframe as an entry then data.frame( each entry in the list )

<span style="color:red">answer missing</span>

### 21.4: For loops vs functionals

```r
col_summary <- function(df, fun) {
  out <- vector("double", length(df))
  for (i in seq_along(df)) {
    if(is.numeric(df[[i]]) == TRUE){
    out[i] <- fun(df[[i]])
    }
    else{
      out[i] <- NA
    }
  }
  out
}
```


### 21.5: the map function
2. make a list that has as many columns as a dataframe. for loop through the columns and fill the list the is.factor results. Or use the map function and is.factor. 


```r
library(purrr)
```

```
## 
## Attaching package: 'purrr'
```

```
## The following object is masked from 'package:magrittr':
## 
##     set_names
```

```r
map(-2:2, rnorm, n = 5)
```

```
## [[1]]
## [1] -1.4464461 -0.9832833 -2.3655465 -1.9183185 -1.9748368
## 
## [[2]]
## [1] -0.8194392 -1.6222657 -1.5196654 -0.1510268 -1.3323436
## 
## [[3]]
## [1] -1.9497651  0.3714242  0.6844355 -0.2529109 -1.0534907
## 
## [[4]]
## [1]  1.5992077  1.3182469  2.3888906  0.8062082 -0.2821944
## 
## [[5]]
## [1] 1.953882 1.286264 1.453376 3.034736 3.796654
```

```r
map_dbl(-2:2, rnorm, n = 5)
```

```
## Error: Result 1 is not a length 1 atomic vector
```

```r
?map_dbl
```
The first creates 5x5 rnorm numbers. The second does not work because of something to do with doubles. 

<span style="color:red">answer missing</span>

----

End here. The rest of 21 is for your info only

