#bash

echo 'Directory: /etc'
sudo find /etc -iname "stellar*" -print
sudo find /etc -iname "horizon*" -print
echo 'Directory: /lib'
sudo find /lib -iname "stellar*" -print
sudo find /lib -iname "horizon*" -print
echo 'Directory /var'
sudo find /var -iname "stellar*" -print
sudo find /var -iname "horizon*" -print

