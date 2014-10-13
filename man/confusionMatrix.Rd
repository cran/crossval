\name{confusionMatrix}
\alias{confusionMatrix}

\title{Compute Confusion Matrix}
\usage{
confusionMatrix(actual, predicted, negative="control") 
}
\arguments{
  \item{actual}{a vector containing the actual correct labels for each sample (e.g. "cancer" or "control").}
  
  \item{predicted}{a vector containing the predicted labels.}

  \item{negative}{the label of a negative "null" sample (default: "control").}
}


\description{
  \code{confusionMatrix} computes the confusion matrix, i.e. it counts the number of false positives (FP),
  true positives (TP), true negatives (TN), and false negatives (FN).  

Despite its name the functions returns a vector rather than an actual matrix for easier use with the \code{\link{crossval}} function.
}

\value{
  \code{confusionMatrix} returns a vector of length 4 containing the counts for FP, TP, TN, and FN.  
}


\author{
  Korbinian Strimmer (\url{http://strimmerlab.org}).
}
\seealso{\code{\link{diagnosticErrors}}.}

\examples{
# load crossval library
library("crossval")

# true labels
a = c("cancer", "cancer", "control", "control", "cancer", "control", "control")

# predicted labels
p = c("cancer", "control", "control", "control", "cancer", "control", "cancer")

# confusion matrix (a vector)
cm = confusionMatrix(a, p, negative="control") 
cm
# FP TP TN FN 
# 1  2  3  1 
# attr(,"negative")
# [1] "control"

# corresponding accuracy, sensitivity etc.
diagnosticErrors(cm)
#       acc      sens      spec       ppv       npv       lor 
# 0.7142857 0.6666667 0.7500000 0.6666667 0.7500000 1.7917595
# attr(,"negative")
# [1] "control"
}
\keyword{univar}
