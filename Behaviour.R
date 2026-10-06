data <- read.csv("C:/Users/HP/Desktop/Customer_behaviour/customer_shopping_behavior.csv")


# 2. View First Rows
head(data)

# 3. Dataset Dimensions
dim(data)

# 5. Summary Statistics
summary(data)

# 6. Missing Values
colSums(is.na(data))

# 7. Duplicate Rows
sum(duplicated(data))

# 8. Unique Values of Categorical Variables
unique(data$Location)
unique(data$Condition)
unique(data$Garage)


# Check rows with missing Review Rating
data[is.na(data$Review.Rating), ]

median(data$Review.Rating, na.rm = TRUE)
data$Review.Rating[is.na(data$Review.Rating)] <- 3.8

colSums(is.na(data))


str(data)

data$Gender <- as.factor(data$Gender)

categorical_cols <- c(
  "Gender",
  "Item.Purchased",
  "Category",
  "Location",
  "Size",
  "Color",
  "Season",
  "Subscription.Status",
  "Shipping.Type",
  "Discount.Applied",
  "Promo.Code.Used",
  "Payment.Method",
  "Frequency.of.Purchases"
)

data[categorical_cols] <- lapply(data[categorical_cols], as.factor)
str(data)

dir.create("plots")

#Age ka boxplot
png("plots/customer_age_boxplot.png", width = 1200, height = 800)

boxplot(data$Age,
        main = "Boxplot of Customer Age",
        ylab = "Age")

dev.off()

boxplot(data$Purchase.Amount..USD.,
        main = "Boxplot of Purchase Amount",
        ylab = "Purchase Amount (USD)")

Q1 <- quantile(data$Purchase.Amount..USD., 0.25)
Q3 <- quantile(data$Purchase.Amount..USD., 0.75)

IQR_value <- IQR(data$Purchase.Amount..USD.)

lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

Q1
Q3
IQR_value
lower_bound
upper_bound

boxplot(data$Review.Rating,
        main = "Boxplot of Review Rating",
        ylab = "Review Rating")
Q1 <- quantile(data$Review.Rating, 0.25)
Q3 <- quantile(data$Review.Rating, 0.75)

IQR_value <- IQR(data$Review.Rating)

lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

Q1
Q3
IQR_value
lower_bound
upper_bound


boxplot(data$Previous.Purchases,
        main = "Boxplot of Previous Purchases",
        ylab = "Number of Previous Purchases")


Q1 <- quantile(data$Previous.Purchases, 0.25)
Q3 <- quantile(data$Previous.Purchases, 0.75)

IQR_value <- IQR(data$Previous.Purchases)

lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

Q1
Q3
IQR_value
lower_bound
upper_bound


unique(data$Gender)
unique(data$Category)
unique(data$Size)
unique(data$Season)
unique(data$Subscription.Status)
unique(data$Shipping.Type)
unique(data$Discount.Applied)
unique(data$Promo.Code.Used)
unique(data$Payment.Method)
unique(data$Frequency.of.Purchases)



min(data$Age)
max(data$Age)

min(data$Purchase.Amount..USD.)
max(data$Purchase.Amount..USD.)

min(data$Review.Rating)
max(data$Review.Rating)

min(data$Previous.Purchases)
max(data$Previous.Purchases)

#Feature Extraction
data$Age.Group <- cut(
  data$Age,
  breaks = c(17, 25, 35, 50, Inf),
  labels = c("Young Adult", "Adult", "Middle Age", "Senior")
)
table(data$Age.Group)

table(data$Gender)

data$Gender <- ifelse(data$Gender == "Male", 1, 0)
table(data$Gender)

table(data$Category)

category_encoded <- model.matrix(~ Category - 1, data = data)

head(category_encoded)

data <- cbind(data, category_encoded)
head(data[, c("Category",
              "CategoryAccessories",
              "CategoryClothing",
              "CategoryFootwear",
              "CategoryOuterwear")])

data$Subscription.Status <- ifelse(
  data$Subscription.Status == "Yes", 1, 0
)
table(data$Subscription.Status)

original_data <- read.csv(
  "C:/Users/HP/Desktop/Customer_behaviour/customer_shopping_behavior.csv"
)

table(original_data$Subscription.Status)

data$Subscription.Status <- ifelse(
  original_data$Subscription.Status == "Yes",
  1,
  0
)

table(data$Subscription.Status)

table(original_data$Discount.Applied)

data$Discount.Applied <- ifelse(
  original_data$Discount.Applied == "Yes",
  1,
  0
)
table(data$Discount.Applied)

table(original_data$Promo.Code.Used)

data$Promo.Code.Used <- ifelse(
  original_data$Promo.Code.Used == "Yes",
  1,
  0
)

table(data$Promo.Code.Used)

table(original_data$Size)

data$Size <- ifelse(original_data$Size == "S", 1,
                    ifelse(original_data$Size == "M", 2,
                           ifelse(original_data$Size == "L", 3, 4)))

table(original_data$Size)
table(data$Size)


table(original_data$Season)
season_encoded <- model.matrix(~ Season - 1, data = data)
head(season_encoded)

data <- cbind(data, season_encoded)
head(data[, c("Season",
              "SeasonFall",
              "SeasonSpring",
              "SeasonSummer",
              "SeasonWinter")])


table(original_data$Shipping.Type)
shipping_encoded <- model.matrix(~ Shipping.Type - 1, data = data)
head(shipping_encoded)
data <- cbind(data, shipping_encoded)


table(original_data$Payment.Method)

payment_encoded <- model.matrix(~ Payment.Method - 1, data = data)

head(payment_encoded)

data <- cbind(data, payment_encoded)

table(original_data$Frequency.of.Purchases)

frequency_encoded <- model.matrix(
  ~ Frequency.of.Purchases - 1,
  data = data
)

head(frequency_encoded)

data <- cbind(data, frequency_encoded)

numeric_cols <- c(
  "Age",
  "Purchase.Amount..USD.",
  "Review.Rating",
  "Previous.Purchases"
)

data_scaled <- data

data_scaled[numeric_cols] <- lapply(
  data_scaled[numeric_cols],
  function(x) (x - min(x)) / (max(x) - min(x))
)

summary(data_scaled[numeric_cols])

write.csv(
  data_scaled,
  "customer_shopping_behavior_transformed.csv",
  row.names = FALSE
)

getwd()