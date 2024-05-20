## Disk Forensics
- file
- diskutil
- hdiutil
- jhead - Inspect EXIF-Headers
- testdisk - undelete files

## Momory Forensics



### Memory Imaging Tools
[https://forensicswiki.xyz/wiki/index.php?title=Tools:Memory_Imaging](https://web.archive.org/web/20220210004601/https://forensicswiki.xyz/wiki/index.php?title=Tools:Memory_Imaging)
#### Windows Hardware
- **WindowsSCOPE CaptureGUARD PCIe card (Commercial)**:
  - Desktops, servers
  - Supports all Windows OS, windd and other formats
  - Performs DRAM acquisition on locked computers
  - More Info: http://www.windowsscope.com

- **WindowsSCOPE CaptureGUARD ExpressCard (Commercial)**:
  - Laptop applications
  - Similar capabilities and support as the PCIe card
  - More Info: http://www.windowsscope.com

#### Windows Software
- **Belkasoft Live RAM Caputer**:
  - Kernel-mode operation
  - Supports all Windows OS; designed for forensics
  - More Info: http://forensic.belkasoft.com/en/ram-capturer

- **WindowsSCOPE Pro and Ultimate**:
  - Analyzes physical and virtual memory
  - Supports all Windows OS, proprietary and standard formats
  - More Info: http://www.windowsscope.com

- **WindowsSCOPE Live**:
  - Allows live memory analysis from Android devices
  - More Info: http://www.windowsscope.com

- **WinPmem**:
  - Free, open source tool
  - Supports Windows XP to Windows 8, 32 and 64 bit
  - More Info: https://github.com/VolatilityFoundation/Volatility

#### Linux
- **LiME (Linux Memory Extractor)**:
  - Acquires volatile memory, supports network dumping
  - GitHub Repo: https://github.com/504ensicsLabs/LiME

- **fmem**:
  - Kernel module creating /dev/fmem for unrestricted memory access
  - GitHub Repo: https://github.com/n0fate/fmem

#### Mac OS X
- **Mac Memory Reader**:
  - Simple tool to capture physical RAM, available free
  - Supports Mac OS X 10.4 to 10.7 on 32- and 64-bit machines

- **OSXPMem**:
  - Acquires physical memory, supports multiple formats
  - GitHub Repo: https://github.com/google/rekall

#### Virtual Platforms
- **Qemu**:
  - Dumps memory of running images
  - Command: `pmemsave 0 0x20000000 /tmp/dumpfile`

- **Xen**:
  - Live dumps memory of a guest domain
  - Command: `sudo xm dump-core -L /tmp/dump-core-6 6`

- **VMWare ESXi**:
  - Snapshot includes memory
  - Commands to manage snapshots via SSH
