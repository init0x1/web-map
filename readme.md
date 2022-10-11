## web-map is a simple bash script to Automate Recon websits by doing this steps:
### 1- Gather subdomains with sublist3r.
### 2- compile third-level domains.
### 3- Gather all third-level domains with sublist3r.
### 4- probe for alive hosts.
### 5- scan alive hosts with nmap
### 6- Run eyewitness on alive hosts

## installation :
### you need to install :
### [nmap](https://github.com/nmap/nmap) 
### [Sublist3r](https://github.com/aboul3la/Sublist3r) 
### [EyeWitness](https://github.com/FortyNorthSecurity/EyeWitness) 
### [httprobe](https://github.com/tomnomnom/httprobe) 

## How to use :
```
./webmap.sh <domain>
```
## example :
```
./webmap.sh example.com
```