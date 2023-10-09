requried manual setup

make hashed password with 
echo -n "thisismypassword" | npx argon2-cli -e

Access the webui at http://<your-ip>:8443
For github integration, drop your ssh key in to /config/.ssh

git config --global user.name "username"
git config --global user.email "email address"