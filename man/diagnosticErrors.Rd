\name{diagnosticErrors}
\alias{diagnosticErrors}

\title{Compute Diagnostic Errors: Accuracy, Sensitivity, Specificity, Positive Predictive Value, Negative Predictive Value, Log Odds Ratio}
\usage{
diagnosticErrors(cm)
}
\arguments{
  \item{cm}{a vector containing the true positives, false positives etc, as computed by \code{\link{confusionMatrix}.}
}
}

\description{
  \code{diagnosticErrors} computes various diagnostic errors useful for evaluating the performance of a diagnostic test or a classifier: accuracy (acc), sensitivity (sens), specificity (spec), positive predictive value (ppv), negative predictive value (npv), and log-odds ratio (lor). 
}

\value{
  \code{diagnostic errors} returns a vector containing various diagnostic errors.  
}

\details{
  The diagnostic errors are computed as follows:

  acc = (TP+TN)/(FP+TN+TP+FN)

  sens = TP/(TP+FN)

  spec = TN/(FP+TN)

  ppv = TP/(FP+TP)

  npv = TN/(TN+FN)

  lor = log(TP*TN/(FN*FP))
}



\author{
  Korbinian Strimmer (\url{http://strimmerlab.org}).
}
\seealso{\code{\link{confusionMatrix}}.}

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

# corresponding accuracy, sensitivity etc.
diagnosticErrors(cm)
#      acc      sens      spec       ppv       npv       lor 
#0.7142857 0.6666667 0.7500000 0.6666667 0.7500000 1.7917595
}
\keyword{univar}
