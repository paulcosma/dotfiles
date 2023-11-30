# Arch Linux - how to run a cronjob
https://unix.stackexchange.com/questions/261864/arch-linux-how-to-run-a-cron-job
https://github.com/groovemonkey/tutorialinux-systemd-timers

There is no crond.service on Arch Linux
Using systemd/Timers as a cron replacement.

```bash
{
    sudo mkdir -p /media/nfs
    sudo cp media-nfs.mount /etc/systemd/system/media-nfs.mount
    sudo cp media-nfs.automount /etc/systemd/system/media-nfs.automount
    sudo mkdir -p /media/nfsro
    sudo cp media-nfsro.mount /etc/systemd/system/media-nfsro.mount
    sudo cp media-nfsro.automount /etc/systemd/system/media-nfsro.automount
    ls /etc/systemd/system/
}
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable media-nfs.automount
sudo systemctl start media-nfs.automout
sudo systemctl enable media-nfsro.automount
sudo systemctl start media-nfsro.automout
```
