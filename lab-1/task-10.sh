#!/bin/bash

man bash | grep -io "[a-zA-Z0-9]\{4,\}" | tr [:upper:] [:lower:] | sort | uniq -c | sort -nr | head -3
