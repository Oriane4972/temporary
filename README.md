````
> devtools::test()
ℹ Testing ip2location.io
✔ | F W S  OK | Context
✖ | 1      11 | get_ip_data                                                                                                                     
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Error (test-get_ip_data.R:61:3): get_ip_data handles an empty IP list
Error in `data.frame(ip = ip_addresses, country_code = c("US", "GB"), country_name = c("United States", 
    "United Kingdom"), stringsAsFactors = FALSE)`: arguments imply differing number of rows: 0, 2
Backtrace:
    ▆
 1. └─ip2location.io::get_ip_data(...) at test-get_ip_data.R:61:2
 2.   └─base::data.frame(...) at test-get_ip_data.R:20:2
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
✔ |         5 | safe_extract                                                                                                                    
⠏ |         0 | save_ip_data                                                                                                                    No data to write to CSV.
Data saved to /var/folders/c9/r2kzfbvd3298rymbvw3zxkdh0000gn/T//RtmpDGig1A/file121a3558337e8 
✔ |         5 | save_ip_data

══ Results ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
── Failed tests ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Error (test-get_ip_data.R:61:3): get_ip_data handles an empty IP list
Error in `data.frame(ip = ip_addresses, country_code = c("US", "GB"), country_name = c("United States", 
    "United Kingdom"), stringsAsFactors = FALSE)`: arguments imply differing number of rows: 0, 2
Backtrace:
    ▆
 1. └─ip2location.io::get_ip_data(...) at test-get_ip_data.R:61:2
 2.   └─base::data.frame(...) at test-get_ip_data.R:20:2

[ FAIL 1 | WARN 0 | SKIP 0 | PASS 21 ]

````
