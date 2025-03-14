test_that("get_ip_data returns a data frame", {
  ip_addresses <- c("8.8.8.8", "1.1.1.1")
  api_key <- "631FA50984AAB0D95CC08D6091D44B44"
  base_url <- "https://api.ip2location.io/"
  
  result <- get_ip_data(ip_addresses, api_key, base_url)
  
  expect_true(is.data.frame(result))
  expect_true("ip" %in% colnames(result))  # Check if 'ip' column is present
})
