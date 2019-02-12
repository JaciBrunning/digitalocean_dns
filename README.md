DigitalOcean DNS Update
===

A small docker image to continuously update DNS Records on DigitalOcean. Useful for doing your own Dynamic DNS without a static IP.  
https://hub.docker.com/r/jaci/digitalocean_dns

## Env Vars:
`API_KEY`: Your DigitalOcean API Key. _REQUIRED_.  
`DOMAIN`: The DigitalOcean Domain you wish to update. _REQUIRED_.  
`SUBDOMAIN`: The Subdomain you with to update. _REQUIRED_.  
`TTL`: The TTL, in seconds. Default: 3600 (1 Hr).  
`RATE`: The update rate, in seconds. Recommended to match TTL. Default: 3600 (1 Hr).  
`TARGET_IP`: The IP you wish to set to the A DNS Record. Default: Result of https://ipinfo.io/ip (your public IP)  
