#V2ray version
VER="latest"
#Encryption method 'chacha20-ietf-poly1305'
ENCC="chacha20-ietf-poly1305"
#Prompt your password for V2Ray connection " 
PPW="MazhA12dREcw213"
#Enter your desired V2Ray path$ starting from /. ex: /ximerixx  
V2RAYPATHH="/zbs"
#your linked domain to THAT server, or Server's IP adress " 
DOMAINED_IP="mstnw.ddns.net"
#Enter your desired QR_code path (also for tightiting a security) starting from /. IT CAN'T BE THE SAME AS V2Ray PATH!!  
QR_PATH="/jtk"
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
 chmod +x setup.sh
./setup.sh



