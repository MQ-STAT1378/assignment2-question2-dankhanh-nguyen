test_that("test Multiserver works", {
  expect_error(Multiserver(-10,-20,-3), "Arrivals, ServiceTimes must be positive & NumServers must be positive")
  expect_error(Multiserver(c(20,57),9,2), "Arrivals and ServiceTimes must have the same length")
  expect_length(Multiserver(bank$arrival_time[2],bank$service_time[2],2), 4)
})
