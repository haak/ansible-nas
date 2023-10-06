#!/bin/bash
# script to parse tailscale hosts and output linux hosts file
# parse tailscale status check if 3rd column = odddog309@ and take first 2 columns and add to hosts file
sudo tailscale status | awk '{if ($3 == "odddog309@") print $1, $2}' | tee -a /etc/hosts
