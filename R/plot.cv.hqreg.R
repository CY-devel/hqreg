plot.cv.hqreg <- function(x, log.l = TRUE, nvars = TRUE, ...)
{
  l <- x$lambda
  if (log.l) {
    l <- log(l)
    xlab <- expression(log(lambda))
  } else xlab <- expression(lambda)
  
  ## Calculate y
  L.cve <- x$cve - x$cvse
  U.cve <- x$cve + x$cvse
  y <- x$cve
  L <- L.cve
  U <- U.cve
  ylab = switch(x$type.measure, deviance = "Deviance", mae = "Mean Absolute Error", mse = "Mean Squared Error")
  
  ylim <- range(c(L, U))
  ind <- ((U-L)/diff(ylim) > 1e-3)
  plot.args = list(x=l, y=y, ylim=ylim, xlab=xlab, ylab=ylab, type="n", xlim=rev(range(l)), las=1)
  new.args = list(...)
  if (length(new.args)) plot.args[names(new.args)] = new.args
  do.call("plot", plot.args)
  suppressWarnings(arrows(x0=l[ind], x1=l[ind], y0=L[ind], y1=U[ind], code=3, angle=90, col="gray80", length=.03))
  points(l, y, col="red", pch=19, cex=.5)
  if (nvars) {
    nv <- predict(x$fit, lambda = x$lambda, type = "nvars")
    axis(3, at=l, labels=nv, tick=FALSE, line=-0.5)
  }
}
