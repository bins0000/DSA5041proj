# R-T-Test project

# Author: Nasri Binsaleh

R application to compute t-test between populations

# Introduction

The package `mypackage` runs t-test on two populations to determine whether we should reject the NULL of equality of means at the alpha level of significance.

# Functions

`myttest` takes in two populations of data x and y as a numeric vector, a Boolean argument if paired, and an alpha value. The function then runs the appropriate form of the t-test and returns all relevant information in an Rttest object.

`Rttest.print` is a print function for Rttest objects that prints several information from the t-test result.

`Rttest.plot` is a plot function for Rttest objects that plots boxplots. It creates boxplots of the data when non-paired data is analyzed. It also will make a boxplot of differences in data when paired = TRUE.

## OOP

In this package we will be using `S3` OOP -- which is the commonly used object oriented form in R package making.

See <https://adv-r.hadley.nz/s3.html> for more information.

## Documentation

There are two forms of documentation
  
  1. Function specific using Roxygen.
  2. Vignette -- long form.
  
# Constructor

The first function is `myttest`. This function computes a t-test and produces a named list of useful information, including the data, type of t-test used, confidence interval, etc.

```{r}
a <- rnorm(40, 20, 10)
b <- rnorm(30, 10, 12)

out <- myttest(x=a, y=b, paired = FALSE)
class(out)
```

Notice that the output is of class `r class(out)`

The function returns a list of components:

```{r}
names(out)
```
The components can then be operated on by an appropriate method attached to a generic.

# Methods

The methods are attached to the generic function `print()` and `plot()`

## print method

We can call it by simply invoking the `print()` function

```{r}
print(out)
```

## plot method

We can call it by simply invoking the `plot()` function

```{r}
plot(out)
```
