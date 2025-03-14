# get_ip_data.R

#' Get Data for Multiple IP Addresses
#'
#' This function takes a list of IP addresses and sends HTTP GET requests to the IP2Location.io API.
#' It returns the IP information as a data frame, handling missing fields by returning NA.
#'
#' @param ip_addresses A vector of IP addresses.
#' @param api_key Your IP2Location.io API key.
#' @param base_url The base URL for the IP2Location.io API.
#' @return A data frame with the extracted data for each IP.
#' @export
#' @importFrom httr GET status_code content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr bind_rows `%>%` group_by slice ungroup select

get_ip_data <- function(ip_addresses, api_key, base_url) {

  # Initialize an empty list to collect all the data for each IP
  all_data <- list()

  for (ip in ip_addresses) {

    # Construct the API request URL with parameters
    url <- paste0(base_url, "?key=", api_key, "&ip=", ip, "&format=json")

    # Send the GET request to the API
    response <- GET(url)

    # Check if the request was successful
    if (status_code(response) == 200) {
      # Parse the JSON response content
      response_content <- content(response, "text")
      parsed_response <- fromJSON(response_content)

      # Check if the response is valid (not empty)
      if (length(parsed_response) == 0) {
        cat("No data returned for IP:", ip, "\n")
        next  # Skip to the next IP if no data is returned
      }

      # Extracting data for each IP
      ip_data <- data.frame(
        ip = safe_extract(parsed_response, "ip"),
        country_code = safe_extract(parsed_response, "country_code"),
        country_name = safe_extract(parsed_response, "country_name"),
        region_name = safe_extract(parsed_response, "region_name"),
        district = safe_extract(parsed_response, "district"),
        city_name = safe_extract(parsed_response, "city_name"),
        latitude = safe_extract(parsed_response, "latitude"),
        longitude = safe_extract(parsed_response, "longitude"),
        zip_code = safe_extract(parsed_response, "zip_code"),
        time_zone = safe_extract(parsed_response, "time_zone"),
        asn = safe_extract(parsed_response, "asn"),
        as = safe_extract(parsed_response, "as"),
        isp = safe_extract(parsed_response, "isp"),
        domain = safe_extract(parsed_response, "domain"),
        net_speed = safe_extract(parsed_response, "net_speed"),
        idd_code = safe_extract(parsed_response, "idd_code"),
        area_code = safe_extract(parsed_response, "area_code"),
        weather_station_code = safe_extract(parsed_response, "weather_station_code"),
        weather_station_name = safe_extract(parsed_response, "weather_station_name"),
        mcc = safe_extract(parsed_response, "mcc"),
        mnc = safe_extract(parsed_response, "mnc"),
        mobile_brand = safe_extract(parsed_response, "mobile_brand"),
        elevation = safe_extract(parsed_response, "elevation"),
        usage_type = safe_extract(parsed_response, "usage_type"),
        address_type = safe_extract(parsed_response, "address_type"),
        ads_category = safe_extract(parsed_response, "ads_category"),
        ads_category_name = safe_extract(parsed_response, "ads_category_name"),
        continent_name = safe_extract(parsed_response$continent, "name"),
        continent_hemisphere = safe_extract(parsed_response$continent, "hemisphere"),
        country_capital = safe_extract(parsed_response$country, "capital"),
        country_language = safe_extract(parsed_response$country, "language"),
        region_code = safe_extract(parsed_response$region, "code"),
        time_zone_olson = safe_extract(parsed_response$time_zone_info, "olson"),
        time_zone_current_time = safe_extract(parsed_response$time_zone_info, "current_time"),
        is_proxy = safe_extract(parsed_response, "is_proxy"),
        fraud_score = safe_extract(parsed_response, "fraud_score"),
        proxy_last_seen = safe_extract(parsed_response$proxy, "last_seen"),
        proxy_type = safe_extract(parsed_response$proxy, "proxy_type"),
        proxy_threat = safe_extract(parsed_response$proxy, "threat"),
        proxy_provider = safe_extract(parsed_response$proxy, "provider"),
        proxy_is_vpn = safe_extract(parsed_response$proxy, "is_vpn"),
        proxy_is_tor = safe_extract(parsed_response$proxy, "is_tor"),
        proxy_is_data_center = safe_extract(parsed_response$proxy, "is_data_center"),
        proxy_is_public_proxy = safe_extract(parsed_response$proxy, "is_public_proxy"),
        proxy_is_web_proxy = safe_extract(parsed_response$proxy, "is_web_proxy"),
        proxy_is_web_crawler = safe_extract(parsed_response$proxy, "is_web_crawler"),
        proxy_is_residential_proxy = safe_extract(parsed_response$proxy, "is_residential_proxy"),
        proxy_is_consumer_privacy_network = safe_extract(parsed_response$proxy, "is_consumer_privacy_network"),
        proxy_is_enterprise_private_network = safe_extract(parsed_response$proxy, "is_enterprise_private_network"),
        proxy_is_spammer = safe_extract(parsed_response$proxy, "is_spammer"),
        proxy_is_scanner = safe_extract(parsed_response$proxy, "is_scanner"),
        proxy_is_botnet = safe_extract(parsed_response$proxy, "is_botnet"),
        stringsAsFactors = FALSE
      )

      # Store data with IP as the unique key
      all_data[[ip]] <- ip_data

    } else {
      # Handle request failure by printing an error message for the IP address
      cat("Request failed for IP:", ip, "with status code:", status_code(response), "\n")
    }
  }

  # After collecting the data (inside the for loop), combine all data into a single data frame
  response_data <- bind_rows(all_data)

  # Remove duplicates based on the IP column
  response_data_cleaned <- response_data %>%
    group_by(ip) %>%
    slice(1) %>%
    ungroup()

  return(response_data_cleaned)

}
