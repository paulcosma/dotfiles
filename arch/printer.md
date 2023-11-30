# Printer Brother HL-1210W
https://www.reddit.com/r/archlinux/comments/nblaku/brother_hl1223we_archlinux_drivers/
- support.brother.com points to driver for hl1210w when your model is selected, so try installing https://aur.archlinux.org/packages/brother-hl1210w/

```bash
yay -S brother-hl1210w
```
- Connecting to a HL-1212W I had to use the printer IP (socket://<get_data_from_vault>:9100) to get it printing. In case the instruction below don't work for you.

Check drivers
```bash
lpinfo -m | grep -i brother
lpinfo -v
```

Install cups
```bash
sudo pacman -S cups
sudo systemctl enable cups
sudo systemctl start cups
```
- Open browser http://localhost:631
- Go to Administration and login with your Arch user and password
- Add printer "Discovered Network Printer"
- Printer IP = <get_data_from_vault>

DNS fix
https://bbs.archlinux.org/viewtopic.php?id=268710
```bash
#Change /etc/systemd/resolved.conf
sudo vi /etc/systemd/resolved.conf
#Under [Resolve]
#Add
MulticastDNS=false
```
```bash
sudo pacman -S nss-mdns
sudo systemctl enable avahi-daemon.service
sudo systemctl restart avahi-daemon.service
# Then, edit the file /etc/nsswitch.conf and change the hosts line to include mdns_minimal [NOTFOUND=return] before resolve and dns: 
sudo vi /etc/nsswitch.conf
hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns
```
Reboot
