# islr ch4
Mitch Borgert  



#q5 
##a. If the Bayes decision boundary is linear, do we expect LDA or QDA to perform better on the training set? On the test set?

we expect QDA to perform better on the training set because of its higher flexiblity. We expect LDA to perform better on the test set than QDA, because QDA could overfit the decision boundary.

##b. If the Bayes decision boundary is non-linear, do we expect LDA or QDA to perform better on the training set? On the test set?
We expect QDA to perform better both sets.

##c. In general, as the sample size n increases, do we expect the test prediction accuracy of QDA relative to LDA to improve, decline, or be unchanged? Why?

QDA is recommended if the training set is very large, so we would expect the accuracy to be better. QDA already has a high variance. 

##d. True or False: Even if the Bayes decision boundary for a given problem is linear, we will probably achieve a superior test error rate using QDA rather than LDA because QDA is flexible enough to model a linear decision boundary. Justify your answer

False. QDA may lead to an overfit. 


```r
library(ISLR)
```

```
## Warning: package 'ISLR' was built under R version 3.4.3
```

```r
library(MASS)
```

```
## Warning: package 'MASS' was built under R version 3.4.3
```

```r
library(magrittr)
library(class)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following object is masked from 'package:MASS':
## 
##     select
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
#making indicator variable 
bos = Boston
crim01 <- rep(0, length(bos$crim))
crim01[bos$crim > median(bos$crim)] <- 1
bos2 <- data.frame(Boston, crim01)

#making indexes for training and test data, split into two
train <- 1:(length(bos$crim) / 2)
test <- (length(bos$crim) / 2 + 1):length(bos$crim)
bos.train <- bos2[train, ]
bos.test <- bos2[test, ]
crim01.test <- bos2$crim01[test]

#glm
bos.glm <- glm(crim01 ~ zn+nox+age+dis+rad+tax+ptratio+black+medv, data = bos2, family = binomial,subset=train)
```

```
## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

```r
summary(bos.glm)
```

```
## 
## Call:
## glm(formula = crim01 ~ zn + nox + age + dis + rad + tax + ptratio + 
##     black + medv, family = binomial, data = bos2, subset = train)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.1131  -0.1780  -0.0009   0.2415   3.0885  
## 
## Coefficients:
##               Estimate Std. Error z value Pr(>|z|)    
## (Intercept) -66.233571  11.236568  -5.894 3.76e-09 ***
## zn           -0.428786   0.098572  -4.350 1.36e-05 ***
## nox          81.501997  14.107158   5.777 7.59e-09 ***
## age           0.020096   0.017923   1.121   0.2622    
## dis           2.199728   0.463544   4.745 2.08e-06 ***
## rad           1.523621   0.312386   4.877 1.08e-06 ***
## tax          -0.012168   0.005396  -2.255   0.0241 *  
## ptratio       0.639813   0.164406   3.892 9.96e-05 ***
## black        -0.009557   0.005961  -1.603   0.1089    
## medv          0.094511   0.048743   1.939   0.0525 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 329.37  on 252  degrees of freedom
## Residual deviance:  91.88  on 243  degrees of freedom
## AIC: 111.88
## 
## Number of Fisher Scoring iterations: 9
```

```r
probs <- predict(bos.glm, bos.test, type = "response")
pred.glm <- rep(0, length(probs))
pred.glm[probs > 0.5] <- 1
table(pred.glm, crim01.test)
```

```
##         crim01.test
## pred.glm   0   1
##        0  71  21
##        1  19 142
```

```r
mean(pred.glm != crim01.test) #gets test error rate
```

```
## [1] 0.1581028
```

```r
#lda
bos.lda <- lda(crim01 ~ zn+nox+age+dis+rad+tax+ptratio+black+medv, data = bos2, family = binomial,subset=train)
pred.lda <- predict(bos.lda, bos.test)
table(pred.lda$class, crim01.test)
```

```
##    crim01.test
##       0   1
##   0  80  22
##   1  10 141
```

```r
mean(pred.lda$class != crim01.test)
```

```
## [1] 0.1264822
```

```r
#knn
attach(bos2)
```

```
## The following object is masked _by_ .GlobalEnv:
## 
##     crim01
```

```r
train.X <- cbind(zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, black, lstat, medv)[train, ]
test.X <- cbind(zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, black, lstat, medv)[test, ]
train.crim01 <- crim01[train]
set.seed(1)
pred.knn <- knn(train.X, test.X, train.crim01, k = 10)
table(pred.knn, crim01.test)
```

```
##         crim01.test
## pred.knn   0   1
##        0  83  21
##        1   7 142
```

```r
mean(pred.knn != crim01.test)
```

```
## [1] 0.1106719
```

K nearest neighbords has the lowest rate of error. 
