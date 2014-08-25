library(caret)
source('utils.R')

test_classes = c(
  "character",   # datetime
  "factor",      # season
  "factor",      # holiday
  "factor",      # workingday
  "factor",      # weather
  "numeric",     # temp
  "numeric",     # atemp
  "integer",     # humidity
  "numeric"      # windspeed
)

train_classes = c(test_classes, c("integer",     # casual
                                  "integer",     # registered
                                  "integer"))    # count

test <- read.csv("test.csv", colClasses = test_classes)
train_raw <- read.csv("train.csv", colClasses = train_classes)

set_up_features <- function(df) {
  df$datetime <- strptime(df$datetime, format="%Y-%m-%d %H:%M:%S")
  df$hour <- as.factor(df$datetime$hour)
  df$wday <- as.factor(df$datetime$wday)
  df$month <- as.factor(df$datetime$mon)
  df$year <- as.factor(df$datetime$year + 1900)
  # ... smth else ...
  df
}

test <- set_up_features(test)
train_raw <- set_up_features(train_raw)

set.seed(415)
inTrain <- createDataPartition(train_raw$count, p=0.7, list=F, times=1)
train <- train_raw[inTrain, ]
cv <- train_raw[-inTrain, ]  # cross-validation set
