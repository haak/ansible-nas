# set the default browser to firefox when time is between 8am and 5pm
# when the time is not between 8am and 5pm, set the default browser to firefoxdeveloperedition
# get the current time
time=$(date +%H)

# test if time was 4pm
# time=16



# if the time is between 8am and 5pm and its a weekday
if [ $time -ge 8 ] && [ $time -le 17 ] && [ $(date +%u) -le 5 ]; then
    # set the default browser to firefox
    echo "between 8am and 5pm setting default browser to firefox"
    xdg-settings set default-web-browser firefox.desktop
else
    echo "not between 8am and 5pm or its a weekend setting default browser to firefoxdeveloperedition"
    # set the default browser to firefoxdeveloperedition
    xdg-settings set default-web-browser firefoxdeveloperedition.desktop
fi
# if [ $time -ge 8 ] && [ $time -le 17 ]; then
#     # set the default browser to firefox
#     xdg-settings set default-web-browser firefox.desktop
# else
#     # set the default browser to firefoxdeveloperedition
#     xdg-settings set default-web-browser firefoxdeveloperedition.desktop
# fi