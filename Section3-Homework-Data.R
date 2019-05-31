  #Data
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Solution

MonthlyProfit <- revenue - expenses


ProfitAfterTax <- MonthlyProfit * 0.7
ProfitAfterTax

ProfitMargin <- round(ProfitAfterTax / revenue * 100)
ProfitMargin

averagePAT <- mean(ProfitAfterTax)

goodMonths <- ProfitAfterTax > averagePAT
badMonths <- ProfitAfterTax < averagePAT

bestMonth <- ProfitAfterTax == max(ProfitAfterTax)
bestMonth

worstMonth <- ProfitAfterTax == min(ProfitAfterTax)
worstMonth




#units of thousands
revenue.1000 <- round(revenue / 1000)
revenue.1000
expenses.1000 <- round(expenses / 1000)
ProfitAfterTax.1000 <- round(ProfitAfterTax / 1000)
MonthlyProfit.1000 <- round(MonthlyProfit / 1000)


#output
revenue.1000
expenses.1000
MonthlyProfit.1000
ProfitAfterTax.1000
ProfitMargin
goodMonths
badMonths
bestMonth
worstMonth

#matrices
m <- rbind(
  revenue.1000,
  expenses.1000,
  MonthlyProfit.1000,
  ProfitAfterTax.1000,
  ProfitMargin,
  goodMonths,
  badMonths,
  bestMonth,
  worstMonth
)
m
