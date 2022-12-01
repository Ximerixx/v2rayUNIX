#V2ray version
VER="latest"
#Encryption method 'chacha20-ietf-poly1305'
ENCC="chacha20-ietf-poly1305"
#Prompt your password for V2Ray connection " 
PPW="MazhA12dREcw213fdew1F&5BFke21349CW8fvvwn!#$@$7hby878cwWCcCW7T^wdcw"
#Enter your desired V2Ray path$ starting from /. ex: /ximerixx  
V2RAYPATHH="/zbsndty6rly0sjmsmkymdja1oejgqptceuk3ercma96xchvnwj1pbq6qrfq1xnukwlwuaaacxpbvp1xn"
#your linked domain to THAT server, or Server's IP adress " 
DOMAINED_IP="mstnw.ddns.net"
#Enter your desired QR_code path (also for tightiting a security) starting from /. IT CAN'T BE THE SAME AS V2Ray PATH!!  
QR_PATH="/jtkqxmxearkd1mlnystezy02zy3u4imkpfnupmgxzmltqbdmrsfz6q3kgovwxx86ywsoxhpgdcrat2jk"
#Distraction site, if you won't fill it in, local will be used 
DISTRA=""
#port for nginx
PORT="80"


export VER
export ENCC
export PPW
export V2RAYPATHH
export DOMAINED_IP
export QR_PATH
export DISTRA
export PORT

./setup.sh



