# this script looks through all yml files for _port: and prints them to screen

#TODO: dont print duplicates.
#TODO: pretty print name of service and port
#TODO: add option to find gaps in port numbers

# get all yml files
ymlfiles=$(find . -name "*.yml")

# loop through all yml files
for ymlfile in $ymlfiles

do
    # get all lines with _port:
    ports=$(grep -E "_port:" $ymlfile)

    # loop through all lines with _port:
    for port in $ports
    do
        # print the port
        echo $port
    done
done
