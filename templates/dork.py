#!/usr/bin/env python3
# Template: Google Dorking Template
# Author: Jessi
# Purpose: Google Dork a given domain for common file types, write URLs to output file.
# Standalone Usage: python3 dork.py <domain> <outfile> (Ex. python3 dork.py domain.com urls.txt)

from googlesearch import search
import sys

# Get Arguments
domain = sys.argv[1]
outfile = sys.argv[2]

# Define fileTypes Dictionary
fileTypes = ["pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx"]

# Open Results File
f = open(outfile, "a")

# Define Dork Function
def dork(domain,ft):
    query = "site:" + domain + " filetype:" + ft
    print(f"[+] Dorking {domain} for {ft} files")
    try:
        for result in search(query, num_results=100):
            f.write(f'{result}\n')
    except:
        print(f"[X] Dork failed for: {ft}")
        print("Failure is likely due to too many requests...")
        print("Try again later\n")

for ft in fileTypes:
    dork(domain,ft)

# Close Results File
f.close()
