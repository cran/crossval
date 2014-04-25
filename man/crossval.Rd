\name{crossval}
\alias{crossval}

\title{Generic Function for Cross Valdidation }
\usage{
crossval(predfun, X, Y, K=10,  B=20, verbose=TRUE, ...)
}
\arguments{
  \item{predfun}{Prediction function (see details).}
  \item{X}{Matrix of predictors (columns correspond to variables).} 
  \item{Y}{Univariate response variable.}
  \item{K}{Number of folds.}
  \item{B}{Number of repetitions.}
  \item{verbose}{If \code{verbose=TRUE} then status messages appear during cross validation.}
  \item{...}{optional arguments for \code{predfun}}
}
\description{
  \code{crossval} performs K-fold cross validation with B repetitions.  If \code{Y} is a factor then balanced sampling is used (i.e. in each fold each category is represented in appropriate proportions).
}

\value{
  \code{crossval} returns a list with three entries:

  stat.cv:  the statistic returned by predfun for each cross validation run.

  stat: the statistic returned by predfun averaged over all cross validation runs.

  stat.se: the corresponding standard error.
}

\details{
   The argument \code{predfun} must be a function of the form 
     \code{predfun(Xtrain, Ytrain, Xtest, Ytest, ...)}.  
}

\author{
 Korbinian Strimmer (\url{http://strimmerlab.org}).
}

\seealso{\code{\link{confusionMatrix}}.}

\examples{
# load "crossval" package
library("crossval")

# classification examples

# set up lda prediction function
predfun.lda = function(train.x, train.y, test.x, test.y, negative)
{
  require("MASS") # for lda function

  lda.fit = lda(train.x, grouping=train.y)
  ynew = predict(lda.fit, test.x)$class

  # count TP, FP etc.
  out = confusionMatrix(test.y, ynew, negative=negative)

  return( out )
}


# Student's Sleep Data
data(sleep)
X = as.matrix(sleep[,1, drop=FALSE]) # increase in hours of sleep 
Y = sleep[,2] # drug given 
plot(X ~ Y)
levels(Y) # "1" "2"
dim(X) # 20  1

set.seed(12345)
cv.out = crossval(predfun.lda, X, Y, K=5, B=20, negative="1")

cv.out$stat
# FP   TP   TN   FN 
#0.60 1.08 1.40 0.92

diagnosticErrors(cv.out$stat)
#     acc      sens      spec       ppv       npv       lor 
#0.6200000 0.5400000 0.7000000 0.6428571 0.6034483 1.0076405 


\dontrun{

# Wine Data - see http://archive.ics.uci.edu/ml/datasets/Wine for details
wine.data = read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data",
          sep=",")
c = wine.data[,1]
X = as.matrix(wine.data[c!=3,-1])
Y = as.factor(c[c!=3])
dim(X) # 130  13
levels(Y) # "1", "2"

set.seed(12345)
cv.out = crossval(predfun.lda, X, Y, K=5, B=50, negative="1")

cv.out$stat
#   FP     TP     TN     FN 
# 0.028 14.092 11.772  0.108

diagnosticErrors(cv.out$stat)
#      acc       sens       spec        ppv        npv        lor 
# 0.9947692  0.9923944  0.9976271  0.9980170  0.9909091 10.9125059 
}


# linear regression example

data("attitude")
y = attitude[,1] # rating variable
x = attitude[,-1] # date frame with the remaining variables
is.factor(y) # FALSE

summary( lm(y ~ . , data=x) )

# set up lm prediction function
predfun.lm = function(train.x, train.y, test.x, test.y)
{
  lm.fit = lm(train.y ~ . , data=train.x)
  ynew = predict(lm.fit, test.x )

  # compute squared error risk (MSE)
  out = mean( (ynew - test.y)^2 )

  return( out )
}


# prediction MSE using all variables
set.seed(12345)
cv.out = crossval(predfun.lm, x, y, K=5, B=20)
c(cv.out$stat, cv.out$stat.se) # 68.06480  2.91447

# and only two variables
cv.out = crossval(predfun.lm, x[,c(1,3)], y, K=5, B=20)
c(cv.out$stat, cv.out$stat.se) # 52.855325  1.878877



# for more examples (e.g. using cross validation in a regression or classification context)
# see the R packages "sda", "care", or "binda".

}
\keyword{multivariate}

