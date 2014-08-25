get_predictions <- function(fit, test) {
  Prediction <- predict(fit, test)
  Prediction[Prediction < 0 ] <- 0
  Prediction <- as.integer(Prediction)
  data.frame(datetime=strftime(test$datetime, format="%Y-%m-%d %H:%M:%S"), count=Prediction)
}

save_predictions <- function(fit, test, filename) {
  print('Prepare results for submit...')
  print('WARNING: Model should be trained with whole training set')
  submit <- get_predictions(fit, test)
  write.csv(submit, filename, row.names=F)
}