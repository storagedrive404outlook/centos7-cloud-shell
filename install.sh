wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
read -p "Paste authtoken here (Copy and Ctrl+V to paste then press Enter): " CRP
./ngrok authtoken $CRP 
nohup ./ngrok tcp 5900 &>/dev/null &
echo Please wait for installing...
sudo apt update -y > /dev/null 2>&1
echo "Installing QEMU (2-3m)..."
sudo apt install qemu-system-x86 qemu qemu-system curl -y > /dev/null 2>&1
echo Downloading Windows Disk...
wget https://cloud-images.ubuntu.com/bionic/current/ubuntu-18.04-server-cloudimg-amd64.img
sudo apt-get install cloud-image-utils
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'

cat >user-data <<EOF
#cloud-config
password: asdfqwer
chpasswd: { expire: False }
ssh_pwauth: True
EOF

cloud-localds user-data.img user-data

# user-data.img MUST come after the rootfs. 
qemu-system-x86_64 \
-drive file=ubuntu-18.04-server-cloudimg-amd64.img,format=qcow2 \
-drive file=user-data.img,format=raw -vnc :1 -m 8192
echo "Ubuntu 18.04 TLS Server x64 Lite On Google Colab"
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Note: Use Right-Click Or Ctrl+C To Copy"
echo "Please Keep Colab Tab Open, Maximum Time 12h"
echo Script by Storagedrive404outlook
sudo qemu-system-x86_64 -vnc :0 -hda ubuntu.img  -smp cores=2  -m 8192M  > /dev/null 2>&1
