Docker Images for execution of tools

# Prerequisites
You **need to Download** the images and from here: https://www.memoryanalysis.net/amf or from the course download of Fernuni-Hagen.
Extract all files to the folder `Linux-Memory-Images`.
Inside your downloaded zip file is a file called /linux/book.zip. While building the docker image 
in the next step the file will be copied into your container automatically. But be sure it is available in the place `Linux-Memory-Images/linux/book.zip`.
# Dockerfile-volatility
``` shell
docker build -t volatility -f DockerfileVolatility .
```
Run with Images mounted:
``` shell
docker run -it --rm -v ./Linux-Memory-Images/linux:/app/volatility/images  -v /usr/src:/usr/src -v /lib/modules:/lib/modules volatility  /bin/bash
```

The commands from the Course
``` shell
# 7.5.2. Getting a process list
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_pslist
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_pstree
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_psaux
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_psenv

# 7.5.3 Looking at processes
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_proc_maps -p 1
# no such option -D ?!?!
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_proc_maps -p 1 -D ~/dumps

# 7.5.4 File handles
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_lsof -p 8503
# 7.5.5 Bash history
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_bash
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_bash_hash

# 7.5.6 Networking
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_netstat
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_raw_list
# later in network forensics: python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_pkt_queues 
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_ifconfig

# Additional commands not from the course
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_proc_maps
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_psxview
python vol.py --profile=Linuxbookx64 -f images/linux-sample-1.bin linux_lsmod
```


