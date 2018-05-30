sudo dd if=/dev/zero of=/swapfile  bs=512M  count=6
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
