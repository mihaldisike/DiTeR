# DiTeR
Disaster Team TRevolution - Trying to do it the right way!

acess your new server via ssh

# Installation o command prompt
## Download Base Script
```
wget https://raw.githubusercontent.com/mihaldisike/DiTeR/main/setup/configure1.sh
chmod +x configure1.sh
```
## Become root
subtitute yourpasswordhere with your root password (in case not that obvious)
```
#not working "read yourpassword"
echo "$yourpasswordhere" | sudo -S -k ./configure1.sh
```
## Test Server
### Please follow instructions and don't just copy and paste. 
Copy the following code and open a new konsole tab and paste
check in
```
ssh user@remoteipaddress  -L 1080:127.0.0.1:80
systemctl status nginx.service
```
copy this line of code to see the page
```
xdg-open http://127.0.0.1:1080
#
```
or open following link in new tab
http://127.0.0.1:1080
` 
you should see a 
403 Forbidden
nginx/1.21.5
`
