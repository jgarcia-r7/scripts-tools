#!/usr/bin/env python3
# Template: urllib Downloads Template
# Author: Jessi
# Purpose: Download documents from a list of urls, print error if a 404 error comes up and continue.
# Standalone Usage: python3 doc_downloads.py <urlfile> <oudir> (Ex. python3 doc_downloads.py urls.txt outdir/)

import urllib.request
import sys

infile = sys.argv[1]
outdir = sys.argv[2]

print("[!] Downloading Files")

def download_url(url,filename):
    try:
        r = urllib.request.urlretrieve(url,filename)
        print(f"[+] Downloading: {url}")
    except urllib.error.HTTPError as exception:
        print(f"[X] Download Failed For: {url}")

with open(infile) as f:
   for i in f:
      url = i.rstrip()
      name = url.rsplit('/', 1)[1]
      filename = outdir + name
      download_url(url,filename)

print("[+] Done")
