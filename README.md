> devtools::test()
ℹ Testing ip2location.io
✔ | F W S  OK | Context
✔ |         2 | get_ip_data                                                                                                                     
✔ |         5 | safe_extract                                                                                                                    
⠏ |         0 | save_ip_data                                                                                                                    No data to write to CSV.
No data to write to CSV.
Data saved to /var/folders/c9/r2kzfbvd3298rymbvw3zxkdh0000gn/T//RtmpDGig1A/file121a3646ad33c 
✖ | 1       5 | save_ip_data
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Failure (test-save_ip_data.R:55:3): save_ip_data handles invalid output file path
`{ ... }` did not throw the expected error.
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

══ Results ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
── Failed tests ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Failure (test-save_ip_data.R:55:3): save_ip_data handles invalid output file path
`{ ... }` did not throw the expected error.

[ FAIL 1 | WARN 0 | SKIP 0 | PASS 12 ]
