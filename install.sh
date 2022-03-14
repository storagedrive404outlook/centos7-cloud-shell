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
wget http://mirror.myfahim.com/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso
read -p "echo Enter Hard Disk Size 20G recomended: " CRP
qemu img create centos7.vmdk $CRP
echo "Centos 7 Core x64 Lite On Google Colab"
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Note: Use Right-Click Or Ctrl+C To Copy"
echo "Please Keep Colab Tab Open, Maximum Time 12h"
echo Script by Storagedrive404outlook
sudo qemu-system-x86_64 -vnc :0 -cdrom CentOS-7-x86_64-Minimal-2009.iso -hda centos7.vmdk  -smp cores=2  -m 8192M  > /dev/null 2>&1
