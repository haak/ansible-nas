# go through all the inventory files and find all ports that are assigned:

import sys
import os
import re

# get the list of inventory files
inventory = os.listdir('inventories')

# go through each inventory file
for inv in inventory:
    # open the file
    f = open('inventory/' + inv, 'r')
    # read the file
    lines = f.readlines()
    # go through each line
    for line in lines:
        # if the line is a port assignment
        if re.search('port', line):
            # print the port
            print(line)
    # close the file
    f.close()
