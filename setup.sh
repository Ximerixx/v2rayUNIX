#!/bin/bash

#installing essential packets
	apt update -y \
    && apt upgrade -y \
    && apt install -y wget unzip qrencode\
    && apt install -y shadowsocks-libev\
    && apt install -y nginx\
    && apt autoremove -y

#v2ray-plugin版本
#remembering our script path
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
promtsword=", if you don't sure type: "
secword=" (it can be used for tightenin the security) "
#let us know that user passes an argument
if [ VER = "" ]
#if no, asks user
then 
  read -p "V2ray version $promtsword'latest' :" VER
  read -p "Encryption method $promtsword 'chacha20-ietf-poly1305' " ENCC
  read -p "Prompt your password for V2Ray connection " PPW
  read -p "Enter your desired V2Ray path$secwordstarting from /. ex: /ximerixx " V2RAYPATHH
  read -p "your linked domain to THAT server, or Server's IP adress " DOMAINED_IP
  read -p "Enter your desired QR_code path (also for tightiting a security) starting from /. IT CAN'T BE THE SAME AS V2Ray PATH!! " QR_PATH
  read -p "Distraction site, if you won't fill it in, local will be used " DISTRA
#if yes, make agruments like a variables there
fi

#gathering variavles from aruments sction


echo "Be really sure that you won't tell them anybody, or foget"
echo "So settings are:" 
echo V2Ray version $VER
echo Encryption method $ENCC
echo V2Ray password $PPW
echo V2ray path $V2RAYPATHH
echo Domain, or server ip $DOMAINED_IP
echo QR path $QR_PATH
echo Distraction site $DISTRA









if [$VER ="" ]; then
  VER="latest"
fi
echo $VER

if [$PPW ="" ]; then
  PASSWORD="5c301bb8-6c77-41a0-a606-4ba11bbab084"
fi
echo $PASSWORD

if [$ENCC="" ]; then
  ENCRYPT="chacha20-ietf-poly1305"
fi


if [$V2RAYPATHH ="" ]; then
  V2RAYPATHH="/s233"
fi
echo ${V2RAYPATHH}

if [$QR_PATH ="" ]; then
  QR_PATH="/qr_img"
fi
echo ${QR_PATH}


if [ "$VER" = "latest" ]; then
  V_VER=`wget -qO- "https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest" | sed -n -r -e 's/.*"tag_name".+?"([vV0-9\.]+?)".*/\1/p'`
  [[ -z "${V_VER}" ]] && V_VER="v1.3.0"
else
  V_VER="v$VER"
fi
echo "Done checking versions"
mkdir ./v2raybin
cd ./v2raybin
V2RAY_URL="https://github.com/shadowsocks/v2ray-plugin/releases/download/${V_VER}/v2ray-plugin-linux-amd64-${V_VER}.tar.gz"
echo ${V2RAY_URL}
wget --no-check-certificate ${V2RAY_URL}
echo "Done downloading v2ray"
tar -zxvf v2ray-plugin-linux-amd64-$V_VER.tar.gz
echo "unpacked..."
rm -rf v2ray-plugin-linux-amd64-$V_VER.tar.gz
echo "removing unnesesrly shit"
mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin
echo "moved to pluging directory"
rm -rf ./v2raybin
echo "clears out template"
cd $SCRIPTPATH
echo "done with v2RAY!!!"

mv wwwroot.tar /usr/share/nginx/html
echo "moving to wwwroot..."
cd /usr/share/nginx/html
echo "going to..."
tar -xvf wwwroot.tar
echo "unpacking..."
rm -rf wwwroot.tar
echo "deliting temp acrhive"
cd $SCRIPTPATH


echo "checking for existinf shadowsocks directory"
if [ ! -d /etc/shadowsocks-libev ]; then  
  mkdir /etc/shadowsocks-libev
fi

# TODO: bug when PASSWORD contain '/'
echo "making config"
mkdir /conf/
sed -e "/^#/d"\
    -e "s/\${PASSWORD}/${PASSWORD}/g"\
    -e "s/\${ENCRYPT}/${ENCRYPT}/g"\
    -e "s|\${V2RAYPATHH}|${V2RAYPATHH}|g"\
    $SCRIPTPATH/conf/shadowsocks-libev_config.json >  /etc/shadowsocks-libev/config.json
echo /etc/shadowsocks-libev/config.json
cat /etc/shadowsocks-libev/config.json


echo "handling proxy..."
if [ DISTRA="" ]; then
  s="s/proxy_pass/#proxy_pass/g"
  echo "site:use local wwwroot html"
else
  s="s|\${DISTRA}|${DISTRA}|g"
  echo "site: ${DISTRA}"
fi

sed -e "/^#/d"\
    -e "s/\${PORT}/${PORT}/g"\
    -e "s|\${V2RAYPATHH}|${V2RAYPATHH}|g"\
    -e "s|\${QR_PATH}|${QR_PATH}|g"\
    -e "$s"\
    $SCRIPTPATH/conf/nginx_ss.conf > /etc/nginx/conf.d/ss.conf
echo /etc/nginx/conf.d/ss.conf
cat /etc/nginx/conf.d/ss.conf


if [ "$DOMAINED_IP" = "" ]; then
  echo "不生成二维码"
else
  [ ! -d /usr/share/nginx/html/${QR_PATH} ] && mkdir /usr/share/nginx/html/${QR_PATH}
  plugin=$(echo -n "v2ray;path=${V2RAYPATHH};host=${DOMAINED_IP};tls" | sed -e 's/\//%2F/g' -e 's/=/%3D/g' -e 's/;/%3B/g')
  ss="ss://$(echo -n ${ENCRYPT}:${PASSWORD} | base64 -w 0)@${DOMAINED_IP}:443?plugin=${plugin}" 
  echo "${ss}" | tr -d '\n' > /usr/share/nginx/html/${QR_PATH}/index.html
  echo -n "${ss}" | qrencode -s 6 -o /usr/share/nginx/html/${QR_PATH}/vpn.png
fi

ss-server -c /etc/shadowsocks-libev/config.json &
rm -rf /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'