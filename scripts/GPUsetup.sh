#!/bin/bash
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y
    sudo apt-get install build-essential ubuntu-desktop make -y tmux zsh clinfo
    sudo apt-get install build-essential gcc make -y


# sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# Disable the Nouveau kernel driver, which is incompatible with the NVIDIA driver. (Only use the NVIDIA driver on NV VMs.) To do this, create a file in /etc/modprobe.d named nouveau.conf
# with the following contents:

    sudo bash -c 'echo "blacklist nouveau" >> /etc/modprobe.d/nouveau.conf'
    sudo bash -c 'echo "blacklist lbm-nouveau" >> /etc/modprobe.d/nouveau.conf'

#Reboot the VM and reconnect. Exit X server:
    sudo systemctl stop lightdm.service

    sudo systemctl stop lightdm.service
    wget -O NVIDIA-Linux-x86_64-384.73-grid.run https://go.microsoft.com/fwlink/?linkid=849941
    chmod +x NVIDIA-Linux-x86_64-384.73-grid.run
    sudo ./NVIDIA-Linux-x86_64-384.73-grid.run --ui=none --no-questions --accept-license --disable-nouveau

    # sudo systemctl stop lightdm.service
    # wget -O NVIDIA-Linux-x86_64-375.39.run http://us.download.nvidia.com/XFree86/Linux-x86_64/375.39/NVIDIA-Linux-x86_64-375.39.run
    # chmod +x NVIDIA-Linux-x86_64-375.39.run
    # sudo ./NVIDIA-Linux-x86_64-375.39.run --ui=none --no-questions --accept-license --


    # wget -O NVIDIA-Linux-x86_64-375.51.run http://us.download.nvidia.com/XFree86/Linux-x86_64/375.51/NVIDIA-Linux-x86_64-375.51.run
    # chmod +x NVIDIA-Linux-x86_64-375.51.run
    # sudo ./NVIDIA-Linux-x86_64-375.51.run --ui=none --no-questions --accept-license --disable-nouveau

    
    # ./NVIDIA-Linux-x86_64-375.39.run -x
    # cd NVIDIA-Linux-x86_64-375.39
    # wget https://raw.githubusercontent.com/aniljava/nvidia-375.39-patch-linux-4.10/master/kernel_4.10.patch
    # wget https://pkgs.rpmfusion.org/cgit/nonfree/nvidia-kmod.git/snapshot/nvidia-kmod-1168d85cdb210e26d2a9aff5970d249e1a328e41.zip
    # unzip nvidia-kmod-1168d85cdb210e26d2a9aff5970d249e1a328e41.zip
    # cp nvidia-kmod-1168d85cdb210e26d2a9aff5970d249e1a328e41/kernel_4.10.patch .
    # patch -p1 < kernel_4.10.patch
    # cd ..
    # sudo ./NVIDIA-Linux-x86_64-375.39/nvidia-installer --ui=none --no-questions --accept-license --disable-nouveau

# When you're asked whether you want to run the nvidia-xconfig utility to update your X configuration file, select Yes.

    sudo cp /etc/nvidia/gridd.conf.template /etc/nvidia/gridd.conf

#Add the following to /etc/nvidia/gridd.conf:
    sudo bash -c 'echo "IgnoreSP=TRUE" >> /etc/nvidia/gridd.conf'

#Cuda:

    CUDA_REPO_PKG=cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
    # CUDA_REPO_PKG=cuda-8-0_8.0.61-1_amd64.deb
    wget -O /tmp/${CUDA_REPO_PKG} http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/${CUDA_REPO_PKG}
    sudo dpkg -i /tmp/${CUDA_REPO_PKG}
    sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
    rm -f /tmp/${CUDA_REPO_PKG}
    sudo apt-get update
    sudo apt-get install -y cuda-drivers cuda

    bash -c 'echo "export PATH=/usr/local/cuda-9.1/bin${PATH:+:${PATH}}" >> .bashrc'
    bash -c 'echo "export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64\${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> .bashrc'

    sudo apt install -y ocl-icd-opencl-dev
    # sudo yum install ocl-icd ocl-icd-devel mesa-libGL-devel -y

sudo reboot now

if [[ $OLD_GCC ]]; then
    #statements
    sudo apt-get -y purge gcc
    sudo apt-get -y autoclean
    sudo apt-get -y autoremove


    sudo apt-get -y install python-software-properties
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
    sudo apt-get -y update
    sudo apt-get -y install gcc-4.8
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
fi

#Reboot the VM and proceed to verify the installation.

if [[ $SINGULARITY ]]; then
    sudo apt-get install -y wget make gcc libgfortran3 tmux htop git sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev bc automake m4

    VERSION=2.4.2
    wget -q https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
    tar xvf singularity-$VERSION.tar.gz
    cd singularity-$VERSION
    echo "libgomp.so" >> etc/nvliblist.conf
    ./configure --prefix=/usr/local
    make -j
    sudo make install
    cd
    sudo mkdir /home/username/mymountpoint
    echo "${1}" > pass
    echo "gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg==" > pass
    sudo bash -c 'echo "//test1diag281.file.core.windows.net/shared-fs /home/username/mymountpoint cifs nofail,vers=3.0,username=test1diag281,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
    rm pass
    sudo mount -a
fi

sudo mkdir /home/username/mymountpoint
echo "${1}" > pass
echo "gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg==" > pass
sudo bash -c 'echo "//test1diag281.file.core.windows.net/shared-fs /home/username/mymountpoint cifs nofail,vers=3.0,username=test1diag281,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
rm pass
sudo mount -a



#For updates:
#    sudo apt-get update
#    sudo apt-get upgrade -y
#    sudo apt-get dist-upgrade -y
#    sudo apt-get install cuda-drivers
#    sudo reboot