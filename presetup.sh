if [[ `id -u` != 0 ]]; then
    echo "Must be root to run script"
    exit
fi


#V2ray version
VER="latest"
#Encryption method 'chacha20-ietf-poly1305'
ENCC="chacha20-ietf-poly1305"
#Prompt your password for V2Ray connection " 
PPW="LOLOLOLOLOL"
#Enter your desired V2Ray path$ starting from /. ex: /trax  
V2RAYPATHH="/zbs"
#your linked domain to THAT server, or Server's IP adress " 
DOMAINED_IP=">IP<"
#Enter your deired QR_code path (also for tightiting a security) starting from /. IT CAN'T BE THE SAME AS V2Ray PATH!!  
QR_PATH="/jtkqxmxearkd1mlnystezy02zy3u4imkpfnupmgxzmltqbdmrsfz6q3kgovwxx86ywsoqdwxhpgdcrat2jk"
#Distraction site, if you won't fill it in, local will be used 
DISTRA=""
#port for nginx
PORT="80"
#do you want to use SSL?
SSLC="no"

#*** NOTE if  you want to use that WITH ssl you MUST use 443 port and bind certificates on your own to nginx.conf there /etc/nginx/conf.d/ss.conf
#** if you want to use it as is you MUST use 80 default port WITHOUT SSL to host both web and vpn path


export VER
export ENCC
export PPW
export V2RAYPATHH
export DOMAINED_IP
export QR_PATH
export DISTRA
export PORT
export SSLC
 chmod +x setup.sh
./setup.sh



